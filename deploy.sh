mkdir -p /home/ubuntu/sop_probot_documents/pythonenv
cd /home/ubuntu/sop_probot_documents/pythonenv
if [ ! -d 'venv' ];then
    python3 -m venv env
fi
source env/bin/activate
cd /home/ubuntu/sop_probot_documents
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

