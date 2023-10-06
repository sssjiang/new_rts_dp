mkdir -p /home/ubuntu/sop_probot_documents/pythonenv
cd /home/ubuntu/sop_probot_documents/pythonenv
python3 -m venv env
source env/bin/activate
cd /home/ubuntu/sop_probot_documents
pip install -r requirements.txt
pip install -r docs/requirements.txt
ACTION=$1
restart() {
    echo "stop..."
    pkill -f "mkdocs serve"
    mkdocs serve -a 0.0.0.0:8000 > output.log 2>&1 &
    echo "Start..."
}
case "$ACTION" in
    restart)
        restart
    ;;
    *)
        restart
    ;;
esac


