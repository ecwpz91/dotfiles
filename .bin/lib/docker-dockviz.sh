# See https://github.com/justone/dockviz
docker-dockviz() {
 docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
}
