
# MySQL 优化思路
#### 1、硬件优化

**mysql 统计查询数**    
mysqladmin -uroot -proot ext|awk '/Queries/{printf("%d ",$4)}/Threads_connected/{printf("%d ",$4)}/Threads_running/{printf("%d \n",$4)}'  
两句是同样的效果  
mysqladmin -uroot -proot ext|awk '/Queries/{q=$4}/Threads_connected/{c=$4}/Threads_running/{r=$4}END{printf("%d %d %d\n",q,c,r)}'

### MySQL使用show profile进行sql分析
https://blog.csdn.net/qq_41622603/article/details/108059819

### 什么是覆盖索引？
覆盖索引（covering index ，或称为索引覆盖）即从非主键索引中就能查到的记录，而不需要查询主键索引中的记录，避免了回表的产生减少了树的搜索次数，显著提升性能。

#### 如何使用是覆盖索引？
之前我们已经建立了表student，那么现在出现的业务需求中要求根据名称获取学生的年龄，并且该搜索场景非常频繁，那么先在我们删除掉之前以字段name建立的普通索引，以name和age两个字段建立联合索引，sql命令与建立后的索引树结构如下

```mysql
ALTER TABLE student DROP INDEX I_name;
ALTER TABLE student ADD INDEX I_name_age(name, age);
```



#### 高性能索引策略
对于Innodb节点下存储“行数据” 分裂的时候，还要移动行数据，  
0:对于innodb而言,因为节点下有数据文件,因此节点的分裂将会比较慢.
对于innodb的主键,尽量用整型,而且是递增的整型.
如果是无规律的数据,将会产生的页的分裂,影响速度.


#### 索引优化规则
1:索引类型  
1.1 B-tree索引  
注: 名叫btree索引,大的方面看,都用的平衡树,但具体的实现上, 各引擎稍有不同,  
比如,严格的说,NDB引擎,使用的是T-tree  
Myisam,innodb中,默认用B-tree索引  

但抽象一下---B-tree系统,可理解为”排好序的快速查找结构”.  

2: btree索引的常见误区  
2.1 在where条件常用的列上都加上索引  
例: where cat_id=3 and price>100 ; //查询第3个栏目,100元以上的商品  
误: cat_id上,和, price上都加上索引.  
错: 只能用上cat_id或Price索引,因为是独立的索引,同时只能用上1个.  

2.2 在多列上建立索引后,查询哪个列,索引都将发挥作用  
误: 多列索引上,索引发挥作用,需要满足左前缀要求.  
以 index(a,b,c) 为例,  

| 语句	                                     | 索引是否发挥作用         |  
|--------------------------------------------|------------------|  
| Where a=3                                  | 是,只使用了a列         |  
| Where a=3 and b=5                          | 是,使用了a,b列        |
| Where a=3 and b=5 and c=4	                 | 是,使用了abc         |
| Where a='3' and b='5' and c='4'            | 否,因为类型不一样，索引失效   |
| Where b=3  /  where c=4	                 | 否                |
| Where a=3 and c=4	                         | a列能发挥索引,c不能      |
| Where a=3 and b>10 and c=7	             | A能利用,b能利用, C不能利用 |
| 同上,where a=3 and b like ‘xxxx%’ and c=7	 | A能用,B能用,C不能用     |


为什么 Where a='3' and b='5' and c='4'  语句加单引号就不走索引了呢？这是因为加单引号时，是字符串跟数字的比较，它们类型不匹配，MySQL会做隐式的类型转换，把它们转换为浮点数再做比较。隐式的类型转换，索引会失效。

**之前看视频呢的时候，里面提到一道索引题目：假设某个表有一个联合索引(c1,c2,c3,c4)-只能使用该联合索引的c1,c2,c3部分** 

A where c1=x and c2=x and c4>x and c3=x  // c1能用到索引，c2能用到索引，c4能用到索引，c3能用到索引
B where c1=x and c2=x and c4=x order by c3  // c1能用到索引，c2能用到索引，c4能用到索引，c3能用到索引
C where c1=x and c4= x group by c3,c2   // c1能用到索引，c4用不到索引，c3用不到索引，c2用不到索引
D where c1=? and c5=? order by c2,c3    // c1用上索引，c2用上索引，c3用上索引，c5没用上索引
E where c1=? and c2=? and c5=? order by c2,c3  // c1用上索引,c2用上索引,c3用上索引,c5没用上索引



