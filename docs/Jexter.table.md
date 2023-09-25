

### jexter for table

##### 按第一行标题提取表格数据(列数固定，行数可变)

- 若需要解析多行的表格数据，在elements同级增加total_rows节点

  - total_rows节点为所有行的数组xpath路径

  - 若elements中字段的相对应的rows与total_rows指定的路径不同时，可以在col同级增加row节点

- elements通常为hash数组{}，这样返回的所有字段都必须有名字，若希望返回没有名字的数组，可以在elements后面放一个由xpath字串构成的数组

- total_rows 中的xpath路径必须为针对整个页面的路径，不能是相对于某个节点的路径

**示例嵌套循环+Elements 为数组**

```html
<div class="record-item">
    <div class="left-record">
        <div class="record-title">
            <span class="index">8.</span>
            <a class="fulltext" href="http://f.wanfangdata.com.cn/download/Periodical_swhx200812012.aspx" target="_blank">全文</a>
            <a class="title" href="http://d.old.wanfangdata.com.cn/Periodical/swhx200812012" target="_blank">P-糖蛋白在多药耐药的K562细胞转运苯妥英纳与<em>卡马西平</em>中的作用</a>
            <span class="cited">(<t>被引用</t>&nbsp;8&nbsp;<t>次</t>)</span>
            
        </div>
        <div class="record-subtitle">
            [期刊论文]&nbsp;
        <a href="http://c.old.wanfangdata.com.cn/Periodical-swhx.aspx">《生物化学与生物物理进展》</a>
            <span class="core">
                <span title="被中信所《中国科技期刊引证报告》收录">ISTIC</span>
                
                <span title="被SCI收录">SCI</span>
                <span title="被北京大学《中文核心期刊要目总览》收录">PKU</span>
                
            </span>-<a href="http://c.old.wanfangdata.com.cn/periodical/swhx/2008-12.aspx">2008年12期</a>
            <a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=swhx200812012&;Name=%e9%99%88%e8%8b%b1%e8%be%89">陈英辉</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=swhx200812012&;Name=%e8%b5%b5%e6%b0%b8%e6%b3%a2">赵永波</a>
        </div>
        <div class="record-desc">
            研究证实,多药转运体与难治性癫痫耐药机制密切相关,P-糖蛋白在其中起重要作用.主要研究P-糖蛋白拮抗剂维拉帕米对P-糖蛋白过表达的K562细胞耐药性及细胞内苯妥英纳与<em>卡马西平</em>浓度的影响.首先建立了P-糖蛋白高表达的K56...<br>
        </div>
        <div class="record-keyword">
            <span>难治性癫痫</span><span>P-糖蛋白</span><span>维拉帕米</span><span>多药耐药</span>
        </div>
    </div>
    <div class="record-action-link">
        
        <a class="download" href="http://f.wanfangdata.com.cn/download/Periodical_swhx200812012.aspx" target="_blank">
            <i class="icon iconfont icon-download"></i>
            <span class="text">下载全文</span>
        </a>
        <a class="view" href="http://f.wanfangdata.com.cn/view/P-糖蛋白在多药耐药的K562细胞转运苯妥英纳与卡马西平中的作用.aspx?ID=Periodical_swhx200812012" target="_blank">
            <i class="icon iconfont icon-view"></i>
            <span class="text">查看全文</span>
        </a>
        
        <a class="export exportLink" data-resourceid="Periodical_swhx200812012">
            <i class="icon iconfont icon-export"></i>
            <span class="text">导出</span>
        </a>
    </div>
</div>


<div class="record-item">
    <div class="left-record">
        <div class="record-title">
            <span class="index">9.</span>
            <a class="fulltext" href="http://f.wanfangdata.com.cn/download/Periodical_zglcylxzz201412017.aspx" target="_blank">全文</a>
            <a class="title" href="http://d.old.wanfangdata.com.cn/Periodical/zglcylxzz201412017" target="_blank">奥卡西平和<em>卡马西平</em>治疗原发性三叉神经痛的系统评价和荟萃分析</a>
            <span class="cited">(<t>被引用</t>&nbsp;13&nbsp;<t>次</t>)</span>
            
        </div>
        <div class="record-subtitle">
            [期刊论文]&nbsp;
        <a href="http://c.old.wanfangdata.com.cn/Periodical-zglcylxzz.aspx">《中国临床药理学杂志》</a>
            <span class="core">
                <span title="被中信所《中国科技期刊引证报告》收录">ISTIC</span>
                
                
                <span title="被北京大学《中文核心期刊要目总览》收录">PKU</span>
                
            </span>-<a href="http://c.old.wanfangdata.com.cn/periodical/zglcylxzz/2014-12.aspx">2014年12期</a>
            <a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=zglcylxzz201412017&;Name=%e7%bd%97%e7%a5%8e%e6%98%8e">罗祎明</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=zglcylxzz201412017&;Name=%e5%be%90%e6%8d%b7%e6%85%a7">徐捷慧</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=zglcylxzz201412017&;Name=%e6%98%93%e6%b9%9b%e8%8b%97">易湛苗</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=zglcylxzz201412017&;Name=%e7%bf%9f%e6%89%80%e8%bf%aa">翟所迪</a>
        </div>
        <div class="record-desc">
            目的：评价奥卡西平和<em>卡马西平</em>治疗原发性三叉神经痛的疗效和安全性。方法计算机检索Cochrane library、PubMed、Medline、中国生物医学文献数据库、中国知网和万方等数据库，结合手工检索，收集比较奥卡西平与<em>卡马西平</em>治疗原发...<br>
        </div>
        <div class="record-keyword">
            <span>奥卡西平</span><span>卡马西平</span><span>三叉神经痛</span><span>荟萃分析</span><span>oxcarbazepine</span><span>carbamazepine</span><span>primary trigeminal neuralgia</span><span>Meta-analysis</span>
        </div>
    </div>
    <div class="record-action-link">
        
        <a class="download" href="http://f.wanfangdata.com.cn/download/Periodical_zglcylxzz201412017.aspx" target="_blank">
            <i class="icon iconfont icon-download"></i>
            <span class="text">下载全文</span>
        </a>
        <a class="view" href="http://f.wanfangdata.com.cn/view/奥卡西平和卡马西平治疗原发性三叉神经痛的系统评价和荟萃分析.aspx?ID=Periodical_zglcylxzz201412017" target="_blank">
            <i class="icon iconfont icon-view"></i>
            <span class="text">查看全文</span>
        </a>
        
        <a class="export exportLink" data-resourceid="Periodical_zglcylxzz201412017">
            <i class="icon iconfont icon-export"></i>
            <span class="text">导出</span>
        </a>
    </div>
</div>


<div class="record-item">
    <div class="left-record">
        <div class="record-title">
            <span class="index">10.</span>
            
            <a class="title" href="http://d.old.wanfangdata.com.cn/Periodical/hzlgdxxb201312024" target="_blank">紫外激活过硫酸盐降解水中<em>卡马西平</em>研究</a>
            <span class="cited">(<t>被引用</t>&nbsp;15&nbsp;<t>次</t>)</span>
            
        </div>
        <div class="record-subtitle">
            [期刊论文]&nbsp;
        <a href="http://c.old.wanfangdata.com.cn/Periodical-hzlgdxxb.aspx">《华中科技大学学报（自然科学版）》</a>
            <span class="core">
                <span title="被中信所《中国科技期刊引证报告》收录">ISTIC</span>
                <span title="被EI收录">EI</span>
                
                <span title="被北京大学《中文核心期刊要目总览》收录">PKU</span>
                
            </span>-<a href="http://c.old.wanfangdata.com.cn/periodical/hzlgdxxb/2013-12.aspx">2013年12期</a>
            <a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=hzlgdxxb201312024&;Name=%e9%ab%98%e4%b9%83%e4%ba%91">高乃云</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=hzlgdxxb201312024&;Name=%e8%83%a1%e6%a0%a9%e8%b1%aa">胡栩豪</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=hzlgdxxb201312024&;Name=%e9%82%93%e9%9d%96">邓靖</a><a class="creator" target="_blank" href="http://social.old.wanfangdata.com.cn/Locate.ashx?ArticleId=hzlgdxxb201312024&;Name=%e9%99%88%e4%b9%89%e6%98%a5">陈义春</a>
        </div>
        <div class="record-desc">
            针对传统工艺难以有效去除水中抗生素的问题,采用一种高级氧化技术去除水中典型药物-<em>卡马西平</em>(CBZ).考察了过硫酸盐浓度、<em>卡马西平</em>初始浓度、pH值、碳酸根离子和氯离子对<em>卡马西平</em>降解效果的影响.结果表明:紫外光(UV)会催化...<br>
        </div>
        <div class="record-keyword">
            <span>卡马西平</span><span>紫外光</span><span>过硫酸盐</span><span>硫酸自由基</span><span>动力学</span><span>carbamazepine</span><span>UV</span><span>persulfate</span><span>sulfate radicals</span><span>kinetics</span>
        </div>
    </div>
    <div class="record-action-link">
        
        <a class="export exportLink" data-resourceid="Periodical_hzlgdxxb201312024">
            <i class="icon iconfont icon-export"></i>
            <span class="text">导出</span>
        </a>
    </div>
</div>


```

