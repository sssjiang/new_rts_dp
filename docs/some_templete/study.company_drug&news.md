# Study for company

```json
{
  "STU": "company.jmjtyygs.drugs",
  "excluded_workers": [],
  "steps": [...]
	}
```

替换处：`"url"`  `"charset"`

## category_step

### 单个目录

```json
  {
      "data_in": {
        "note": "",
        "data_for_test": {
          "note": ""
        }
      },
      "project_name": "{STU}.category",
      "url": "https://www.whjm.com/news/ji-tuan-dong-tai-list-0.htm",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1501,
      "data_out": {
        "jpath": ""
      },
      "interval": 86400,
      "excluded_workers": "{excluded_workers}"
    },
```

`"note":""` data_for_test中不传入数据

### 嵌套目录

没有页面直接得到category2的所有分类，需要从category1中的到第一步分类，再得到第二步分类。

```json
 {
      "data_in": {
        "note": "",
        "data_for_test": {
          "note": ""
        }
      },
      "project_name": "{STU}.category1",
      "url": "https://www.whjm.com/pinpai/OTCqinghe.htm",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1501,
      "data_out": {
        "jpath": ""
      },
      "interval": 86400,
      "excluded_workers": "{excluded_workers}"
    }, {
      "data_in": {
        "note": "",
        "data_for_test": {
          "link": "long-mu-zhuang-gu-ke-li-list"
        }
      },
      "project_name": "{STU}.category2",
      "url": "https://www.whjm.com/pinpai/{link}-0.htm",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1501,
      "data_out": {
        "jpath": ""
      },
      "interval": 86400,
      "excluded_workers": "{excluded_workers}"
    },
```



## totalpage_step

### 上一步有 category_step

```json
  {
      "data_in": {
        "data_for_test": [
          {
            "link": "ji-tuan-dong-tai-list"
          }
        ]
      },
      "project_name": "{STU}.totalpage",
      "url": "https://www.whjm.com/news/{link}-0.htm",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "extra_data": {
        "linKey": "{link}"
      },
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1502,
      "data_out": [
        {
          "jpath": ""
        }
      ],
      "interval": "86400",
      "excluded_workers": "{excluded_workers}"
    },
```

data_for_test中为上一步解析的字段值。ulr中{link} 为ji-tuan-dong-tai-list

Extra_data 可以将上一步的输出传递到下一步中

### 上一步没有 category_step

```json
 {
      "data_in": {
        "data_for_test": [
          {
            "Note": ""
          }
        ]
      },
      "project_name": "{STU}.totalpage",
      "url": "http://www.zjspas.com/index.php/product/0/1.html",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1502,
      "data_out": [
        {
          "jpath": ""
        }
      ],
      "interval": "86400",
      "excluded_workers": "{excluded_workers}"
    },
```



## list

### method get

- category和totalpage都有

```json
 {
      "data_in": {
        "data_for_test": {
          "TotalPageNum": "2",
          "linKey": "ji-tuan-dong-tai-list"
        }
      },
      "project_name": "{STU}.list",
      "url": {
        "pattern": "https://www.whjm.com/news/{linKey}-(*).htm",
        "iteration": {
          "start": 1,
          "stop": "{TotalPageNum}",
          "format": "{}"
        }
      },
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1503,
      "data_out": {
        "jpath": ""
      },
      "interval": "86400",
      "excluded_workers": "{excluded_workers}"
    },
```

- 有category_step则带上linKey 字段,没有category_step则需要删除linkey字段

```json
 {
   "url": {
        "pattern": "http://www.zjspas.com/index.php/product/0/(*).html",
        "iteration": {
          "start": 1,
          "stop": "{TotalPageNum}",
          "format": "{}"
        }
 }
```

- 没有totalpage_step则删除(*)

```json
{
   "url": "http://www.china5522.com/product.asp?type_id={linkey}",
}
```

- no category and no totalpage(one page)

```json
{ 
"url": "http://www.jlyy1999.com/yky/pro.aspx"
}
```

### method post

```json
    {
      "data_in": {
        "data_for_test": {
          "TotalPageNum": "1",
          "linKey": "3"
        }
      },
      "project_name": "{STU}.list",
      "url": {
        "pattern": "http://www.jlyy1999.com/news/news.aspx?mtt={linKey}",
        "iterate": {
          "start": 1,
          "stop": "{TotalPageNum}"
        }
      },
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "POST",
      "data": {
        "__VIEWSTATE": "string",
          "__EVENTTARGET": "AspNetPager1",
        "__EVENTARGUMENT": "(*)"
      },
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "pf_id": 1543,
      "data_out": {
        "jpath": ""
      },
      "interval": "86400",
      "excluded_workers": "{excluded_workers}"
    },
```

循环变量iterate`(*)`放在data中 作为post请求页面页数

