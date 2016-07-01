output "repo_names" {
  value = "${join(",", aws_ecr_repository.repo.*.name)}"
}