Parse function:

```json
{
    "total_rows": "//div[@class='left-record']",
    "elements": {
        "creator": {
            "elements": [
                "./text()"
            ],
            "total_rows": "//div[@class='record-subtitle']/a[@class='creator']"
        },
        "keyword": {
            "elements": [
                "."
            ],
            "total_rows": "//div[@class='record-keyword' ]/span"
        }
    }
}
```

Result:

```json
[
  {
    "creator": [
      "陈英辉",
      "赵永波",
      "罗祎明",
      "徐捷慧",
      "易湛苗",
      "翟所迪",
      "高乃云",
      "胡栩豪",
      "邓靖",
      "陈义春"
    ],
    "keyword": [
      "难治性癫痫",
      "P-糖蛋白",
      "维拉帕米",
      "多药耐药",
      "奥卡西平",
      "卡马西平",
      "三叉神经痛",
      "荟萃分析",
      "oxcarbazepine",
      "carbamazepine",
      "primary trigeminal neuralgia",
      "Meta-analysis",
      "卡马西平",
      "紫外光",
      "过硫酸盐",
      "硫酸自由基",
      "动力学",
      "carbamazepine",
      "UV",
      "persulfate",
      "sulfate radicals",
      "kinetics"
    ]
  },
  {
    "creator": [
      "陈英辉",
      "赵永波",
      "罗祎明",
      "徐捷慧",
      "易湛苗",
      "翟所迪",
      "高乃云",
      "胡栩豪",
      "邓靖",
      "陈义春"
    ],
    "keyword": [
      "难治性癫痫",
      "P-糖蛋白",
      "维拉帕米",
      "多药耐药",
      "奥卡西平",
      "卡马西平",
      "三叉神经痛",
      "荟萃分析",
      "oxcarbazepine",
      "carbamazepine",
      "primary trigeminal neuralgia",
      "Meta-analysis",
      "卡马西平",
      "紫外光",
      "过硫酸盐",
      "硫酸自由基",
      "动力学",
      "carbamazepine",
      "UV",
      "persulfate",
      "sulfate radicals",
      "kinetics"
    ]
  },
  {
    "creator": [
      "陈英辉",
      "赵永波",
      "罗祎明",
      "徐捷慧",
      "易湛苗",
      "翟所迪",
      "高乃云",
      "胡栩豪",
      "邓靖",
      "陈义春"
    ],
    "keyword": [
      "难治性癫痫",
      "P-糖蛋白",
      "维拉帕米",
      "多药耐药",
      "奥卡西平",
      "卡马西平",
      "三叉神经痛",
      "荟萃分析",
      "oxcarbazepine",
      "carbamazepine",
      "primary trigeminal neuralgia",
      "Meta-analysis",
      "卡马西平",
      "紫外光",
      "过硫酸盐",
      "硫酸自由基",
      "动力学",
      "carbamazepine",
      "UV",
      "persulfate",
      "sulfate radicals",
      "kinetics"
    ]
  }
]
```

