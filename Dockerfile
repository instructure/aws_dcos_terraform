FROM uzyexe/terraform

RUN mkdir /app/
WORKDIR /app/
COPY . /app/

ENTRYPOINT []
CMD ["/app/validate.sh", "true"]
