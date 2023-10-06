mkdir -p /home/admin/sop_probot_documents/pythonenv
cd /home/admin/sop_probot_documents/pythonenv
python3 -m venv env
source env/bin/activate
cd /home/admin/sop_probot_documents
pip install -r requirements.txt
mkdocs serve

