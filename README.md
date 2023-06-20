Docker for OSSRS / SRS (Simple Realtime Server) - https://github.com/ossrs/srs.
#Usage >>>> Build docker

docker build --no-cahe -t docker_image_name .

# >>>> Run SRS in dev docker

docker run -p 1935:1935 -p 1985:1985 -p 8080:8080 -p 8085:8085 -p 8088:8088 docker_image_name
