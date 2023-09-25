 

# study

```json
{
  "STU":"",
  "exclude_workers":"",
  "steps": 
[
  {},
  {}
]
}
```

全局变量放在steps同级，只能为简单的 key==>value形式（value为字符串）

## `STU`

与其它study_name 不能冲突。

## `exclude_workers`

被排除的workers（处理任务的服务器）

## `steps`

steps为一个List结构，每个step按次序放在[]中

**一个典型的step结构**

```json
{

 "project_name": "NMPA_Drug_Law_PageNum",

 "url": "http://www.nmpa.gov.cn/WS04/CL2170/",

 "type": "one-off",

 "priority": 0,

 "fetch_method": "splash",

 "method": "GET",

 "status": 1,

 "charset": "UTF-8",

 "charact_string_start": "药品法规文件",

 "charact_string_end": "国家药品监督管理局",

 "pf_id": 172,

 "lua_id": 90,

 "data_out": {

  "jpath": "{TotalPageNum:TotalPages}"

 }

}
```

**step.dp2 task的配置参数**

```json
{
  "data_in":None,
  
  "study_id": None,
  "study_name": None,
  "project_name": None,
  "extra_data": None,
  "excluded_workers": None,
  "url": None,
  "type": "one-off",
  "priority": 0,
  "fetch_method": "direct",
  "method": "GET",
  "data": None,
  "cookies": None,
  "through_proxy": 0,
  "status": 0,
  "charset": "UTF-8",
  "charact_string_start": "",
  "charact_string_end": "",
  "charact_string_notry": None,
  "add_only":"0",
  "pf_id": None,
  "ck_id": None,
  "lua_id": None,
  "interval":""
}
```

### `study_id` 

自动生成

| 描述           | 必须   | 默认值 |
| -------------- | ------ | ------ |
| 每个step的名称 | 非必须 | None   |

### `study_name` 

| 描述           | 必须   | 默认值 |
| -------------- | ------ | ------ |
| 每个step的名称 | 非必须 | None   |

### `project_name` 

| 描述           | 必须 | 默认值 |
| -------------- | ---- | ------ |
| 每个step的名称 | 必须 | None   |

Task的名称，用来区别Task,同一网域下同类型的Task应该取一样的名字，在Study底下的Task的名字最尾建议是代表所提取网页的类型（如“.list”-表格,“.detail”-详细资料）

**示例**：

```json
{"project_name": "{STU}.totalpage"}
```

{STU}取全局变量的值

### `extra_data` 

| 描述           | 必须   | 默认值 |
| -------------- | ------ | ------ |
| 每个step的名称 | 非必须 | None   |

**示例**

数据来自data_in。在data_out时可以输出parse和extra_data的结果。

可以提取上一步的data_out结果以传入下一步中，或者输出到平台显示

extra_data 可以用来保存多step时需要的变量

```json
"extra_data": {
        "keyword": "{keyword}"
      }
```



### `url` 

| 描述                       | 必须 | 默认值 |
| -------------------------- | ---- | ------ |
| 这个Task所处理的网页的网址 | 必须 | None   |

**示例1:**

```json
"url":{
  "pattern": "http://www.nmpa.gov.cn/WS04/CL2170/index(*).html",
  "iteration": {
    "first": "",
    "start": 1,
    "stop": "{TotalPageNum}-1",
    "format": "_{}"
  }
}
```

!!! note

```
pattern的参数中必须含有(*)，这里为系列地址中要改变的部分；暂不支持同时改变多个变量的情况，但pattern中支持局部或全局变量
```

**iteration**的常规参数：

- **first** 可选，用来设定第一页与其他页面生成规律不同的情况；

- **start** 可选，默认从1开始；
- **stop** 可选，默认为”{TotalPageNum}”，即上一个step传来的数据中需包含TotalPageNum参数
- **format** 可选，默认为”{}”，也就是对数字不做改变，此处为python中的format格式：
  - 比如地址为：0001，0002，0003 时，format=“{:04d}"
  - {}前后增加的字符串会直接加到url地址中

**示例2:**

```json
"url": {
        "pattern": "http://www.nmpa.gov.cn/WS04/CL2170/index(*).html?offset={offset}",
        "iteration": {
          "first": "",
          "start": 1,
          "stop": "{TotalPageNum}-1",
          "format": "_{}”,
          “offset”:”(i-1)*10"
        }
}
```

**iteration**的扩展参数：

含有iteration的url，如果需要多个与页码相关的参数，可在iteration中增加相关变量，然后在pattern中直接引用。比如要增加offset，offset=(i-1)*10，i为当前页码，offset后面为关于页码i的有效表达式。

**示例3:**

当link为数组

```json
 "url": "{link}"
```

此时不需要传入页码参数

### `type`

| 描述     | 必须 | 默认值  |
| -------- | ---- | ------- |
| 请求类型 | 是   | one-off |

Task的更新类型，可选参数one-off 、periodic 两类，分别为“只运行一次”和“周期性地运行”。

### `priority`

| 描述   | 必须 | 默认值 |
| ------ | ---- | ------ |
| 优先级 | 是   | 0      |

!!!note

```
Priority (higher first and 10=run once)
```

### `fetch_method`

| 描述     | 必须 | 默认值 |
| -------- | ---- | ------ |
| 获取方法 | 是   | direct |

参数：（当无法请求到网页时可以采用模拟浏览器）direct，splash，Selenium

- direct:直接获取不模拟浏览器

