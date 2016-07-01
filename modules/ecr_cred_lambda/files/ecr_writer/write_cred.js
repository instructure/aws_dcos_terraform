var zlib = require('zlib')
var tar = require('tar-stream')
var AWS = require('aws-sdk')
var s3 = new AWS.S3()
var ecr = new AWS.ECR()

var config = require('./config.json')

function buildJson(endpoint, token) {
  var j = {auths: {}}
  j.auths[endpoint] = {
    auth: token
  }
  return JSON.stringify(j, 0, 2)
}

function buildTarball(dockerCfg, cb) {
  var bufs = []
  var pack = tar.pack()
  var gzip = zlib.createGzip()
  pack.entry({name: '.docker/config.json'}, dockerCfg)
  var res = pack.pipe(gzip)

  res.on('data', function(b) {
    bufs.push(b)
  })
  res.on('error', function(err) {
    cb(err)
  })
  res.on('end', function() {
    cb(null, Buffer.concat(bufs))
  })
  pack.finalize()
}

function writeEcr(registryId, targetBucket, targetKey, cb) {
  ecr.getAuthorizationToken({
    registryIds: [registryId]
  }, function(err, data) {
    if (err) return cb(err)
    if (!data.authorizationData) return cb(new Error('missing authorizationData'))
    if (!data.authorizationData[0]) return cb(new Error('missing authorizationData element'))
    var authData = data.authorizationData[0]
    var dockerCfg = buildJson(authData.proxyEndpoint, authData.authorizationToken)
    buildTarball(dockerCfg, function(err, body) {
      if (err) return cb(err)
      s3.putObject({Bucket: targetBucket, Key: targetKey, Body: body}, cb)
    })
  })
}
exports.handler = function(event, context) {
  writeEcr(config.registryId, config.targetBucket, config.targetKey, function(err) {
    if (err) return context.fail(err)
    context.succeed('uploaded to ' + config.targetBucket + '/' + config.targetKey)
  })
}

if (module === require.main) {
  exports.handler({event: 'mockEvent'}, {
    fail: function(err) {
      throw err
    },
    succeed: function(info) {
      console.log('it worked', info)
    }
  })
}