#### explain 检查语句的索引使用情况和获取到的数据一共扫描了几行

```mysql
mysql> explain select * from SysJkApply where Id<1000 \G;
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: SysJkApply  // 表名
   partitions: NULL
         type: range
possible_keys: PRIMARY,Id //使用到的索引
          key: PRIMARY
      key_len: 4     //显示了MySQL在索引里使用的字节数，可通过该列计算查询中使用的索引的长度。
          ref: NULL
         rows: 762    // 表示MySQL预估的为了找到所需的行而要读取的行数
     filtered: 100.00
        Extra: Using where
1 row in set, 1 warning (0.00 sec)
```

###### select_type列

显示了对应行是简单还是复杂select：

* SIMPLE：表示查询不包含子查询和union，如果查询中有任何复杂的子部分，则最外层部分标记为PRIMARY；
* SUBQUERY：表示包含在select列表中的子查询中的select（换句话说不在from子句中）；
* DERIVED：表示包含在from子句的子查询中的from，MySQL会递归执行并将结果放到一个临时表中。服务器内部称其为派生表，因为该临时表是从子查询中派生来的；
* UNION：表示在union中的第二个和随后的select被标记为union；
* UNION RESULT：表示用来从UNION的匿名临时表检索结果的select。
* 除了这些值，SUBQUERY和UNION还可以被标记为DEPENDENT和UNCACHEABLE。DEPENDENT意味着select依赖于外层查询中发现的数据。UNCACHEABLE意味只select中的某些特性阻止结果被缓存于Item_cache中。

###### table列

显示对应行正在访问哪个表，通常是表名或者该表的别名
###### type列

访问类型，下面依次从最差到最优：

* ALL：表示全表扫描，MySQL必须扫描整个表，从头到尾，来找到所需要的行（有个例外如使用了limit或者extra列中显示了Using distinct/not exists）；  
* index ：跟全表扫描一样，只是扫描时按索引次序进行而不是行。主要优点是避免了排序，最大缺点是要承担按索引次序读取整个表的开销。如果在extra列中看到Using index，说明MySQL正在使用覆盖索引，只扫描索引的数据，而不是按索引次序的每一行，它比按索引次序全表扫描的开销要少很多；  
* range：范围扫描，是一个有限制的索引扫描，开始于索引的某一点，返回匹配这个值域的行。比全索引扫描好一些，因为用不着遍历全部索引。显而易见的范围扫描是带有between或在where子句里带有>的查询；  
* ref：是一种索引访问，返回所有匹配某个单个值的行。然而，它可能会找到多个符合条件的行，此类索引访问只有当使用非唯一性索引或者唯一性索引的非唯一性前缀时才会发生。ref_or_null是ref的一个变体，它意味着MySQL必须在初次查找的结果里进行第二次查找以找出NULL条目；  
* eq_ref：这种索引查找，MySQL知道最多只返回一条符合条件的记录。这种访问方法可以在MySQL使用主键或者唯一性索引查找时看到；  
* const，system当MySQL能对查询的某部分进行优化并将其转换成一个常量时，它就会使用这些访问类型；  
* NULL：这种访问方式意味着MySQL能在优化阶段分解查询语句，在执行阶段甚至不用在访问表或者索引。  
###### possible_keys列

这一列显示了查询可以使用哪些索引，这是基于查询访问的列和使用的比较操作符来判断的。这个列是在优化过程的早期创建的，因此有些罗列出来的的索引可能对于后续优化过程是没用的。

###### key列

显示MySQL决定采用哪个索引来优化对该表的访问。如果该索引没有出现在possible_keys列中，那么MySQL选用它是出于另外的原因如可能选择了一个覆盖索引，哪怕没有where子句。换言之，possible_keys揭示了哪一个索引有助于高效行查找，而key显示的是优化采用的哪一个索引可以最小化查询成本。如下：

