# Jexter

## 规范

### detail页面解析字段命令规范

#### company

##### 药品

 ["dp2_id","company","drug_name","drug_reference","attachments","auth_num" ]

auth_num在网页有相关字段则提取。

```json
"dp2_id": 32113700
"company": "西南药业股份有限公司"
"drug_name": "盐酸吗啡缓释片（美菲康）",
"drug_reference":html源码
"attachments": [
    {
      "task_fp": "89e45c652281fc60bc9ff8c0066d7dc5",
      "dp2_id": 32113700,
      "title": "1667983011403339.png",
      "link": "https://www.swp.cn/static/upload/image/20221109/1667983011403339.png",
      "type": "png"
    }
  ]
"auth_num": "国药准字H10930078",
```

##### 新闻

["dp2_id","title","date","content","attachments"]

```json
"dp2_id": 32113701
"title": "兰辉同志先进事迹学习材料",
"date": "2013-10-30",
"content":html源码
"attachments": [],
```



## parent



| 描述                                                   | 输入        | 输出 |
| ------------------------------------------------------ | ----------- | ---- |
| 设置绝对路径让element的col参数在此基础上使用相对路径。 | xpath表达式 | /    |



**示例1**

source

```html
<title>利巴韦林注射液</title>

```

parse

```json
{
    "parent": "//title",
    "elements": {
        "title": "."
    }
}
```

result

```json
{
  "title": "利巴韦林注射液"
}
```

## total_rows

| 描述                                                     | 输入          | 输出                                    |
| -------------------------------------------------------- | ------------- | --------------------------------------- |
| 获取多个`{"key":"value"}`(total_rows 也具备parent的功能) | xpath定位结果 | `[{"key1":"value1"},{"key2":"value2"}]` |

**示例1**

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
    "total_rows": "//title|//div",
    "elements": {
        "title": "."
    }
}
```

result

```json
[
  {
    "title": "利巴韦林注射液"
  },
  {
    "title": "利巴"
  }
]
```

## elements:[]

| 描述                                      | 输入          | 输出                  |
| ----------------------------------------- | ------------- | --------------------- |
| 当提取的值不需要“key”时，可以用此方法提取 | xpath定位结果 | `["value1","value2"]` |

##### 示例1

elements:[] 单独使用

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
    "elements": [
        "//title",
        "//div"
    ]
}
```

result

```json
[
  "利巴韦林注射液",
  "利巴"
]
```

##### 示例2

elements:[] 和total_rows 联合使用

source

```html
<title>利巴韦林注射液</title>
<div><title>利巴韦林注射液</title><div>
```

parse

```json
{
    "total_rows": "//title",
    "elements": [
        "."
    ]
}
```

result

```json
[
  "利巴韦林注射液",
  "利巴韦林注射液"
]
```

## elements:{}

**字段+xpath**

elements下面的字段可直接为xpath,或者 TASK_(.+) 这样的格式来返回task中的相应字段内容，支持对返回内容的进一步修饰，同xpath返回的内容一样

**字段+hash**

 字段功能如下：

```
col: 直接提取此字段的xpath路径; 当col=~/^TASK_(.+)$/ 时，返回任务中对应key的值

text: 内容直接返回到结果中，作为标记字段

regexp: 按正则表达式提取内容

innerHtml: 按xpath提取html源代码

prefix: 在提取的内容上加前缀

postfix: 加后缀

callback: 以|分割的一个或多个字符串函数，比如 trim, parse_date, extract_date, extract_en_date, absolute_url,

function: regexp 与 return 构成的函数，更加灵活强大

must_match: 仅用在提取表格数据时，按正则丢弃某些不需要的行；非表格提取时不起作用
```

**示例单独提取文字**

```html
<html>
  <body>
    <span id="“key”">hello</span>
  </body>
</html>
```

提取html中hello的parse_function如下

```json
{
    "elements": {
        "content": "//span[@id='key']/text()"
    }
}
```

### 一级内容提取函数

优先级 `col > regexp > innerHtml > text`

若存在高优先级的字段，则忽略低优先级的字段

#### `col`

| 描述                        | 输入        | 关联输入                                                     | 输出   |
| --------------------------- | ----------- | ------------------------------------------------------------ | ------ |
| 提取这个在xpath路径下的内容 | xpath表达式 | type:array（xpath路径下有多个元素的时候，可以直接将每个元素分开返回） | list   |
|                             | xpath表达式 | type:string(默认值)                                          | String |

**示例**

Source

```html
<div>
  <span>张三</span><span>李四</span><span>王五</span><span>李二麻子</span>
</div>

```

Parse

```json
{
    "authors": {
        "col": "//div/span",
        "type": "array"
    }
}
```

Result

```json
{
    "authors": [
        "张三",
        "李四",
        "王五",
        "李二麻子"
    ]
}
```

#### `regexp`

| 描述                       | 输入       | 关联输入        | 输出            |
| -------------------------- | ---------- | --------------- | --------------- |
| 定位之后的结果进行正则提取 | 正则表达式 | return:[n]默认0 | 返回匹配的第n个 |

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
    "total_rows": "//title|//div",
    "elements": {
        "title": {
            "regexp": "注射液"
        }
    }
}
```

result

```json
[
  {
    "title": "注射液"
  },
  {
    "title": ""
  }
]
```

#### `innerHtml` 

|         描述         | 输入        | 关联输入extract_attachments    | 输出                                    |
| :------------------: | ----------- | ------------------------------ | --------------------------------------- |
| 网页源码的提取和处理 | xpath表达式 | 无（保留定位处的原始网页代码） | 返回xpath对应节点的html源码拼接后的字串 |
|                      | xpath表达式 | 有（提取链接）                 | 返回链接                                |



**示例1**

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
  "total_rows": "//title|//div",
  "elements": {
    "title": {
      "innerHtml": "."
    }
  }
}
```

