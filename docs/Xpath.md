# Xpath

### 1. 选择节点 

- 通过元素名称选择节点：`//element`
- 通过元素名称和属性选择节点：`//element[@attribute='value']`
- 通过元素名称和多个属性选择节点：`//element[@attribute1='value1' and @attribute2='value2']`
-  通过元素名称和属性值包含特定字符串选择节点：`//element[contains(@attribute, 'value')]` 

### 2. 节点关系 

- 选择父节点：`/parent::element` 
- 选择子节点：`/child::element` 
- 选择上一个兄弟节点：`/preceding-sibling::element` 
- 选择下一个兄弟节点：`/following-sibling::element` 

### 3. 位置选择

- 选择第n个节点：`(//element)[n]` 

- 选择第一个节点：`(//element)[1]`
- 选择最后一个节点：`(//element)[last()]` 
- 选择前n个节点：`(//element)[position() <= n]` 
- 选择最后n个节点：`(//element)[position() > last() - n]` 

### 4. 文本匹配 

- 选择包含特定文本的节点：`//element[text()='text']` 
- 选择文本以特定字符串开头的节点：`//element[starts-with(text(), 'text')]` 
- 选择文本以特定字符串结尾的节点：`//element[ends-with(text(), 'text')]` 
- 选择文本包含特定字符串的节点：`//element[contains(text(), 'text')]` 

### 5. 数值匹配 

- 选择属性值等于特定数值的节点：`//element[@attribute=number]` 
- 选择属性值大于特定数值的节点：`//element[@attribute>number]` 
- 选择属性值小于特定数值的节点：`//element[@attribute=number and @attribute<=number]` 

### 6. 逻辑运算

- 选择满足多个条件的节点：`//element[condition1 and condition2]` 
- 选择满足任意一个条件的节点：`//element[condition1 or condition2]` 
- 选择不满足条件的节点：`//element[not(condition)]`

 ### 7. 组合使用 

- 多个条件组合使用：`//element[condition1 and condition2]/child::element[condition3]` 以上是一些常用的Xpath定位功能，可以根据具体需求灵活运用。

## xpath定位中starts-with、contains和text()的用法

[xpath_resource](https://devhints.io/xpath)

### starts-with

匹配一个属性开始位置的关键字

### contains 

匹配一个属性值中包含的字符串

### text()定位

  查找name属性中开始位置包含'name1'关键字的页面元素

```
//input[starts-with(@name,'name1')] 
```

   查找name属性中包含na关键字的页面元素

```
//input[contains(@name,'na')]  
```

text（） 匹配的是显示文本信息，此处也可以用来做定位用

**示例1:**

```html
<a href="http://www.baidu.com">百度搜索</a>
```

```
 //a[text()='百度搜索'] or

//a[contains(text(),"百度搜索”)]
```

示例2:

```html
<td><a href="/scripts/cder/daf/index.cfm?event=overview.process&ApplNo=018916" title="Click to view HEPARIN SODIUM 5,000 UNITS IN SODIUM CHLORIDE 0.9% (HEPARIN SODIUM)">HEPARIN SODIUM 5,000 UNITS IN SODIUM CHLORIDE 0.9%<br />NDA   #018916</a></td>
```

提取药名和ID

方法 sibling：

```json
{drug_name:"//td/a/text()[following-sibling::br]",
 id: "//td/a/text()[preceding-sibling::br]"}
```

text与\<br>都是同级节点，drug_name 后的xpath代表提取同级节点中的弟弟节点为br的text

方法 index：

```json
{drug_name: "//td/a/text()[1]",
id: "/td/a/text()[2]"}
```

