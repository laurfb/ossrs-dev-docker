#Build on Ubuntu
FROM ossrs/srs:ubuntu20 as build
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]
RUN apt update -y && apt install -y curl git gcc g++ make patch unzip perl libasan5

#Clone and build OSSRS (develop)
WORKDIR /tmp
RUN git clone -b develop https://github.com/ossrs/srs.git srs
WORKDIR /tmp/srs/trunk
RUN ./configure --gb28181=on --h265=on --srt=on && make && make install

#Copy libs & conf files in image (ubuntu latest)
FROM ubuntu:latest AS dist
ENV PATH="$PATH:/usr/local/srs/objs/ffmpeg/bin"
COPY --from=build /usr/local/bin/ffmpeg /usr/local/srs/objs/ffmpeg/bin/ffmpeg
COPY --from=build /usr/local/srs /usr/local/srs
COPY . conf_me.conf /usr/local/srs/conf/
COPY . server.key /usr/local/srs/conf/
COPY . server.crt /usr/local/srs/conf/

# Default workdir, ports used/exposed and running commands.
VOLUME /logs
EXPOSE 1935 1985 1990 8000/udp 8080 8088 10080/udp
WORKDIR /usr/local/srs
ENV SRS_LOG_TANK=console SRS_DAEMON=off
CMD ["./objs/srs", "-c", "conf/conf_me.conf"]
