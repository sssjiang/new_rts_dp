#!/bin/bash

set -e

ACTION=$1

cd /home/ubuntu/sop_probot_documents
if [ ! -d 'venv' ];then
    python3 -m venv venv
fi
source venv/bin/activate
cd /home/ubuntu/sop_probot_documents/app

if [ "$ACTION" == "restart" ];then
    pip install -r docs/requirements.txt
fi

usage() {
    echo "Usage: $PROG_NAME {start|stop|restart}"
    exit 2
}

start() {   
    echo "Start..."
    mkdocs serve -a 0.0.0.0:8000 > output.log 2>&1 &
}
stop() {
    echo "Stop..."
    pkill -f "mkdocs serve"
    echo "Stop done"
}

restart() {
    echo "restart..."
    stop
    start
}
case "$ACTION" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        stop
        start
    ;;
    *)
        usage
    ;;
esac

