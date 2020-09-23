# A FileRun docker image on Alpine Linux

[FileRun](https://github.com/filerun) is a self-hosted Google Drive/Photos/Music alternative. It's a full-features web based file manager with exceptionally well-polished user interface.

I was looking for a docker image to run on my ODroid HC2 NAS for the choice of web file manager. FileRun's [official documentation](https://docs.filerun.com/docker-arm) requires downloading a 800M+ [PHP image](https://hub.docker.com/r/afian/filerun) based on Apache (what?) and a 300M+ MariaDB image. I don't want to spend 1GB space on just a simple file manager ([filebrowser](https://hub.docker.com/r/filebrowser/filebrowser) is only 30 MB. So I decide to build my own stack.

Features
-----
* Alpine base image (3.12)
* nginx
* PHP 7.3

Usage
----

Use docker volumes to map `/user-files` to the file root folder, `/usr/share/nginx/html` to nginx root, `/var/lib/mysql` to maria database.

```
$ docker-compose up -d
```

The default FileRun credentials are as follows:

* Username: superuser
* Password: superuser

Improvement
----
I ended up creating two new docker images, one running nginx and another running php-fpm, due to the way PHP on nginx works (as opposite to Apache modules). For the custom php-fpm, I have followed the offical docker build and rewrote significantly on all the steps. This turns out to be much cleaner. For the nginx image, the increased size is mostly because of a pre-downloaded filerun zip file, that would be extracted to the html root the first time the container is created. I also added a modified version of init sql script to load when the mariadb loads (original copy is from https://github.com/filerun/docker-arm32v7).

Size
----
My goal is to keep the size down. The final size is:
* henryouly/filerun-alpine ![Docker Image Version (tag)](https://img.shields.io/docker/v/henryouly/filerun-alpine) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/henryouly/filerun-alpine/arm)
* henryouly/filerun-alpine-php-fpm ![Docker Image Version (tag)](https://img.shields.io/docker/v/henryouly/filerun-alpine-php-fpm) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/henryouly/filerun-alpine-php-fpm/arm)

Total on-disk size is below 100 MB.

I also used the mariadb image from https://github.com/yobasystems/alpine-mariadb, which is 188 MB at this point. I looked at https://github.com/jbergstroem/mariadb-alpine but didn't end up using it due to the arch mismatch. Maybe will take a look at building a arm32v7 version some day.

Thanks to these projects. My work has been improved based on their work:
* https://github.com/filerun/docker-arm32v7
* https://github.com/yobasystems/alpine-mariadb
* https://github.com/TrafeX/docker-php-nginx
* https://github.com/jbergstroem/mariadb-alpine
