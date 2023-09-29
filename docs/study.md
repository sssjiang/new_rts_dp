# study

![image-20230929111341107](assets/image-20230929111341107.png)

```json
{
  "STU": "",
  "exclude_workers": "",
  "steps": [{}, {}]
}
```

全局变量放在 steps 同级，只能为简单的 key==>value 形式（value 为字符串）

## `STU`

与其它 study_name 不能冲突。

## `exclude_workers`

被排除的 workers（处理任务的服务器）

## `steps`

steps 为一个 List 结构，每个 step 按次序放在[]中

**一个典型的 step 结构**

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

**step.dp2 task 的配置参数**

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

| 描述             | 必须   | 默认值 |
| ---------------- | ------ | ------ |
| 每个 step 的名称 | 非必须 | None   |

### `study_name`

| 描述             | 必须   | 默认值 |
| ---------------- | ------ | ------ |
| 每个 step 的名称 | 非必须 | None   |

### `project_name`

| 描述             | 必须 | 默认值 |
| ---------------- | ---- | ------ |
| 每个 step 的名称 | 必须 | None   |

Task 的名称，用来区别 Task,同一网域下同类型的 Task 应该取一样的名字，在 Study 底下的 Task 的名字最尾建议是代表所提取网页的类型（如“.list”-表格,“.detail”-详细资料）

**示例**：

```json
{ "project_name": "{STU}.totalpage" }
```

{STU}取全局变量的值

### `extra_data`

| 描述             | 必须   | 默认值 |
| ---------------- | ------ | ------ |
| 每个 step 的名称 | 非必须 | None   |

**示例**

数据来自 data_in。在 data_out 时可以输出 parse 和 extra_data 的结果。

可以提取上一步的 data_out 结果以传入下一步中，或者输出到平台显示

extra_data 可以用来保存多 step 时需要的变量

```json
{
  "extra_data": {
    "keyword": "{keyword}"
  }
}
```

### `url`

| 描述                         | 必须 | 默认值 |
| ---------------------------- | ---- | ------ |
| 这个 Task 所处理的网页的网址 | 必须 | None   |

**示例 1:**

```json
{
  "url": {
    "pattern": "http://www.nmpa.gov.cn/WS04/CL2170/index(*).html",
    "iteration": {
      "first": "",
      "start": 1,
      "stop": "{TotalPageNum}-1",
      "format": "_{}"
    }
  }
}
```

!!! note

```
pattern的参数中必须含有(*)，这里为系列地址中要改变的部分；暂不支持同时改变多个变量的情况，但pattern中支持局部或全局变量
```

**iteration**的常规参数：

- **first** 可选，用来设定第一页与其他页面生成规律不同的情况；

- **start** 可选，默认从 1 开始；
- **stop** 可选，默认为”{TotalPageNum}”，即上一个 step 传来的数据中需包含 TotalPageNum 参数
- **format** 可选，默认为”{}”，也就是对数字不做改变，此处为 python 中的 format 格式：
  - 比如地址为：0001，0002，0003 时，format=“{:04d}"
  - {}前后增加的字符串会直接加到 url 地址中

**示例 2:**

```json
{
  "url": {
    "pattern": "http://www.nmpa.gov.cn/WS04/CL2170/index(*).html?offset={offset}",
    "iteration": {
      "first": "",
      "start": 1,
      "stop": "{TotalPageNum}-1",
      "format": "_{}",
      "offset": "(i-1)*10"
    }
  }
}
```

**iteration**的扩展参数：

含有 iteration 的 url，如果需要多个与页码相关的参数，可在 iteration 中增加相关变量，然后在 pattern 中直接引用。比如要增加 offset，offset=(i-1)\*10，i 为当前页码，offset 后面为关于页码 i 的有效表达式。

**示例 3:**

当 link 为数组

```json
{ "url": "{link}" }
```

此时不需要传入页码参数

### `type`

| 描述     | 必须 | 默认值  |
| -------- | ---- | ------- |
| 请求类型 | 是   | one-off |

Task 的更新类型，可选参数 one-off 、periodic 两类，分别为“只运行一次”和“周期性地运行”。

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

- splash: 通过 splash 模拟浏览器获取

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

- Selenium:通过 Selenium 模拟浏览器获取

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

| 描述     | 必须                                                      | 默认值 |
| -------- | --------------------------------------------------------- | ------ |
| 请求数据 | 当 method 为“POST“时需要用 data 参数,否则不需要 data 参数 | None   |

### `cookies`

