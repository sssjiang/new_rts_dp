# Jexter for company templete

## **category**页面

```json
{
  "total_rows": "//div[@class='side-nav']/ul/li",
  "elements": {
    "link": {
      "col": "./a/@href",
      "callback": "absolute_url",
      "function": {
        "regexp": "/(\\w+)/$",
        "return": [
          0
        ],
        "type": "string"
      },

 "default": ""    }
  },
  "data_out": {
    "jq": "[{link:.[].link|select(.!=\"\")}]"
    "jpath": "[0:]"
  }
}
```

## **totalpage**页面

### **method**1

```json
{
  "elements": {
    "TotalPageNum": {
      "col": "//tr//font[3]",
      "function": {
        "regexp": "/(\\d+)",
        "type": "string"
      }
    }
  }
}
```

### method2

```json
{
  "elements": {
    "TotalPageNum": {
      "col": "//a[@id='page_next']",
      "function": {
        "regexp": "var countPage = (\\d+)//共多少页",
        "type": "string"
      }
    },
    "linKey": {
      "col": "TASK_extra_data",
      "callback": "json_extract##linKey"
    }
  }
}
```

## list页面

### 直接定位所有link

```json
{
  "total_rows": "//table/tr/td[@height='30']",
  "elements": {
    "link": {
      "col": ".//a[@target='_blank']/@href",
      "callback": "absolute_url",
      "must_match": ".+"
    }
  }
}
```

### 嵌套定位所有link

```json
{
  "total_rows": "//body[1]/table[2]//tr[1]/td[1]/table[2]//tr[1]/td[3]/table[1]//tr[2]/td[1]/table[1]//tr[1]/td[1]/table[1]//tr[1]/td[1]/table[2]//tr",
  "elements": {
    "title1": ".//td[1]//table[1]//tr[2]/td[1]",
    "link1": {
      "col": ".//td[1]//table[1]//tr[2]/td[1]//a/@href",
      "callback": "absolute_url",
      "must_match":".+"
    },
    "title2": ".//td[2]//table[1]//tr[2]/td[1]",
    "link2": {
      "col": ".//td[2]//table[1]//tr[2]/td[1]//a/@href",
      "callback": "absolute_url",
      "must_match":".+"
    },
    "title3": ".//td[3]//table[1]//tr[2]/td[1]",
    "link3": {
      "col": ".//td[3]//table[1]//tr[2]/td[1]//a/@href",
      "callback": "absolute_url",
      "must_match":".+"
    }
  },

  "data_out": {
    "jq": "[{link:.[].link1|select(.!=\"\")},{link:.[].link2|select(.!=\"\")},{link:.[].link3|select(.!=\"\")}]"
  }
}
```

## detail页面

### drug页面

```json
{
  "elements": {
	 "dp2_id": "TASK_id",
    "drug_name": {
      "col": "//p[@style='LINE-HEIGHT: 14pt; MARGIN-TOP: 0pt; MARGIN-BOTTOM: 0pt'][2]/span",
      "function": {
        "regexp": "通用名称：(.+?)$",
        "type": "string"
      }
    },
    "auth_num": {
      "col": "//span[contains(text(),'批准文号')]",
      "function": {
        "regexp": "【批准文号】(.+?)$",
        "type": "string"
      }
    },
    "company": {
      "col": "//span[contains(text(),'企业名称')]",
      "function": {
        "regexp": "企业名称：(.+)$",
        "type": "string"
      }
    },
    "attachments": {
      "innerHtml": "//table[@style='background:#666666']",
      "extract_attachments": {}
    },
    "drug_reference": {
      "innerHtml": "//td[@colspan='2']/p"
    }
  }
}

```

### news页面

```json
{
  "elements": {
    "title": "//td[@class='subBigTitle']//font",
    "date":{
      "col":"//td[contains(text(),'日期')]",
      "callback":"extract_date"
    },
    "attachments": {
      "innerHtml": "//td[@id='Display_Content']",
      "extract_attachments": {}
    },
    "content": {
      "innerHtml": "//td[@id='Display_Content']"
    }
  }
}
```

