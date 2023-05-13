# element 多选框点击一个全部选中的问题

```vue
<el-checkbox-group v-model="checkList">
    <el-checkbox label="复选框 A"></el-checkbox>
    <el-checkbox label="复选框 B"></el-checkbox>
    <el-checkbox label="复选框 C"></el-checkbox>
</el-checkbox-group>

```

v-model绑定的值需要是一个数组，不能是空字符或者是其他的；不然可能会出现点击一个多选框，然后其他多选框都同时被选中的情况。

```vue
  export default {
    data () {
      return {
        checkList:[]
        //checkList:''
      };
    }
  };

```

然后又仔细看了一下官方文档，是因为使用v-model需要绑定类型的变量

`checkbox-group` 元素能把多个 checkbox 管理为一组，只需要在 Group 中使用 `v-mode` 绑定 `Array` 类型的变量即可。`el-checkbox` 的 `label` 属性是该 checkbox 对应的值，若该标签中无内容，则该属性也充当 checkbox 按钮后的介绍。`label` 与数组中的元素值相对应，如果存在指定的值则为选中状态，否则为不选中。

#### checkbox-group 的属性
![RUNOOB 图标](https://raw.githubusercontent.com/royegit/notes/master/%E5%89%8D%E7%AB%AF/vue%E7%AC%94%E8%AE%B0/image/20201022173034175.png "RUNOOB")


## Vue实现点击表格单元格出现输入框，失去焦点隐藏输入框功能

#### Vue实现点击表格单元格出现输入框，失去焦点隐藏输入框功能

效果如下：
![RUNOOB 图标](https://raw.githubusercontent.com/royegit/notes/master/%E5%89%8D%E7%AB%AF/vue%E7%AC%94%E8%AE%B0/image/77958dd4d3b046f6ac04c35cac452e93.png "RUNOOB")

代码如下：

```vue
<template>
  <div>
     <el-table
      :data="tableData"
      row-key="id"
      @cell-click="editCell" 
      style="width: 700px;">
      <el-table-column align="center" label="日期" show-overflow-tooltip type="date">
        <template slot-scope="scope">
          <el-input
            :ref="`date-${scope.row.id}`"
            v-model="scope.row.date" 
            v-show="scope.row.id === tabClickId && tabClickLabel === '日期'" placeholder="日期" 
            @blur="inputBlur(scope.row)">
          </el-input>
          <div class="cell-text" v-show="scope.row.id !== tabClickId || tabClickLabel !== '日期'">{{ scope.row.date }}</div>
        </template>
      </el-table-column>
      <el-table-column align="center" label="姓名" show-overflow-tooltip type="name">
        <template slot-scope="scope">
          <el-input
            :ref="`name-${scope.row.id}`"
            v-model="scope.row.name" 
            v-show="scope.row.id === tabClickId && tabClickLabel === '姓名'" placeholder="姓名" 
            @blur="inputBlur(scope.row)">
          </el-input>
          <div class="cell-text" v-show="scope.row.id !== tabClickId || tabClickLabel !== '姓名'">{{ scope.row.name }}</div>
        </template>
      </el-table-column>
      <el-table-column align="center" label="地址" show-overflow-tooltip type="address">
        <template slot-scope="scope">
          <el-input
            :ref="`address-${scope.row.id}`"
            v-model="scope.row.address" 
            v-show="scope.row.id === tabClickId && tabClickLabel === '地址'" placeholder="地址" 
            @blur="inputBlur(scope.row)">
          </el-input>
          <div class="cell-text" v-show="scope.row.id !== tabClickId || tabClickLabel !== '地址'">{{ scope.row.address }}</div>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>
<script type="text/javascript">
export default {
    mounted() {
    },
    data() {
        return {
          tableData: [{
            id: 1,
            date: '2016-05-02',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1518 弄'
          }, {
            id: 2,
            date: '2016-05-04',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1517 弄'
          }, {
            id: 3,
            date: '2016-05-01',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1519 弄'
          }, {
            id: 4,
            date: '2016-05-03',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1516 弄'
          }],
          tabClickId: '',
          tabClickLabel: ''
        }
    },
    methods: {
      editCell(item, column, cell, event){
        //根据点击的单元格判断是否可变成输入框
        switch (column.label) {
          case '日期': //当为日期时不变成输入框
            return
          default: 
            this.tabClickId = item.id
            this.tabClickLabel = column.label
            break
        }
        //输入框默认获取焦点
        this.$nextTick(() => {
          this.$refs[column.type + '-' + item.id].focus();
        })
      },
      // 失去焦点初始化
      inputBlur(item) {
        this.tabClickId = "";
        this.tabClickLabel = "";
        //这里还可以进行其他数据提交等操作
      }
    }
}
</script>
```

## vue element-ui table点击编辑后，变成input、select、date

vue
33 篇文章1 订阅
订阅专栏
最近，在项目上需要table可以行内编辑，在table添加了input、select、时间控件，并且可以保存本行数据，当你点击编辑时，table的列就会变成相对应的input、select和时间控件，点击保存时，需要调用后台接口把本行的数据传个后台。

![RUNOOB 图标](https://raw.githubusercontent.com/royegit/notes/master/%E5%89%8D%E7%AB%AF/vue%E7%AC%94%E8%AE%B0/image/d1e3ccb58ef740da8f8e63e5dc56238c.png "RUNOOB")

```vue
<template>
    <div class="Table" style="width:80%; margin:0 auto;">
      <el-table :data="prototypes" style="width: 100%;">
        <!-- 序号栏目 type="index" -->
        <el-table-column 
          fixed
          type="index" 
          label="序号" 
          width="100"
        >
        </el-table-column>
        <el-table-column
          fixed
          prop="name"
          label="姓名"
          width="120"
        >
        </el-table-column>
        <!-- 此页重点部分  编辑之前以span形式显示，点击编辑之后，以input栏目显示 -->
        <el-table-column label="地址" width="380">
          <template slot-scope="scope">
            <span v-if="scope.row.vVisible">{{scope.row.city}}</span>
            <el-input v-else v-model="scope.row.city"></el-input>
          </template>
        </el-table-column>
        <el-table-column label="性别" width="380">
          <template slot-scope="scope">
            <span v-if="scope.row.vVisible">
              <span v-if="scope.row.sex == '0'">
                男
              </span>
              <span v-else>
                女
              </span>
            </span>
            <el-select v-else v-model="scope.row.sex" clearable  >
              <el-option
                v-for="item in sexes"
                :key="item.value"
                :label="item.text"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </template>
        </el-table-column>
        <el-table-column label="日期" width="380">
          <template slot-scope="scope">
            <span v-if="scope.row.vVisible">{{scope.row.dateValue}}</span>
            <el-date-picker
              v-else
              v-model="scope.row.dateValue"
              format="yyyy-MM-dd"
              value-format="yyyy-MM-dd"
              type="date"
              placeholder="选择日期"
            >
            </el-date-picker>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160">
          <template slot-scope="scope">
            <div class="special">
              <span v-if="scope.row.vVisible" class="items" @click="edit(scope.row)">编辑</span>
              <span v-else class="items" @click="edit(scope.row)">保存</span>
              <span>|</span>
              <span class="items" @click="deleteit(scope.row)">删除</span>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>
</template>
  
  <script>
  export default {
    data() {
        return{
            // 表格绑定的数据
            prototypes:[{
                name: '王小虎',
                city: '北京朝阳',
                sex:"0",
                dateValue:"2022-10-24",
                isNull: false,
                vVisible: true
            },{
                name: '李晓琪',
                city: '北京东城',
                sex:"1",
                dateValue:"2022-10-25",
                isNull: true,
                vVisible: true
            }, {
                name: '张小民',
                city: '北京西城',
                sex:"0",
                dateValue:"2022-10-26",
                isNull: true,
                vVisible: true
            }],
            sexes:[
              {
                text:'男',
                value:'0'
              },{
                text:'女',
                value:'1'
              }
            ],
        }
    },
    methods: {
        // 点击编辑按钮
        edit(row) {
            row.vVisible = !row.vVisible
            console.log(row)
        },
        // 点击删除按钮
        deleteit(row) {

        }
    }
  }
</script>
<style scoped>
.special{
  cursor: pointer;
}
.special .items:hover{
  color: #6fbaff;
}
</style>
```