## detail

```json
 {
      "data_in": {
        "data_for_test": [
          {
            "link": "https://www.whjm.com/news/485516.htm"
          }
        ]
      },
      "project_name": "{STU}.detail",
      "url": "{link}",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "add_only": 1,
      "data_out": [
        {
          "jpath": "attachments"
        }
      ],
      "excluded_workers": "{excluded_workers}",
      "interval": 5184000,
      "pf_id": 1504
    },
```

解析结果

写入数据库

```json
{
      "data_in": {
        "data_for_test": [
          {
            "link": "http://www.topfond.com/product/1.html",
            "drug_name": "硫酸阿米卡星注射液"
          }
        ]
      },
      "project_name": "{STU}.detail",
      "url": "{link}",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "add_only": 1,
      "excluded_workers": "{excluded_workers}",
      "interval": 5184000,
      "data_out": {
        "jpath": "",
        "api": {
          "url": "http://api2.drugsea.cn/dp2/mongo/save",
          "table": "china_manufacture_products",
          "where": {
            "uniqueId": "{dp2_id}"
          },
          "data": {
            "dp2_id": "{dp2_id}",
            "drug_name": "{drug_name}",
            "company": "{company}",
            "attachments": "{attachments}",
            "drug_reference": "{drug_reference}"
          }
        }
      },
      "pf_id": 1684
    },
```

数据库结果：

```json
{
    "_id" : ObjectId("65056e67e2605e28032ccd0d"),
    "project_name" : "china_manufacture_products",
    "uniqueId" : "32337897",
    "data" : {
        "dp2_id" : "32337897",
        "drug_name" : "吉他霉素片",
        "company" : "天方药业有限公司",
        "attachments" : [
            {
                "link" : "http://www.topfond.com//repository/image/96240316-0994-4211-b72a-ca948c0bd8da.jpg",
                "title" : "吉他霉素片",
                "key" : "dp2_attachments/a3230d21bac7da36c731dbfac189240f"
            }
        ],
        "drug_reference" : "<div id=\"contentDiv\" class=\"e_box d_DescribeContent...,
        "row_idx" : NumberInt(3)
    },
    "row_idx" : NumberInt(0)
}
```

`"_id"`字段自动生成

`"project_name"`与table对应

 

## attachment

```json
   {
      "data_in": {
        "data_for_test": {
          "note": ""
        }
      },
      "project_name": "{STU}.attachments",
      "url": "{link}",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "add_only": 1,
      "excluded_workers": "{excluded_workers}",
      "interval": 5184000,
      "pf_id": 1438
    }
```

下载附件链接

写入mongodb中

```json
 {
      "data_in": {
        "jpath": "attachments",
        "data_for_test": {
          "attachments": [
            {
              "link": "http://www.topfond.com//repository/image/4e4f89b8-c6aa-4e74-a9d6-3535a649b752.jpg",
              "title": "阿米卡星注射液"
            }
          ]
        }
      },
      "project_name": "{STU}.attachments",
      "url": "{link}",
      "type": "one-off",
      "priority": 2,
      "fetch_method": "direct",
      "method": "GET",
      "status": 1,
      "charset": "UTF-8",
      "charact_string_start": "",
      "charact_string_end": "",
      "add_only": 1,
      "excluded_workers": "{excluded_workers}",
      "interval": 5184000,
      "pf_id": 1702,
      "data_out": {
        "jpath": "{key:key}",
        "api": {
          "url": "http://api2.drugsea.cn/dp2/mongo/save/v2",
          "table": "china_manufacture_products",
          "where": {
            "uniqueId": "{dp2_id}"
          },
          "data": {
            "data.attachments.{row_idx}.key": "{key}"
          }
        }
      }
    }
```

`"uniqueId": "{dp2_id}"`先判断attachments解析结果有没有{dp2_id}，没有则取extract_data中的dp2_id的值

`"jpath":"{key:key}"`排除attachments解析结果中的dp2_id。取extract_data的值则会指向上一步的dp2_id。将attachments中的附件路径更新写入数据库中。

extract_data 默认变量row_idx, step_num,dp2_id

![image-20230926163855449](assets/image-20230926163855449.png)

更新之前：

```json
{
 "attachments": [
    {
      "link": "http://www.topfond.com//repository/image/96240316-0994-4211-b72a-ca948c0bd8da.jpg",
      "title": "吉他霉素片"
    }
  ]
}
```

更新之后：

```json
{
  "attachments" : [
            {
                "link" : "http://www.topfond.com//repository/image/96240316-0994-4211-b72a-ca948c0bd8da.jpg",
                "title" : "吉他霉素片",
                "key" : "dp2_attachments/a3230d21bac7da36c731dbfac189240f"
            }
        ],
}
```

