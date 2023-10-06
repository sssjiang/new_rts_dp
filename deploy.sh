mkdir -p /home/ubuntu/sop_probot_documents
cd /home/ubuntu/sop_probot_documents
if [ ! -d 'venv' ];then
    python3 -m venv venv
fi
source venv/bin/activate
cd /home/ubuntu/sop_probot_documents/app
pip install -r requirements.txt
pip install -r docs/requirements.txt
ACTION=$1
start() {   
    echo "Start..."
    mkdocs serve -a 0.0.0.0:8000 > output.log 2>&1 &
}
stop() {
    echo "stop..."
    pkill -f "mkdocs serve"
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
esac