###### key_len列 

显示了MySQL在索引里使用的字节数，可通过该列计算查询中使用的索引的长度。  

###### ref列

显示了之前的表在key列记录的索引中查找值所用的列或常量

###### rows列

表示MySQL预估的为了找到所需的行而要读取的行数。根据表的统计信息和索引的选用情况，这个估算可能很不精确。通过把所有rows列值相乘，可以粗略的估算出整个查询会检查的行数。如下面这个查询大约会检查4行：

###### filtered列

这一列是MySQL5.1里新加的，它显示的是针对表里符合某个条件（where子句或联结条件）的记录数所做的一个悲观估算的百分比。

###### Extra列

这一列包含的是不适合在其他列显示的额外信息。常见的最重要的值有： 

Using index表示MySQL将使用覆盖索引，以避免回表查询。不要把覆盖索引和index访问类型混淆了；  
Using where表示MySQL服务器将在存储引擎检索行后再进行过滤；  
Using temporary表示MySQL在对查询结果排序时会使用一个临时表；  
Using filesort表示MySQL会对结果使用一个外部索引排序，而不是按索引次序从表里读取行。MySQL有两种文件排序算法，两种都可以在内存或磁盘上完成。但explain不会告诉你MySQL使用的是哪种，也不会告诉你排序是在内存还是磁盘上完成；  
Range checked for each record（index map：N）表示没有好用的索引，新的索引将在联接的每一行上重新估算。N是显示在possible_keys列中索引的位图，并且是冗余的；  
Using union表示MySQL运用了索引合并策略，索引合并策略有时是一种优化的结果，但实际上更多时候说明了表上的索引建的很糟糕。  


#### 删除索引：

```mysql
mysql> alter table SysJkApply drop index userId;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0
```
#### 添加一个复合索引：

```mysql
mysql> alter table SysJkApply add index Id_UserId(Id,UserId);
Query OK, 0 rows affected (2.41 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

#### 分库分表中间件 :ShardingSphere

Apache ShardingSphere(Incubator) 是一套开源的分布式数据库中间件解决方案组成的生态圈，它由Sharding-JDBC、Sharding-Proxy和Sharding-Sidecar(规划中)这3款相互独立，却又能够混合部署配合使用的产品组成。它们均提供标准化的数据分片、分布式事务和数据库治理功能，可适用于如JAVA同构、异构语言、云原生等各种多样化的应用场景。

ShardingSphere 定位为关系型数据库中间件，旨在充分合理地在分布式的场景下利用关系型数据库的计算和存储能力，而并非实现一个金新的关系型数据库。它通过关注在原有基础上的增量，而非颠覆。


#### 例：

在id 、ver上有联合索引 10000条数据

为什么select id from A order by id 特别慢？
而select id from a order by id,ver 非常快，我的表有几个很长的字段varbinary(3000)

1、是innodb索引
2、有多个比较长的列
1是聚簇索引，导致沿Id排序时，要跨好多小文件块
2有比较长的列，导致生成的块比较多
```mysql
create table t7(
    id char(64) primary key,
    ver int not null default 0 ,
    star1 varchar(3000),
    star2 varchar(3000),
    star3 varchar(3000)
)engine = myisam default charset=utf8;



create table t8(
                   id char(64) primary key,
                   ver int not null default 0,
                   star1 varchar(3000),
                   star2 varchar(3000),
                   star3 varchar(3000)
)engine = innodb default charset =utf8;
```

#### 理想的索引
1、查询频繁 2、区分度高 3、长度小 4、尽量能覆盖常用查询字段。

1：索引长度直接影响索引文件的大小，影响增删改的速度，并间接影响查询速度（占用内存多）

针对列中的值，从左往右截取部分，来建索引
1：截的越短，重复度越高，区分度越小，索引效果不好
2：截的越长，重复度越低，区分度越高，索引效果越好，但带来的影响也越大--增删改变慢，并且影响查询速度。

所以，我们要在 区分度 + 长度 两者上取一个平衡  
惯用的手法：截取不同长度，并测试其区分度，