result

```json
[
  {
    "title": "<title>利巴韦林注射液</title>"
  },
  {
    "title": "<div>利巴</div>"
  }
]
```



#### `text`

| 描述                           | 输入   | 输出   |
| ------------------------------ | ------ | ------ |
| 当值是固定的不需要从网页中获取 | string | string |



**示例1**

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
  "total_rows": "//title|//div",
  "elements": {
    "title": {
      "text": "hello"
    }
  }
}
```

result

```json
[
  {
    "title": "hello"
  },
  {
    "title": "hello"
  }
]
```



### 二级修饰函数

为提取后的数据进一步修饰的函数

优先级 `callback > function > default > data_out`

###### `callback`

| 可选输入     | 说明                                                         |   输出   |
| ------------ | ------------------------------------------------------------ | :------: |
| trim         | 删除半角空格                                                 | 修饰结果 |
| trim2        | 删除全角和半角空格                                           |          |
| parse_date   | 将不同格式的日期，格式化为：YYYY-MM-DD2017年1月1日==>2017-01-012017-1-1==>2017-01-012017.1.1==>2017-01-012017/1/1==>2017-01-01 |          |
| extract_date | 从字串中提取第一个匹配的日期，然后格式化为：YYYY-MM-DD       |          |
| extract_text | 清除html中标签，仅获得文字内容                               |          |
| dp2_filter   | 过滤不符合正则表达式的txt                                    |          |
| json_extract | 提取json中的某个元素                                         |          |
| absolute_url | 将相对地址转化为绝对地址                                     |          |

#### `function`



```json
{
    "function": {
        "regexp":"(\d+)(FEG)",
        "return": [
            "TAG",
            0,
            "HEL",
            1
        ],
        "type": "array"
    }
}
```

  - function有三个参数：regexp, return, type

    ###### `callback`

    | function参数 | 说明                                                         | 输入         |
    | ------------ | ------------------------------------------------------------ | ------------ |
    | regexp       | 可以通过()对部分匹配的内容分组，然后在return中按序号（从0开始）自由组合 | 正则表达式   |
    | return       | 除支持()匹配的序号外，还可以为其他字符串，返回的结果是按数组指定的次序拼接的结果 | 数组         |
    | type         | type默认为array, 返回list；若为’string’或其他则返回list直接拼接以后的字串 | string/array |

    Source

    ```html
    <p class="copyright">
      Copyright © 2010-2021 苏州二叶制药有限公司
      <a class="beian" href="http://beian.miit.gov.cn">苏ICP备18057909</a>
      技术支持：<a href="http://www.qiankunquan.net">乾坤圈™</a>
      <a href="http://www.szsgsj.gov.cn">苏州工商局</a>
    </p>
    ```

    parse

    ```json
    {
        "elements": {
            "company": {
                "col": "//p[@class='copyright']",
                "function": {
                    "regexp": "(\\w+)苏",
                    "type": "string",
                    "return": [
                        0
                    ]
                }
            }
        }
    }
    ```

    result

    ```json
    {
      "company": "苏州二叶制药有限公司"
    }
    ```

    修改type为array

    result

    ```json
    {
      "company": [
        "苏州二苏叶制药有限公司"
      ]
    }
    ```

    

#### `default`

| 描述                                                      | 输入        | 输出     |
| --------------------------------------------------------- | ----------- | -------- |
| 设定alternative节点的路径，当col节点返回的txt为空时触发。 | xpath表达式 | 定位结果 |

source

```html
<title>利巴韦林注射液利</title>
<div>利巴</div>
```

parse

```json
{
  "elements": {
    "title": {
      "col": "./col",
      "default": {
        "col": "//title"
      }
    }
  }
}
```

result

```json
{
  "title": "利巴韦林注射液利"
}
```

#### `data_out`

| 描述                                                         | 输入     | 输出 |
| ------------------------------------------------------------ | -------- | ---- |
| 对提取的字段，最后应用[JMESPath](https://jmespath.org/)或[jq](https://jqplay.org/)对结果进一步修饰 | jq表达式 | Json |

source

```html
<title>利巴韦林注射液利</title>
<div>利巴</div>
```

parse

```json
{
  "total_rows": "//title|//div",
  "elements": {
    "title": {
      "col": ".",
      "data_out": {"jq":"."}
    }
  }
}
```

result

```json
[
  {
    "title": "利巴韦林注射液利"
  },
  {
    "title": "利巴"
  }
]
```



### 三级前后缀函数

#### `prefix,postfix`

| 描述                                     | 输入   | 输出   |
| ---------------------------------------- | ------ | ------ |
| 前面的内容提取到后，最后把前后缀加上返回 | String | String |

**示例提取日期**

```html
<html><body><span id="date"> 2017年7月19日 </span></body></html>
```

提取日期并加上前后缀

```json
{
    "elements": {
        "date": {
            "prefix": "---",
            "col": "//span[@id=\"date\"]/text()",
            "callback": "trim|parse_date",
            "postfix": "---"
        }
    }
}
```

结果

```json
{
  "date": "---2017-07-19---"
}
```

## data_out

| 描述                       | 输入     | 输出 |
| -------------------------- | -------- | ---- |
| 对elements中的结果进行处理 | jq表达式 | Json |

**示例1**

选择列表中的第二个元素

source

```html
<title>利巴韦林注射液</title>
<div>利巴</div>
```

parse

```json
{
    "total_rows": "//title|//div",
    "elements": {
        "title": "."
    },
    "data_out": {
        "jq": ".[1]"
    }
}
```

result

```json
{
  "title": "利巴"
}
```