##### **按列标题提取表格数据（列数固定，行数可变）**

###### 示例1

```json
{
  "elements": {
    "table": {
      "rows": "//div[@class='monograph_details_text_content']",
      "cells": "./label|./div",
      "title_column": {
        "fields": {
          "dp2_id": {
            "col": "TASK_id"
          },
          "standard_InChI": {
            "col": ".//div[@id='InCHI_val']",
            "name": "Standard InChI:"
          },
          "standard_InChIKey": {
            "col": ".//div[@id='inchikey_val']",
            "name": "Standard InChIKey:"
          }
        }
      }
    }
  },
  "data_out": "merge(table,additional_properties)"
}
```

1. 配置放在elements的一个字段中
2. rows是表格中每一行的路径
3. cells指定每一行中要提取的单元格的相对路径，若有多种时，用"|"分别写出来
4. title_column设置每一个字段的要匹配的行名字name，col设定内容所在的相对路径
5. title_column中也可以设定title所在列的序号title_index（默认0），以及content中所在列的序号content_index（默认1）
6. 每个字段中的col可以设定为相当于内容单元格的相对路径，以”./“开头；若不是”./“开头，则认为是全局的路径
7. fields中的字段，可以通过name确定row_index，也可以直接指定row_index

###### 示例2

解析第一列为title的表格

