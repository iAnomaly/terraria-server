#!/bin/env sh

CONTAINER=terraria-server

case "$@" in
	attach)
		docker attach --sig-proxy=false $CONTAINER
		;;
	start)
		docker run -di --name $CONTAINER --restart unless-stopped -p 7777:7777/tcp -v "$PWD/data":/home/docker/.local/share -v "$PWD/config":/home/docker/terraria/config terraria-server
		;;
	stop)
		docker stop $CONTAINER
		;;
	restart)
		docker restart $CONTAINER
		;;
	*)
		;;
esac

