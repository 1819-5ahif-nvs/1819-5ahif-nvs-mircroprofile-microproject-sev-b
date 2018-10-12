#!/bin/sh
mvn clean package && docker build -t at.htl.berge/MicroProfile .
docker rm -f MicroProfile || true && docker run -d -p 8080:8080 -p 4848:4848 --name MicroProfile at.htl.berge/MicroProfile