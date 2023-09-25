# Jexter

## parent

设置绝对路径，让element的col参数在此基础上使用相对路径。

**示例1**

source

```html
<title>利巴韦林注射液</title>

```

parse

```json
{
  "parent":"//title",
  "elements": {
    "title":"."
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

获取多个{"key":"value"}，返回列表。(total_rows 也具备parent的功能)

**示例1**

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
   "elements": {"title":"."}
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

当提取的值不需要“key”时，可以用此方法提取，返回列表。

##### 示例1

elements:[] 单独使用

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "elements": ["//title","//dir"]
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
<dir><title>利巴韦林注射液</title><dir>
```

parse

```json
{
  "total_rows":"//title",
  "elements": ["."]
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
$html=‘<html><body><span id=“key”>hello</span></body></html>';

```

提取html中hello的parse_function如下

```json
{"elements":{"content":"//span[@id=‘key’]/text()"}}
```

### 一级内容提取函数

优先级 `col > regexp > innerHtml > text`

若存在高优先级的字段，则忽略低优先级的字段

#### `col`

默认返回xpath对应的string，若设定`type:array`，则会返回不为空的list，这个在xpath路径下有多个元素的时候，可以直接将每个元素分开返回，比如有html:

```
<div><span>张三</span><span>李四</span><span>王五</span><span>李二麻子</span></div>
```

```json
“authors": {“col": “//div/span”, “type“: ”array“}
```

上面的路径中，若不指定array，返回的是所有author连在一起的字串，指定type为array后，返回

```json
{"authors":["张三", "李四", "王五", "李二麻子"]}
```

#### `regexp`

相当于function的简化版，若不设定return, 则默认返回每个匹配的第一个，即 return = [0]

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
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

返回xpath对应节点的html源码拼接后的字串

**示例1**

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
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
    "title": "<dir>利巴</dir>"
  }
]
```



#### `text`

当值是固定的不需要从网页中获取。

**示例1**

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
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

###### `Callback`

| 可选参数     | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| trim         | 删除半角空格                                                 |
| trim2        | 删除全角和半角空格                                           |
| parse_date   | 将不同格式的日期，格式化为：YYYY-MM-DD2017年1月1日==>2017-01-012017-1-1==>2017-01-012017.1.1==>2017-01-012017/1/1==>2017-01-01 |
| extract_date | 从字串中提取第一个匹配的日期，然后格式化为：YYYY-MM-DD       |
| extract_text | 清除html中标签，仅获得文字内容                               |
| dp2_filter   | 过滤不符合正则表达式的txt                                    |
| json_extract | 提取json中的某个元素                                         |
| absolute_url | 将相对地址转化为绝对地址                                     |

#### `function`

```json
{"function":{"regexp":"(\d+)(FEG)","return":["TAG",0,"HEL",1],"type":"array"}}
```

  - function有三个参数：regexp, return, type

  - regexp为正则表达式，可以通过()对部分匹配的内容分组，然后在return中按序号（从0开始）自由组合

  - return中除支持()匹配的序号外，还可以为其他字符串，返回的结果是按数组指定的次序拼接的结果

  - type默认为array, 返回list；若为’string’或其他则返回list直接拼接以后的字串

    Source

    ```html
    			<p class="copyright">Copyright © 2010-2021 苏州二叶制药有限公司 <a class="beian" href="http://beian.miit.gov.cn">苏ICP备18057909</a> 技术支持：<a href="http://www.qiankunquan.net">乾坤圈™</a> <a href="http://www.szsgsj.gov.cn">苏州工商局</a></p>
    
    ```

    parse

    ```json
       {"elements":{"company": {
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

设定alternative节点的路径，当col节点返回的txt为空时触发。

source

```html
<title>利巴韦林注射液利</title>
<dir>利巴</dir>
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

最后应用[JMESPath](https://jmespath.org/)或[jq](https://jqplay.org/)对结果进一步修饰

source

```html
<title>利巴韦林注射液利</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
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

前面的内容提取到后，最后把前后缀加上返回

**示例提取日期**

```html
<html><body><span id="date"> 2017年7月19日 </span></body></html>
```

提取日期并加上前后缀

```json
{
  "elements":{
    "date":{
      "prefix":"---",
      "col":"//span[@id=\"date\"]/text()",
      "callback":"trim|parse_date",
      "postfix":"---"
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

对elements中的结果进行处理

**示例1**

选择列表中的第二个元素

source

```html
<title>利巴韦林注射液</title>
<dir>利巴</dir>
```

parse

```json
{
  "total_rows": "//title|//dir",
   "elements": {"title":"."},
   "data_out":{
     "jq":".[1]"
   }
}
```

result

```json
{
  "title": "利巴"
}
```