```json
{
    "table2": {
        "rows": "(//div[@class='listmain']/div/table/tbody/tr)[position()>1]",
        "cells": "./td",
        "title_column": {
            "fields": {
                "dp2_id": {
                    "col": "TASK_id"
                },
                "gcid": {
                    "col": "TASK_url",
                    "function": {
                        "regexp": "Id=(\\d+)$",
                        "return": [
                            0
                        ],
                        "type": "string"
                    }
                },
                "auth_num": {
                    "name": "批准文号",
                    "col": "."
                },
                "drug_name": {
                    "name": "产品名称"
                },
                "drug_name_en": {
                    "name": "英文名称"
                }
            }
        }
    }
}
```

- 通过rows, cells, title_column确定一个表格
- rows 指定所有行所在的路径，用position()排除不需要的行
- cells 指定每行中每个元素的相对路径
- title_column 指定每行的字段名称和对应的title内容，放在fields中
- 若不设定fields，则自动用第一列的名字作为字段名
- fields中字段同elements的字段一样，用col指定路径，支持function, callback等
- 若字段名字的路径不是默认的“.”，则需显式设定col
- 相比于elements的字段，多了name，用于指定字段的名称，用于匹配行

###### 示例3

![image-20230921103240151](assets/image-20230921103240151.png)

parse

```json
{
    "REACH_Registration_Evaluation_Authorisation_and_Restriction_of_Chemicals_Regulation": {
        "elements": {
            "table": {
                "rows": "//div[@class='dissProcessesWrapper']//div[@class='panel-group '][1]//div[@class='anothercustomBox']//li",
                "cells": "./div/div",
                "title_column": {
                    "fields": {
                        "dp2_id": {
                            "col": "TASK_id"
                        },
                        "annex_iii": {
                            "col": "./div",
                            "name": "Annex III: criteria for 1 - 10 tonne registered substances"
                        },
                        "pre_registered_substances": {
                            "col": "./div",
                            "name": "Pre-registered substances"
                        },
                        "registered_substances": {
                            "col": "./div",
                            "name": "Registered substances factsheets"
                        }
                    }
                }
            }
        }
    }
}
```

