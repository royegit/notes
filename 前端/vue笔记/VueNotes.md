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
