#/bin/sh
#start or stop the im-server

LOGIN_SERVER=login_server
MSG_SERVER=msg_server
ROUTE_SERVER=route_server
HTTP_MSG_SERVER=http_msg_server
FILE_SERVER=file_server
PUSH_SERVER=push_server
DB_PROXY_SERVER=db_proxy_server
MSFS=msfs


function restart() {
    cd $1
    if [ ! -e *.conf  ]
    then
        echo "no config file"
        return
    fi

    if [ -e server.pid  ]; then
        pid=`cat server.pid`
        echo "kill pid=$pid"
        kill $pid
        while true
        do
            oldpid=`pgrep $1`;
            if [ $oldpid" " == $pid" " ]; then
                echo $oldpid" "$pid
                sleep 1
            else
                break
            fi
        done
        ../daeml ./$1
    else 
        ../daeml ./$1
    fi
}

case $1 in
	$LOGIN_SERVER)
		restart $1
		;;
	$MSG_SERVER)
		restart $1
		;;
	$ROUTE_SERVER)
		restart $1
		;;
	$HTTP_MSG_SERVER)
		restart $1
		;;
	$FILE_SERVER)
		restart $1
		;;
	$PUSH_SERVER)
		restart $1
		;;
	$DB_PROXY_SERVER)
		restart $1
		;;
	$MSFS)
		restart $1
		;;
	all)
		restart $LOGIN_SERVER
		cd ..
		restart $MSG_SERVER
		cd ..
		restart $ROUTE_SERVER
		cd ..
		restart $MSFS
		cd ..
		restart $HTTP_MSG_SERVER
		cd ..
		restart $FILE_SERVER
		cd ..
		restart $PUSH_SERVER
		cd ..
		restart $DB_PROXY_SERVER
		;;
	*)
		echo "Usage: "
		echo "  ./restart.sh (login_server|msg_server|route_server|http_msg_server|file_server|push_server|msfs|all)"
		;;
esac
