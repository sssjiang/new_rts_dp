# study.data_out

JSON数据提取与转化:JMESPath (默认), jq

[jq_and_JMESPath_example](jq_JMESPath.md)

## 数据通过api保存到数据库

### 数据库MySQL

```json
{
    "url": "http://api2.drugsea.cn/save/db/data",
    "table": "zb_scyxzbcg_drug_list",
    "where": {
        "goodsId": "{goodsId}"
    },
    "data": {
        "registeredMedicineModel": "{registeredMedicineModel}",
        "drugCategory": "{drugCategory}"
    }
}
```

### 数据库mongo

#### 第1种写法

保存数据到mongodb: 地址为dp2/mongo/save

```json
{
    "url": "http://api2.drugsea.cn/dp2/mongo/save",
    "table": "zb_scyxzbcg_drug_list",
    "type": "merge",
    "where": {
        "uniqueId": "{dp2_id}"
    },
    "data": {
        "registeredMedicineModel": "{registeredMedicineModel}",
        "drugCategory": "{drugCategory}",
    }
}
```

-  where中需要有一个uniqueId, 一般用dp2_id


- data的字段中设置 field="DELETE" 可以删除这个字段
- type默认是merge时（create/add/modify），可以不写；若要替换设置type=update（replace）
- Table:通常与study中project_name相同

#### 第2种写法

```json
{
    "url": "http://api2.drugsea.cn/dp2/mongo/save/v2",
    "table": "zb_scyxzbcg_drug_list",
    "where": {
        "uniqueId": "{dp2_id}"
    },
    "data": {
        "data": {
            "registeredMedicineModel": "{registeredMedicineModel}",
            "drugCategory": "{drugCategory}"
        }
    }
}
```

- 这种写法相当于直接修改document中的data字段，这时type字段就不起作用了，完全需要通过data中的写法来控制数据的更新
- 当只要更新data中的部分数据时，参考下面更新attachments的第2种写法。

### attachments的保存方法

- detail任务中的attachments字段存储着一个数组，每个元素为一个附件，附件会传到study的下一步去下载，下载完成后，需要把oss生成的key传回原来detail任务中的attachments中
- 需要根据attachments任务 的extra_data中的dp2_id和row_idx来确定要写回的位置

api 支持MySQL和mongdb两种数据库的写入，两种写入的示例如下：

#### 数据库MySQL

```json
{
    "url": "http://api2.drugsea.cn/save/db/data/attachments",
    "table": "cfda_jilin_beian",
    "where": {
        "dp2_id": "{dp2_id}"
    },
    "note": "row_idx可以不写，因为study的data_out处理时会自动添加",
    "data": {
        "key": "{key}",
        "row_idx": "{row_idx}"
    }
}
```

- url为支持attachments更新的专属API
- where中的dp2_id为extra_data.dp2_id
- key是attchments任务的OSS_JSON中的key
- data_out处理的时候，会自动把extra_data.row_idx加到data中

#### 数据库mongdb

```json
{
    "url": "http://api2.drugsea.cn/dp2/mongo/save/attachments",
    "table": "zb_scyxzbcg_drug_list",
    "where": {
        "uniqueId": "{dp2_id}"
    },
    "note": "row_idx可以不写，因为study的data_out处理时会自动添加",
    "data": {
        "key": "{key}",
        "row_idx": "{row_idx}"
    }
}
```

除了以上修改attachments的方法，也可以用下面的方式更新具体的字段内容：/dp2/mongo/save/v2

```json
{
    "url": "http://api2.drugsea.cn/dp2/mongo/save/v2",
    "table": "zb_scyxzbcg_drug_list",
    "where": {
        "uniqueId": "{dp2_id}"
    },
    "data": {
        "data.attachment.{row_idx}.key": "{key}"
    }
}
```

## 数据更新后通知：notification

```json
{notification: {

  type: "openid, email",

   receiver: "....",

   content: "{keyword}" // 支持变量替换
    }
}
```

## JSON转化为PDF：json_to_pdf

## zip文件解压并写入OSS: unzip