result

```json
{
    "REACH_Registration_Evaluation_Authorisation_and_Restriction_of_Chemicals_Regulation": {
        "table": {
            "dp2_id": "32134845",
            "annex_iii": "Substances predicted as likely to meet criteria for category 1A or 1B carcinogenicity, mutagenicity, or reproductive toxicity, or with dispersive or diffuse use(s) where predicted likely to meet any classification criterion for health or environmental hazards, or where there is a nanoform soluble in biological and environmental media.",
            "pre_registered_substances": "Substances indicated, in 2009, as being intended to be registered by at least one company in the EEA.",
            "registered_substances": "Substances which have been registered and can be placed on the EEA market by those companies with a valid registration."
        }
    }
}
```

参考项目 DP2_id:32134845

##### **按第一行标题提取表格数据（列数可变，行数可变）**

```json
{
  "elements": {
    "list": {
      "rows": "//table[@class='']//tr",
      "cells":"./td",
      "title_row": "//table[@class='td1']//tr/td",
    }
  }
}

{
  "elements": {
    "list": {
      "rows": "//table[@class='']//tr",
      "cells":"./td",
      "title_row": {
        "col": "//table[@class='td1']//tr/td",
        "fields":{
          "sn":{
            "name":"流水号"
          },
          "general_name":{
            "col":".",
            "name":"通用名",
            "col_index":2
          }
        }
      }
    }
  }
}
```

1. 配置放在elements的一个字段中
2. rows是表格中每一行的路径（不包含标题所在的行，仅是内容的行）
3. cells指定内容中每一行中要提取的单元格的相对路径（默认为“./td”），若有多种时，用"|"分别写出来
4. title_row为字串时，即为标题行所在的路径，默认用标题中文字作为每个字段的名字
5. title_row为dict时，col指定标题行路径（要指定到具体标题名字的位置），fields指定每个字段的名字和相对路径，默认为”."
6. fields中的设置方法与前相同，name指定标题的名字，需完全匹配，col指定相对路径, col_index指定时，则用这个序号，忽略name; 若无col_index时，根据name确定col_index

Parse

```json
{
    "REACH_Registration_Evaluation_Authorisation_and_Restriction_of_Chemicals_Regulation": {
        "elements": {
            "list": {
                "rows": "//div[@class='dissProcessesWrapper']//div[@class='panel-group '][1]//div[@class='anothercustomBox']//li",
                "cells": "./div/div",
                "title_row": "//div[@class='dissProcessesWrapper']//div[@class='panel-group '][1]//div[@class='anothercustomBox']//li/div/div[1]"
            }
        }
    }
}
```

Result

```json
{
    "REACH_Registration_Evaluation_Authorisation_and_Restriction_of_Chemicals_Regulation": {
        "list": [
            {
                "Annex III: criteria for 1 - 10 tonne registered substances": "Annex III: criteria for 1 - 10 tonne registered substances",
                "Pre-registered substances": "Substances predicted as likely to meet criteria for category 1A or 1B carcinogenicity, mutagenicity, or reproductive toxicity, or with dispersive or diffuse use(s) where predicted likely to meet any classification criterion for health or environmental hazards, or where there is a nanoform soluble in biological and environmental media.",
                "Registered substances factsheets": ""
            },
            {
                "Annex III: criteria for 1 - 10 tonne registered substances": "Pre-registered substances",
                "Pre-registered substances": "Substances indicated, in 2009, as being intended to be registered by at least one company in the EEA.",
                "Registered substances factsheets": ""
            },
            {
                "Annex III: criteria for 1 - 10 tonne registered substances": "Registered substances factsheets",
                "Pre-registered substances": "Substances which have been registered and can be placed on the EEA market by those companies with a valid registration.",
                "Registered substances factsheets": ""
            }
        ]
    }
}
```

参考项目 DP2_id:32134845
