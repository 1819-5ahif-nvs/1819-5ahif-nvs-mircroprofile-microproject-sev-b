@echo off
call mvn clean package
call docker build -t at.htl.berge/MicroProfile .
call docker rm -f MicroProfile
call docker run -d -p 8080:8080 -p 4848:4848 --name MicroProfile at.htl.berge/MicroProfile