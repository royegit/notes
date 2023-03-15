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
