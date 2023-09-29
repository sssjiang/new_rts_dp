import requests
import re
url="https://admin.zitree.com/sysTools.php?mod=viewsConn&rtype=json&idweb=35009&viewid=productList_style_01_1528098486963&name=productList&style=style_01&langid=0&pageid=1366571&viewCtrl=default&gids[]=all&pshow[]=pic&pshow[]=title&pshow[]=intro&pshow[]=page&prodznumpc=2&prodznum=2&prodhnumpad=4&prodhnum=4&prodnum=8&prodhnumpc=4&prodPicScale=3:4&prodsort=timeasc&P_page=4"
header={
  	"Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "connection": "keep-alive",
    "referer": "http://www.shaxizhiyao.com/products.html",
    "Host":"admin.zitree.com"
}

response=requests.get(url,headers=header)
import urllib.parse
from urllib.parse import unquote
#加载json文档
import json
file=response.text
#加载file文档
json_str =file
f = open('wen1.json', 'w', encoding='utf-8')
f.write(json_str)
#jsonload 可以解码json数据
json_data = json.loads(json_str)
f = open('wen2.json', 'w', encoding='utf-8')
json_data_string=json.dumps(json_data)
f.write(json_data_string)
#输出到文档
f = open('wen3.html', 'w', encoding='utf-8')
f.write(json_data['html'])



