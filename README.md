# A FileRun docker image on Alpine Linux

[FileRun](https://github.com/filerun) is a self-hosted Google Drive/Photos/Music alternative. It's a full-features web based file manager with exceptionally well-polished user interface.

I was looking for a docker image to run on my ODroid HC2 NAS for the choice of web file manager. FileRun's [official documentation](https://docs.filerun.com/docker-arm) requires downloading a 800M+ [PHP image](https://hub.docker.com/r/afian/filerun) based on Apache (what?) and a 300M+ MariaDB image. I don't want to spend 1GB space on just a simple file manager. So I decide to build my own.

Features
-----
* Alpine base image (3.12)
* nginx
* PHP 7.3

Usage
----
```
$ docker-compose up -d
```

Size
----
My goal is to keep the size down. The final size is:
* nginx 29 MB
* php-fpm 79.6 MB

Total size is around 110 MB.

I also used the mariadb image from https://github.com/yobasystems/alpine-mariadb, which is 188 MB at this point. I looked at https://github.com/jbergstroem/mariadb-alpine but didn't end up using it due to the arch mismatch. Maybe will take a look at building a arm32v7 version some day.

Thanks to these projects. My work has been improved based on their work:
* https://github.com/filerun/docker-arm32v7
* https://github.com/yobasystems/alpine-mariadb
* https://github.com/TrafeX/docker-php-nginx
* https://github.com/jbergstroem/mariadb-alpine
