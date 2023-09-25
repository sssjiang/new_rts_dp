

# jq && jmespath tips

Jq : `.` 获取所有字段

jmespath:获取所有字段方式如下

```json
"jpath": ""
```



## 字符串拼接：

### jmespath

Source

```json
{
  "firstName": "John",
  "lastName": "Doe"
}
```

parse

```json
join(' ', [firstName, lastName])

```

result

```json
"John Doe"
```

### jq

#### `+=`

给子元素数字中每个element增加一个父元素中的值，比如给data.value中每个元素增加一个dp2_id的key：关键是+=

source

```json
{
"dp2_id": "1234",
"data": {
"value": [
{
"id": "1",
"key": "ssss"
},
{
"id": "2",
"key": "bbbb"
},
{
"id": "3",
"key": "cccc"
}
]
}
}
```

parse

```json
.data.value[]+={dp2_id:.dp2_id}
```

result

```json
{
  "dp2_id": "1234",
  "data": {
    "value": [
      {
        "id": "1",
        "key": "ssss",
        "dp2_id": "1234"
      },
      {
        "id": "2",
        "key": "bbbb",
        "dp2_id": "1234"
      },
      {
        "id": "3",
        "key": "cccc",
        "dp2_id": "1234"
      }
    ]
  }
}

```



#### `map`

将数组中每个元素当做一个变量的值: 数组map以后，可以针对每个元素操作

source

```json
{
"dp2_id": "1234",
"data": {
"value": [
{
"id": "1",
"key": "ssss"
},
{
"id": "2",
"key": "bbbb"
},
{
"id": "3",
"key": "cccc"
}
]
}
}
```

parse

```json
.data.value|map({data:.,id:.id})
```

result

```json
[
  {
    "data": {
      "id": "1",
      "key": "ssss"
    },
    "id": "1"
  },
  {
    "data": {
      "id": "2",
      "key": "bbbb"
    },
    "id": "2"
  },
  {
    "data": {
      "id": "3",
      "key": "cccc"
    },
    "id": "3"
  }
]

```

![img](assets/795c70a1-5663-4283-b147-184aa740bcdd.png)

#### `()`

将多个同级元素与字符串拼接后，形成一个新的值：用（）将多个值或字串链接的算式括起来

**单个元素**

source

```json
{
"id": "1",
"key": "ssss"
}
```

parse

```json
map({newKey:(.id+"--"+.key)})
```

result

```json
{
  "newKey": "1--ssss"
}
```

**数组元素**

source

```json
[{
"id": "1",
"key": "ssss"
},
{
"id": "2",
"key": "bbbb"
},
{
"id": "3",
"key": "cccc"
}
]
```

parse

```json
map({newKey:(.id+"--"+.key)})
```

result

```json
[
  {
    "newKey": "1--ssss"
  },
  {
    "newKey": "2--bbbb"
  },
  {
    "newKey": "3--cccc"
  }
]

```



#### `Select`

用select筛选数组中的元素，然后对元素中字段进行条件判断，然后拼接

source

```json
{"attachments":[{
"id":"34a52cbd-9ade-4d2e-e388-08d9d500bc62",
"s_ModifiedAt":"2022-01-11T16:24:41.9891548Z",
"s_ModifiedBy":"SyncHostedService",
"s_CreatedAt":"2022-01-11T16:24:41.989154Z",
"s_CreatedBy":"SyncHostedService",
"documentName":"FFFF",
"documentType":"PRODUCT",
"url": null,
"publishAt":"2012-07-21T11:34:39.25Z",
"updatedAt":"None",
"refId_Product":"90a61e9f-21d2-484b-d615-08d9d500bc6a"},
{
"id":"34a52cbd-9ade-4d2e-e388-08d9d500bc62",
"s_ModifiedAt":"2022-01-11T16:24:41.9891548Z",
"s_ModifiedBy":"SyncHostedService",
"s_CreatedAt":"2022-01-11T16:24:41.989154Z",
"s_CreatedBy":"SyncHostedService",
"documentName":"FFFF",
"documentType":"PRODUCT",
"url": null,
"publishAt":"2012-07-21T11:34:39.25Z",
"updatedAt":"None",
"refId_Product":"90a61e9f-21d2-484b-d615-08d9d500bc6a"}]}

```

Parse

```json
.attachments|map(select(.documentName!="None"))|map({link:(if .url=="None" or .url==null then "https://mri.cts-mrp.eu/portal/v1/odata/Document("+.id+")/Download" elif .url|test("pdf";"ix") then .url elif .url|test("doc";"ix") then .url|"http://www.vmd.defra.gov.uk/ProductInformationDatabase/files/SPC_Documents/SPC_"+capture("SPC_(?<id>[[:digit:]]+)").id+".PDF" else .url end)})
```

result

```json
[
  {
    "link": "https://mri.cts-mrp.eu/portal/v1/odata/Document(34a52cbd-9ade-4d2e-e388-08d9d500bc62)/Download"
  },
  {
    "link": "https://mri.cts-mrp.eu/portal/v1/odata/Document(34a52cbd-9ade-4d2e-e388-08d9d500bc62)/Download"
  }
]

```

在线教程：https://stedolan.github.io/jq/tutorial/

## 解析json string

```json
"[{\"herb_cn_name\":\"\\u77ee\\u5730\\u8336\",\"herb_pinyin\":\"Aidicha\",\"herb_en_name\":\"Ardisiae Japonicae Herba\",\"child_cn_name\":\"\\u6b62\\u54b3\\u5e73\\u5598\\u836f\",\"child_en_name\":\"Antitussive Antiasthmetics\"}]"
```

Filter：`.|fromjson`

Result:

```json
[

 {

  "herb_cn_name": "矮地茶",

  "herb_pinyin": "Aidicha",

  "herb_en_name": "Ardisiae Japonicae Herba",

  "child_cn_name": "止咳平喘药",

  "child_en_name": "Antitussive Antiasthmetics"

 }

]
```

从网页中提取JSON的parse function的不同写法：

### Jmespath：

```json
{

 "elements": {

 "allData": {

   "col": "//script",

   "function": {

     "regexp": "data: (\\[\\{.+?\\}\\])",

     "callback": "json_decode"

   },

   "data_out": "[0]"

 }

  }

}
```

### Jq:

```json
{

 "elements": {

  "token": {

   "col": "//script",

   "function": {

"regexp": "&token=(.+?)'>",

"type": "string"

   }

  },

  "allData": {

   "col": "//script",

   "function": {

"regexp": "data: (\\[\\{.+?\\}\\])",

"type": "string"

   },

   "data_out": {

"jq": ".|fromjson"

   }

  }

 }

}
```

