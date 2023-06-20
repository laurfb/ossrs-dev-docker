Docker for **OSSRS / SRS** (Simple Realtime Server) - https://github.com/ossrs/srs.

Build **SRS v6.0** dev version on **ubuntu:latest**

# Build docker

>docker build --no-cache -t docker_image_name .

**Obs.:** replace **server.crt** and **server.key** with your own!

# Run SRS in dev docker

>docker run -p 1935:1935 -p 1985:1985 -p 1990:1990 -p 8080:8080 -p 8085:8085 -p 8088:8088 -p 8000:8000 -p 10080:10080 docker_image_name

**Exposed/Used ports:** 1935 - rtmp, 1985 - http api, 1990 - https api, 8080 - http server, 8088 - https server, 8000 - WebRTC, 10080 - SRT

Note:
=====
#**Test with ffmpeg:**

**push rtmp stream:** 

>ffmpeg -i input -c:v libx264 -profile main -preset veryfast -tune zerolatency -c:a aac -b:a 256K -f flv rtmp://your_srs_docker_adress/live/your_live_stream_key

**play rtmp stream:**

>ffplay rtmp://your_srs_docker_adress/live/your_live_stream_key

ReleaseNote
============

Initial release.