| 描述          | 必须   | 默认值 |
| ------------- | ------ | ------ |
| 请求的 cookie | 非必须 | None   |

是否添加 cookie，有“with cookies”和“without cookies”两种，若选择“with cookies”,设置页面会增加一处空白的“cookies”填写栏

### `through_proxy`

| 描述         | 必须   | 默认值 |
| ------------ | ------ | ------ |
| 是否通过代理 | 非必须 | 0      |

### `status`

| 描述   | 必须 | 默认值 |
| ------ | ---- | ------ |
| 状态码 | 是   | 0      |

Task 的启动状态，初始为准备启动，启动状态由系统自行设定，一般情况下用户不需要在这此处设定 Task 状态

### `interval`

| 描述     | 必须                                                        | 默认值 |
| -------- | ----------------------------------------------------------- | ------ |
| 更新频率 | 当 type 为 periodic 时是必须，当 type 为 one-off 则为非必需 | 0      |

更新频率，用秒（s）作单位。

### `charset`

| 描述     | 必须 | 默认值 |
| -------- | ---- | ------ |
| 字符编码 | 是   | UTF-8  |

根据网页源码信息获取编码方式

```html
<meta charset="UTF-8" />
```

### `charact_string_start`

| 描述     | 必须   | 默认值 |
| -------- | ------ | ------ |
| 开始字符 | 非必须 | None   |

目标网页 html 源代码开头含有的字符

### `charact_string_end`

| 描述     | 必须   | 默认值 |
| -------- | ------ | ------ |
| 结束字符 | 非必须 | None   |

目标网页 html 源代码结尾含有的字符

### `charact_string_notry`

| 描述       | 必须   | 默认值 |
| ---------- | ------ | ------ |
| 不尝试字符 | 非必须 | None   |

目标网页 html 源代码不会含有的字符

### `pf_id`

| 描述  | 必须   | 默认值 |
| ----- | ------ | ------ |
| pf id | 非必须 | None   |

自动生成或使用现有的 parse function id

### `lua_id`

| 描述   | 必须   | 默认值 |
| ------ | ------ | ------ |
| lua id | 非必须 | None   |

自动生成或使用现有的 lua code id

### `date_out`

若要对传到下一步的数据进行修改，可用 data_out 来配置。

```json
{
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
  }
}
```

[Study.data_out 中支持的关键字](study.data_out.md)

### `data_in`

负责对传到这一步的数据进行修饰，然后再转给任务管理程序。

```json
{
  "data_in": {
    "data_for_test": [
      {
        "link": "http://www.topfond.com/product/1.html",
        "drug_name": "硫酸阿米卡星注射液"
      }
    ]
  }
}
```

[DP2_study 实例](http://dp2.labqr.com/e/dp2/study?offset=0&order_by=&direction=&tnum=&id=&study_name=company.tfyy.drugs&status=&status_msg=&study_note=&study_content=)

|       |      |                                                                                                                                                                                                                                                                                                                                     |
| ----- | ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| jpath | 可选 | JMESPath 查询参数，当值为空时，代表对输入数据不处理                                                                                                                                                                                                                                                                                 |
| api   | 可选 | 配置数据 post 到的 api 地址，包含以下三个参数：url: 必须, table: 可选，设定数据要保存到的表的名称，若 API 不需要，可以不设定；where: 可选，用来判断数据唯一性的条件，可为一个或多个条件，只能精确匹配；默认为{“id”:”{id}”}, 即用 post 数据中的 id 作为唯一性判断的标准。 若用默认的 where 时，要确保在 post data 中已经含有 id 字段 |

当 data_out 仅含有 jpath 参数时，可写成：”data_out”:”JMESPath"

data_in 与 data_out 相同，只是没有 api 参数

## 变量替换规则

- step 中任何地方可以用{variable_name}的形式代表运行中可替换的变量
- 变量优先从局部数据（比如上一个 step 中的 data_out 中数据）中查找，若没有就在全局变量中查找；若都没有，则变量不做替换

## 任务处理

step 的任务管理程序只能处理 dict 和 list 两种情况的数据，需用 data_in 和 data_out 将下载的数据转化成所需要的格式

- 若一个页面的数据会生成多个子任务时，传递的为 list，list 中每个元素分别用来配置要下载的子任务（这时 url 为字符串）
- 第二种生成多个子任务的情况是，传递的为 dict，同时 url 为 dict 结构，这时会根据 url 中 pattern 和 iteration 两个参数，生成批量的子任务
- data_out 的数据为 dict，且 url 为 string 时，生成单一的任务
