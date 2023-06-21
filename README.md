Docker for **OSSRS / SRS** (Simple Realtime Server) - https://github.com/ossrs/srs.

Build **SRS v6.0** dev version on **ubuntu:latest**

All credit should go to the original tool author(s) - this is just a dockerization for portability!

# Build docker

>docker build --no-cache -t docker_image_name .

**Obs.:** replace **server.crt** and **server.key** with your own! Also adapt conf file to your needs.

# Run SRS in docker

>docker run -p 1935:1935 -p 1985:1985 -p 1990:1990 -p 8080:8080 -p 8085:8085 -p 8088:8088 -p 8000:8000 -p 10080:10080 docker_image_name

**Exposed/Used ports:** 1935 - rtmp, 1985 - http api, 1990 - https api, 8080 - http server, 8088 - https server, 8000 - WebRTC, 10080 - SRT

Note:
=====
#**Test with ffmpeg:**

**Push RTMP stream:** 

>ffmpeg -i input -c:v libx264 -profile main -preset veryfast -tune zerolatency -c:a aac -b:a 256K -f flv rtmp://your_srs_docker_adress:1935/live/your_live_stream_key

**Push SRT stream:** 

>ffmpeg -i input -c:v libx264 -profile main -preset veryfast -tune zerolatency -c:a aac -b:a 256K -f mpegts srt://your_srs_docker_adress:10080?streamid=#!::r=live/your_live_stream_key,m=publish

<br>
**Play RTMP stream:**

>ffplay-fflags nobuffer rtmp://your_srs_docker_adress/live/your_live_stream_key -x 640 -y 360

**Play SRT stream:**

>ffplay-fflags nobuffer srt://your_srs_docker_adress:10080?streamid=#!::r=live/your_live_stream_key,latency=200,m=request -x 640 -y 360

**Play HLS (http/https) stream:**

>ffplay-fflags nobuffer http(s)://your_srs_docker_adress:8080(8088)/live/your_live_stream_key.m3u8 -x 640 -y 360

**Play FLV (http/https) stream:**

>ffplay-fflags nobuffer http(s)://your_srs_docker_adress:8080(8088)/live/your_live_stream_key.flv -x 640 -y 360

ReleaseNote
============

Initial release.
