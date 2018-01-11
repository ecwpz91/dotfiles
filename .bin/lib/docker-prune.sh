docker-prune() {
 docker rm "$(docker ps -aqf status=exited)" 2>/dev/null
 docker rmi -f "$(docker images -a -f dangling=true)" 2>/dev/null
 docker volume rm "$(docker volume ls -f dangling=true)" 2>/dev/null
}