- splash: 通过splash模拟浏览器获取

  示例代码：

  ```lua
  function main(splash, args)
    splash.images_enabled = false
    splash:set_custom_headers(args.headers)
    if args.through_proxy==1 then
      splash:on_request(function(request)
          request:set_timeout(30)
          request:set_proxy{
            host = args.host,
            port = args.port,
            type = args.http_type
          }
        end
      )
    end
    assert(splash:go(args.url))
    assert(splash:wait(0.5))
    --1修改select对应的元素名称
    local ele=splash:select('table')
    while not ele do
      assert(splash:wait(0.5))
      ele=splash:select('table')
    end
    assert(splash:wait(0.5))
    --2不要更改返回的格式
    return {
      html = splash:html(),
    }
  end
  ```

  

- Selenium:通过Selenium模拟浏览器获取

  示例代码：

  ```python
  try:
    self.driver.get('{url}')
    element = WebDriverWait(self.driver, 10).until(
      EC.presence_of_element_located((By.ID, 'ipv4'))
    )
    self.chrome_html = self.driver.page_source
  except Exception as e:
    msg = traceback.format_exc()
    self.chrome_msg=msg
  ```

  

### `method`

| 描述     | 必须 | 默认值 |
| -------- | ---- | ------ |
| 请求方法 | 是   | GET    |

浏览方法，有“GET”和“POST”两种

### `data` 

| 描述     | 必须                                                | 默认值 |
| -------- | --------------------------------------------------- | ------ |
| 请求数据 | 当method为“POST“时需要用data参数,否则不需要data参数 | None   |

### `cookies` 

| 描述         | 必须   | 默认值 |
| ------------ | ------ | ------ |
| 请求的cookie | 非必须 | None   |

是否添加cookie，有“with cookies”和“without cookies”两种，若选择“with cookies”,设置页面会增加一处空白的“cookies”填写栏



### `through_proxy`

| 描述         | 必须 | 默认值 |
| ------------ | ---- | ------ |
| 是否通过代理 | 是   | 0      |

### `status`

| 描述   | 必须 | 默认值 |
| ------ | ---- | ------ |
| 状态码 | 是   | 0      |

Task的启动状态，初始为准备启动，启动状态由系统自行设定，一般情况下用户不需要在这此处设定Task状态

### `interval`

| 描述     | 必须 | 默认值 |
| -------- | ---- | ------ |
| 更新频率 | 是   | 0      |

更新频率，用秒（s）作单位。当type为periodic 时起作用。

### `charset`

| 描述     | 必须 | 默认值 |
| -------- | ---- | ------ |
| 字符编码 | 是   | UTF-8  |

根据网页源码信息获取编码方式

```html
<meta charset="UTF-8">
```

### `charact_string_start`

| 描述     | 必须   | 默认值 |
| -------- | ------ | ------ |
| 开始字符 | 非必须 | None   |

目标网页html源代码开头含有的字符

### `charact_string_end` 

| 描述     | 必须   | 默认值 |
| -------- | ------ | ------ |
| 结束字符 | 非必须 | None   |

目标网页html源代码结尾含有的字符

### `charact_string_notry` 

| 描述       | 必须   | 默认值 |
| ---------- | ------ | ------ |
| 不尝试字符 | 非必须 | None   |

目标网页html源代码不会含有的字符

### `pf_id` 

| 描述  | 必须   | 默认值 |
| ----- | ------ | ------ |
| pf id | 非必须 | None   |

自动生成或使用现有的parse function id

### `lua_id` 

| 描述   | 必须   | 默认值 |
| ------ | ------ | ------ |
| lua id | 非必须 | None   |

自动生成或使用现有的lua code id

### `date_out` 

若要对传到下一步的数据进行修改，可用data_out来配置。

```json
data_out的结构如下：

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
```

[Study.data_out中支持的关键字](study.data_out.md)

### `data_in`

负责对传到这一步的数据进行修饰，然后再转给任务管理程序。

```json
data_in的结构如下：
{
      "data_in": {
        "data_for_test": [
          {
            "link": "http://www.topfond.com/product/1.html",
            "drug_name": "硫酸阿米卡星注射液"
          }
        ]
      },
```

[DP2_study实例](http://dp2.labqr.com/e/dp2/study?offset=0&order_by=&direction=&tnum=&id=&study_name=company.tfyy.drugs&status=&status_msg=&study_note=&study_content=)

|       |      |                                                              |
| ----- | ---- | ------------------------------------------------------------ |
| jpath | 可选 | JMESPath查询参数，当值为空时，代表对输入数据不处理           |
| api   | 可选 | 配置数据post到的api地址，包含以下三个参数：url: 必须, table: 可选，设定数据要保存到的表的名称，若API不需要，可以不设定；where: 可选，用来判断数据唯一性的条件，可为一个或多个条件，只能精确匹配；默认为{“id”:”{id}”}, 即用post数据中的id作为唯一性判断的标准。 若用默认的where时，要确保在post data中已经含有id字段 |

当data_out仅含有jpath参数时，可写成：”data_out”:”JMESPath"

data_in与data_out相同，只是没有api参数

## 变量替换规则

- step中任何地方可以用{variable_name}的形式代表运行中可替换的变量
- 变量优先从局部数据（比如上一个step中的data_out中数据）中查找，若没有就在全局变量中查找；若都没有，则变量不做替换

## 任务处理

step的任务管理程序只能处理 dict和list两种情况的数据，需用data_in和data_out将下载的数据转化成所需要的格式

- 若一个页面的数据会生成多个子任务时，传递的为list，list中每个元素分别用来配置要下载的子任务（这时url为字符串）
- 第二种生成多个子任务的情况是，传递的为dict，同时url为dict结构，这时会根据url中pattern和iteration两个参数，生成批量的子任务
- data_out的数据为dict，且url为string时，生成单一的任务
