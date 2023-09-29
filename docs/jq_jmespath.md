

# jq && JMESPath tips

[jq在线测试地址](https://jqplay.org/)

[JMESPath在线测试地址](https://play.JMESPath.org/)

[jq在线教程](https://stedolan.github.io/jq/tutorial/)

jq : `.` 获取所有字段

JMESPath:获取所有字段方式如下

```jpath
"jpath": ""
```



## 字符串拼接

### JMESPath

Source

```json
{
  "firstName": "John",
  "lastName": "Doe"
}
```

parse

```jq
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

```jq
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



source

```html
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <title>JSON to HTML OUTPUT</title>
  </head>
  <body>
    <ul>
      <li>
        <div data-key="0">HKC</div>
        <div data-key="F_TYPE">HKC</div>
        <div data-key="1">00728</div>
        <div data-key="RN_NO">00728</div>
        <div data-key="2">保嬰丹</div>
        <div data-key="PN_CHT">保嬰丹</div>
        <div data-key="3">PO YING PILLS</div>
        <div data-key="PN_ENG">PO YING PILLS</div>
        <div data-key="4">本草堂</div>
        <div data-key="TM_CHT">本草堂</div>
        <div data-key="5">HERBAL</div>
        <div data-key="TM_ENG">HERBAL</div>
        <div data-key="6">北京製藥廠 (聯益葯業有限公司經營)</div>
        <div data-key="CHNAME_CHT">北京製藥廠 (聯益葯業有限公司經營)</div>
        <div data-key="7">
          PEKING MEDICINE MANUFACTORY (O/B LUEN YICK PHARMACEUTICAL CO LTD)
        </div>
        <div data-key="CHNAME_ENG">
          PEKING MEDICINE MANUFACTORY (O/B LUEN YICK PHARMACEUTICAL CO LTD)
        </div>
        <div data-key="8">0</div>
        <div data-key="PMPW_FLAG">0</div>
        <div data-key="9">|05|</div>
        <div data-key="DOSAGE_ID">|05|</div>
        <div data-key="10">|每盒10小盒，每小盒1包，每包1瓶|</div>
        <div data-key="PACK_SIZE_CHT">|每盒10小盒，每小盒1包，每包1瓶|</div>
        <div data-key="11">
          |1 bottle per pack, 1 pack per small box, 10 small boxes per box|
        </div>
        <div data-key="PACK_SIZE_ENG">
          |1 bottle per pack, 1 pack per small box, 10 small boxes per box|
        </div>
        <div data-key="12">0</div>
        <div data-key="IS_EXPORT">0</div>
        <div data-key="13">
          |鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等|
        </div>
        <div data-key="PACKAGE_LABEL_C">
          |鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等|
        </div>
        <div data-key="14">|ONLY DISPLAYED IN CHINESE VERSION|</div>
        <div data-key="PACKAGE_LABEL_E">
          |ONLY DISPLAYED IN CHINESE VERSION|
        </div>
        <div data-key="15">
          {&quot;dosage_forms&quot;:[{&quot;dosage_form_c&quot;:&quot;散劑&quot;,&quot;dosage_form_e&quot;:&quot;powder&quot;,&quot;active_label_e&quot;:&quot;ONLY
          DISPLAYED IN CHINESE
          VERSION&quot;,&quot;active_label_c&quot;:&quot;鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等&quot;,&quot;id&quot;:1,&quot;dosage_form_id&quot;:&quot;05&quot;,&quot;packings&quot;:[{&quot;id&quot;:&quot;01&quot;,&quot;desc_c&quot;:&quot;每盒10小盒，每小盒1包，每包1瓶&quot;,&quot;desc_e&quot;:&quot;1
          bottle per pack, 1 pack per small box, 10 small boxes per
          box&quot;}]}],&quot;combined_dosage_e&quot;:&quot;&quot;,&quot;time_stamp&quot;:&quot;2023-07-14&quot;,&quot;combined_dosage_c&quot;:&quot;&quot;}
        </div>
        <div data-key="JSON_DATA">
          {&quot;dosage_forms&quot;:[{&quot;dosage_form_c&quot;:&quot;散劑&quot;,&quot;dosage_form_e&quot;:&quot;powder&quot;,&quot;active_label_e&quot;:&quot;ONLY
          DISPLAYED IN CHINESE
          VERSION&quot;,&quot;active_label_c&quot;:&quot;鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等&quot;,&quot;id&quot;:1,&quot;dosage_form_id&quot;:&quot;05&quot;,&quot;packings&quot;:[{&quot;id&quot;:&quot;01&quot;,&quot;desc_c&quot;:&quot;每盒10小盒，每小盒1包，每包1瓶&quot;,&quot;desc_e&quot;:&quot;1
          bottle per pack, 1 pack per small box, 10 small boxes per
          box&quot;}]}],&quot;combined_dosage_e&quot;:&quot;&quot;,&quot;time_stamp&quot;:&quot;2023-07-14&quot;,&quot;combined_dosage_c&quot;:&quot;&quot;}
        </div>
        <div data-key="16">0</div>
        <div data-key="IS_COEXIST_CP">0</div>
        <div data-key="17">0000-00-00</div>
        <div data-key="CP_EFF_DATE">0000-00-00</div>
        <div data-key="18">0000-00-00</div>
        <div data-key="CP_EXP_DATE">0000-00-00</div>
      </li>

      <li>
        <div data-key="0">HKC</div>
        <div data-key="F_TYPE">HKC</div>
        <div data-key="1">00848</div>
        <div data-key="RN_NO">00848</div>
        <div data-key="2">頸速康</div>
        <div data-key="PN_CHT">頸速康</div>
        <div data-key="3">CERVILIN</div>
        <div data-key="PN_ENG">CERVILIN</div>
        <div data-key="4">林淦生</div>
        <div data-key="TM_CHT">林淦生</div>
        <div data-key="5">LAM KAM SANG</div>
        <div data-key="TM_ENG">LAM KAM SANG</div>
        <div data-key="6">歐美製藥廠有限公司</div>
        <div data-key="CHNAME_CHT">歐美製藥廠有限公司</div>
        <div data-key="7">
          EURO AMERICA PHARMACEUTICAL FACTORY COMPANY LIMITED
        </div>
        <div data-key="CHNAME_ENG">
          EURO AMERICA PHARMACEUTICAL FACTORY COMPANY LIMITED
        </div>
        <div data-key="8">0</div>
        <div data-key="PMPW_FLAG">0</div>
        <div data-key="9">|01|</div>
        <div data-key="DOSAGE_ID">|01|</div>
        <div data-key="10">|每盒1瓶，每瓶120粒|</div>
        <div data-key="PACK_SIZE_CHT">|每盒1瓶，每瓶120粒|</div>
        <div data-key="11">|120 capsules per bottle, 1 bottle per box|</div>
        <div data-key="PACK_SIZE_ENG">
          |120 capsules per bottle, 1 bottle per box|
        </div>
        <div data-key="12">0</div>
        <div data-key="IS_EXPORT">0</div>
        <div data-key="13">|天麻，白芍，葛根，丹參，秦艽等|</div>
        <div data-key="PACKAGE_LABEL_C">|天麻，白芍，葛根，丹參，秦艽等|</div>
        <div data-key="14">|ONLY DISPLAYED IN CHINESE VERSION|</div>
        <div data-key="PACKAGE_LABEL_E">
          |ONLY DISPLAYED IN CHINESE VERSION|
        </div>
        <div data-key="15">
          {&quot;dosage_forms&quot;:[{&quot;dosage_form_c&quot;:&quot;膠囊劑&quot;,&quot;dosage_form_e&quot;:&quot;capsule&quot;,&quot;active_label_e&quot;:&quot;ONLY
          DISPLAYED IN CHINESE
          VERSION&quot;,&quot;active_label_c&quot;:&quot;天麻，白芍，葛根，丹參，秦艽等&quot;,&quot;id&quot;:1,&quot;dosage_form_id&quot;:&quot;01&quot;,&quot;packings&quot;:[{&quot;id&quot;:&quot;01&quot;,&quot;desc_c&quot;:&quot;每盒1瓶，每瓶120粒&quot;,&quot;desc_e&quot;:&quot;120
          capsules per bottle, 1 bottle per
          box&quot;}]}],&quot;combined_dosage_e&quot;:&quot;&quot;,&quot;time_stamp&quot;:&quot;2023-07-14&quot;,&quot;combined_dosage_c&quot;:&quot;&quot;}
        </div>
        <div data-key="JSON_DATA">
          {&quot;dosage_forms&quot;:[{&quot;dosage_form_c&quot;:&quot;膠囊劑&quot;,&quot;dosage_form_e&quot;:&quot;capsule&quot;,&quot;active_label_e&quot;:&quot;ONLY
          DISPLAYED IN CHINESE
          VERSION&quot;,&quot;active_label_c&quot;:&quot;天麻，白芍，葛根，丹參，秦艽等&quot;,&quot;id&quot;:1,&quot;dosage_form_id&quot;:&quot;01&quot;,&quot;packings&quot;:[{&quot;id&quot;:&quot;01&quot;,&quot;desc_c&quot;:&quot;每盒1瓶，每瓶120粒&quot;,&quot;desc_e&quot;:&quot;120
          capsules per bottle, 1 bottle per
          box&quot;}]}],&quot;combined_dosage_e&quot;:&quot;&quot;,&quot;time_stamp&quot;:&quot;2023-07-14&quot;,&quot;combined_dosage_c&quot;:&quot;&quot;}
        </div>
        <div data-key="16">0</div>
        <div data-key="IS_COEXIST_CP">0</div>
        <div data-key="17">0000-00-00</div>
        <div data-key="CP_EFF_DATE">0000-00-00</div>
        <div data-key="18">0000-00-00</div>
        <div data-key="CP_EXP_DATE">0000-00-00</div>
      </li>
      <li>
        <div data-key="num_rows">8089</div>
        <div data-key="date_time">2023-07-16 19:06</div>
      </li>
    </ul>
  </body>
</html>
```

parse

```json
{
  "elements": {
    "dp2_id": "TASK_id",
    "data": {
      "innerHtml": "//body",
      "callback": "html_to_json"
    }
  },
  "data_out": {
    "jq": ".data[]+={dp2_id:.dp2_id}|.data[:-1]"
  }
}
```

result

```json
[
  {
    "0": "HKC",
    "1": "00728",
    "2": "保嬰丹",
    "3": "PO YING PILLS",
    "4": "本草堂",
    "5": "HERBAL",
    "6": "北京製藥廠 (聯益葯業有限公司經營)",
    "7": "PEKING MEDICINE MANUFACTORY (O/B LUEN YICK PHARMACEUTICAL CO LTD)",
    "8": "0",
    "9": "|05|",
    "10": "|每盒10小盒，每小盒1包，每包1瓶|",
    "11": "|1 bottle per pack, 1 pack per small box, 10 small boxes per box|",
    "12": "0",
    "13": "|鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等|",
    "14": "|ONLY DISPLAYED IN CHINESE VERSION|",
    "15": "{\"dosage_forms\":[{\"dosage_form_c\":\"散劑\",\"dosage_form_e\":\"powder\",\"active_label_e\":\"ONLY          DISPLAYED IN CHINESE          VERSION\",\"active_label_c\":\"鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等\",\"id\":1,\"dosage_form_id\":\"05\",\"packings\":[{\"id\":\"01\",\"desc_c\":\"每盒10小盒，每小盒1包，每包1瓶\",\"desc_e\":\"1          bottle per pack, 1 pack per small box, 10 small boxes per          box\"}]}],\"combined_dosage_e\":\"\",\"time_stamp\":\"2023-07-14\",\"combined_dosage_c\":\"\"}",
    "16": "0",
    "17": "0000-00-00",
    "18": "0000-00-00",
    "F_TYPE": "HKC",
    "RN_NO": "00728",
    "PN_CHT": "保嬰丹",
    "PN_ENG": "PO YING PILLS",
    "TM_CHT": "本草堂",
    "TM_ENG": "HERBAL",
    "CHNAME_CHT": "北京製藥廠 (聯益葯業有限公司經營)",
    "CHNAME_ENG": "PEKING MEDICINE MANUFACTORY (O/B LUEN YICK PHARMACEUTICAL CO LTD)",
    "PMPW_FLAG": "0",
    "DOSAGE_ID": "|05|",
    "PACK_SIZE_CHT": "|每盒10小盒，每小盒1包，每包1瓶|",
    "PACK_SIZE_ENG": "|1 bottle per pack, 1 pack per small box, 10 small boxes per box|",
    "IS_EXPORT": "0",
    "PACKAGE_LABEL_C": "|鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等|",
    "PACKAGE_LABEL_E": "|ONLY DISPLAYED IN CHINESE VERSION|",
    "JSON_DATA": "{\"dosage_forms\":[{\"dosage_form_c\":\"散劑\",\"dosage_form_e\":\"powder\",\"active_label_e\":\"ONLY          DISPLAYED IN CHINESE          VERSION\",\"active_label_c\":\"鈎藤，蟬蛻，防風，琥珀，燕窩，珍珠粉，炒僵蠶，浙貝母，全蠍等\",\"id\":1,\"dosage_form_id\":\"05\",\"packings\":[{\"id\":\"01\",\"desc_c\":\"每盒10小盒，每小盒1包，每包1瓶\",\"desc_e\":\"1          bottle per pack, 1 pack per small box, 10 small boxes per          box\"}]}],\"combined_dosage_e\":\"\",\"time_stamp\":\"2023-07-14\",\"combined_dosage_c\":\"\"}",
    "IS_COEXIST_CP": "0",
    "CP_EFF_DATE": "0000-00-00",
    "CP_EXP_DATE": "0000-00-00",
    "dp2_id": 30813852
  },
  {
    "0": "HKC",
    "1": "00848",
    "2": "頸速康",
    "3": "CERVILIN",
    "4": "林淦生",
    "5": "LAM KAM SANG",
    "6": "歐美製藥廠有限公司",
    "7": "EURO AMERICA PHARMACEUTICAL FACTORY COMPANY LIMITED",
    "8": "0",
    "9": "|01|",
    "10": "|每盒1瓶，每瓶120粒|",
    "11": "|120 capsules per bottle, 1 bottle per box|",
    "12": "0",
    "13": "|天麻，白芍，葛根，丹參，秦艽等|",
    "14": "|ONLY DISPLAYED IN CHINESE VERSION|",
    "15": "{\"dosage_forms\":[{\"dosage_form_c\":\"膠囊劑\",\"dosage_form_e\":\"capsule\",\"active_label_e\":\"ONLY          DISPLAYED IN CHINESE          VERSION\",\"active_label_c\":\"天麻，白芍，葛根，丹參，秦艽等\",\"id\":1,\"dosage_form_id\":\"01\",\"packings\":[{\"id\":\"01\",\"desc_c\":\"每盒1瓶，每瓶120粒\",\"desc_e\":\"120          capsules per bottle, 1 bottle per          box\"}]}],\"combined_dosage_e\":\"\",\"time_stamp\":\"2023-07-14\",\"combined_dosage_c\":\"\"}",
    "16": "0",
    "17": "0000-00-00",
    "18": "0000-00-00",
    "F_TYPE": "HKC",
    "RN_NO": "00848",
    "PN_CHT": "頸速康",
    "PN_ENG": "CERVILIN",
    "TM_CHT": "林淦生",
    "TM_ENG": "LAM KAM SANG",
    "CHNAME_CHT": "歐美製藥廠有限公司",
    "CHNAME_ENG": "EURO AMERICA PHARMACEUTICAL FACTORY COMPANY LIMITED",
    "PMPW_FLAG": "0",
    "DOSAGE_ID": "|01|",
    "PACK_SIZE_CHT": "|每盒1瓶，每瓶120粒|",
    "PACK_SIZE_ENG": "|120 capsules per bottle, 1 bottle per box|",
    "IS_EXPORT": "0",
    "PACKAGE_LABEL_C": "|天麻，白芍，葛根，丹參，秦艽等|",
    "PACKAGE_LABEL_E": "|ONLY DISPLAYED IN CHINESE VERSION|",
    "JSON_DATA": "{\"dosage_forms\":[{\"dosage_form_c\":\"膠囊劑\",\"dosage_form_e\":\"capsule\",\"active_label_e\":\"ONLY          DISPLAYED IN CHINESE          VERSION\",\"active_label_c\":\"天麻，白芍，葛根，丹參，秦艽等\",\"id\":1,\"dosage_form_id\":\"01\",\"packings\":[{\"id\":\"01\",\"desc_c\":\"每盒1瓶，每瓶120粒\",\"desc_e\":\"120          capsules per bottle, 1 bottle per          box\"}]}],\"combined_dosage_e\":\"\",\"time_stamp\":\"2023-07-14\",\"combined_dosage_c\":\"\"}",
    "IS_COEXIST_CP": "0",
    "CP_EFF_DATE": "0000-00-00",
    "CP_EXP_DATE": "0000-00-00",
    "dp2_id": 30813852
  }
]
```

参考dp2id 30813852。jq 先让data中的数据增加一个键值对，最后筛选出要的数据。其中增加的dp2_id可以让数据库中数据链接到dp2平台中产生这个数据的id。 

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

```jq
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
[
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
```

parse

```jq
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
{
    "attachments": [
        {
            "id": "34a52cbd-9ade-4d2e-e388-08d9d500bc62",
            "s_ModifiedAt": "2022-01-11T16:24:41.9891548Z",
            "s_ModifiedBy": "SyncHostedService",
            "s_CreatedAt": "2022-01-11T16:24:41.989154Z",
            "s_CreatedBy": "SyncHostedService",
            "documentName": "FFFF",
            "documentType": "PRODUCT",
            "url": null,
            "publishAt": "2012-07-21T11:34:39.25Z",
            "updatedAt": "None",
            "refId_Product": "90a61e9f-21d2-484b-d615-08d9d500bc6a"
        },
        {
            "id": "34a52cbd-9ade-4d2e-e388-08d9d500bc62",
            "s_ModifiedAt": "2022-01-11T16:24:41.9891548Z",
            "s_ModifiedBy": "SyncHostedService",
            "s_CreatedAt": "2022-01-11T16:24:41.989154Z",
            "s_CreatedBy": "SyncHostedService",
            "documentName": "FFFF",
            "documentType": "PRODUCT",
            "url": null,
            "publishAt": "2012-07-21T11:34:39.25Z",
            "updatedAt": "None",
            "refId_Product": "90a61e9f-21d2-484b-d615-08d9d500bc6a"
        }
    ]
}
```

Parse

```jq
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

## 解析json string

```json
"[{\"herb_cn_name\":\"\\u77ee\\u5730\\u8336\",\"herb_pinyin\":\"Aidicha\",\"herb_en_name\":\"Ardisiae Japonicae Herba\",\"child_cn_name\":\"\\u6b62\\u54b3\\u5e73\\u5598\\u836f\",\"child_en_name\":\"Antitussive Antiasthmetics\"}]"
```

jq表达式 Filter：`.|fromjson`

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

### 从网页中提取JSON的jexter不同写法

#### Jmespath

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

#### jq

```json
{
    "elements": {
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

详细内容参考dp2_id:13757804以下为该dp2_id 的完整jexter代码

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
  },
  "data_out": {
    "jq": "[{herb_en_name:.allData[].herb_en_name,token:.token}]"
  }
}
```

先提取到token,和allData字段，然后在data_out阶段只选取herb_en_name值和token value。
