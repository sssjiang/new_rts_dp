#!/bin/bash

ACTION=$1

cd /home/ubuntu/sop_probot_documents
if [ ! -d 'venv' ];then
    python3 -m venv venv
fi
source venv/bin/activate
cd /home/ubuntu/sop_probot_documents/app

install() {
    pip install -r docs/requirements.txt
}

usage() {
    echo "Usage: $PROG_NAME {start|stop|restart}"
    exit 2
}

start() {   
    echo "Start..."
    mkdocs serve -a 0.0.0.0:8000 > output.log 2>&1 &
    echo "Start Done"
}
stop() {
    echo "Stop..."
    pkill -f "mkdocs serve"
    echo "Stop Done"
}
restart() {
    echo "Restart..."
    stop
    start
    echo "Restart Done"
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
    install)
        install
        stop
        start
    ;;
    *)
        usage
    ;;
esac

