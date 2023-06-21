#Build on latest Ubuntu
FROM ubuntu:latest as build
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt upgrade -y && apt install -y git gcc g++ make unzip automake tclsh cmake pkg-config ffmpeg

#Clone and build OSSRS (develop)
WORKDIR /tmp
RUN git clone -b develop https://github.com/ossrs/srs.git srs
WORKDIR /tmp/srs/trunk
RUN ./configure --gb28181=on --h265=on && make && make install

#Copy libs & conf files in image (ubuntu latest)
FROM ubuntu:latest AS dist
COPY --from=build /usr/local/srs /usr/local/srs
COPY --from=build /usr/bin/ffmpeg /usr/local/srs/objs/ffmpeg/bin/ffmpeg
COPY . conf_me.conf /usr/local/srs/conf/

# Default workdir, ports used/exposed and command.
VOLUME /logs
EXPOSE 1935 1985 1990 8000/udp 8080 8088 10080/udp
WORKDIR /usr/local/srs
ENV SRS_LOG_TANK=console SRS_DAEMON=off
CMD ["./objs/srs", "-c", "conf/conf_me.conf"]