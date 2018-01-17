docker-prune() {
 docker rm -f "$(docker ps -aq)" 2>/dev/null
 docker rmi -f "$(docker images -aqf dangling=true)" 2>/dev/null
 docker volume rm "$(docker volume ls -f dangling=true)" 2>/dev/null
}
