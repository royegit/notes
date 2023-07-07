# php laravel 框架

#### Laravel模型嵌套预加载条件查询嵌套模型数据不为空的所有数据

如果你需要在Laravel中进行模型嵌套预加载条件查询，以获取嵌套模型数据为空的所有数据，可以使用whereHas方法配合doesntHave方法实现。

假设你有三个模型类Order，Product，Category，关联关系定义如下：

Order模型通过products方法和Product模型关联。
Product模型通过category方法和Category模型关联。
现在你想要获取所有无法关联到Category模型的Order模型实例，即Product模型嵌套关系为空的Order模型实例。你可以按以下方式查询

```injectablephp
$orders = Order::whereHas('products', function ($query) {
    $query->whereHas('category');
})->get();

```
这将返回所有可以关联到Category模型的Order模型实例。

如果你需要嵌套预加载Product和Category模型数据，也可以使用with方法，例如：

```injectablephp
$orders = Order::whereHas('products', function ($query) {
    $query->whereHas('category');
})->with('products.category')->get();

```
这将返回所有可以关联到Category模型的Order模型实例，并预加载Product和Category模型数据。

希望这可以帮助你完成模型嵌套预加载条件查询以获取嵌套模型数据不为空的数据。

#### Laravel模型嵌套预加载条件查询嵌套模型数据为空的所有数据

如果你需要在Laravel中进行模型嵌套预加载条件查询，以获取嵌套模型数据为空的所有数据，可以使用whereHas方法配合doesntHave方法实现。

假设你有三个模型类Order，Product，Category，关联关系定义如下：

Order模型通过products方法和Product模型关联。
Product模型通过category方法和Category模型关联。
现在你想要获取所有无法关联到Category模型的Order模型实例，即Product模型嵌套关系为空的Order模型实例。你可以按以下方式查询：

```injectablephp
$orders = Order::whereHas('products', function ($query) {
    $query->doesntHave('category');
})->get();

```
这将返回所有无法关联到Category模型的Order模型实例。

希望这可以帮助你完成模型嵌套预加载条件查询以获取嵌套模型数据为空的数据。

#### 宿主机连接Docker服务器地址
```injectablephp
DB_HOST=host.docker.internal #本地 - 映射本地IP
DB_USERNAME=sa
DB_PASSWORD=123456
```