
# MySQL SHOW PROCESSLIST协助故障诊断
### 一、SHOW PROCESSLIST命令

show processlist 是显示用户正在运行的线程，需要注意的是，除了 root 用户能看到所有正在运行的线程外，其他用户都只能看到自己正在运行的线程，看不到其它用户正在运行的线程。除非单独个这个用户赋予了PROCESS 权限。

![show processlist](https://raw.githubusercontent.com/royegit/notes/master/mysql/img/show_processlist.png)

<center>root用户，可以看到全部线程运行情况 </center>

![show processlist](https://raw.githubusercontent.com/royegit/notes/master/mysql/img/show_processlist.png)

<center> <strong>普通用户只能看到自己的线程运行情况，除非被单独授权即可看到其他的用户线程运行情况</strong> </center>
show processlist 显示的信息都是来自MySQL系统库 information_schema 中的 processlist 表。所以使用下面的查询语句可以获得相同的结果：

>select * from information_schema.processlist

了解这些基本信息后，下面我们看看查询出来的结果都是什么意思。

<font color="#6495ed">Id </font>    

就是这个线程的唯一标识，当我们发现这个线程有问题的时候，可以通过 kill 命令，加上这个Id值将这个线程杀掉。前面我们说了show processlist 显示的信息时来自information_schema.processlist 表，所以这个Id就是这个表的主键。

<font color="#6495ed">User </font>  

就是指启动这个线程的用户。如果是system user，它是指由服务器产生的非客户线程，以在内部处理任务。这可能是复制从站或延迟行处理程序使用的I / O或SQL线程。unauthenticated user指的是已经与客户端连接关联但是还没有完成客户机用户的认证的线程。 event_scheduler指的是监视预定事件的线程。如果是system user那么在Host列中不会指定主机 

<font color="#6495ed">Host </font>   


记录了发送请求的客户端的 IP 和 端口号。通过这些信息在排查问题的时候，我们可以定位到是哪个客户端的哪个进程发送的请求。 显示方式：host_name:client_port。

<font color="#6495ed">DB </font>   

当前执行的命令是在哪一个数据库上。如果没有指定数据库，则该值为 NULL 。

<font color="#6495ed">Command</font>

显示这个线程此刻正在执行的命令，一般对应DDL或DML语句。

<font color="#6495ed">Time </font>

表示线程处于当前状态的时间长短，线程当前时间的概念在某些情况下可能会发生改变：线程可以改变时间。对于正在从主机处理事件的从站上运行的线程，线程时间设置为事件中发现的时间，因此反映了主站而不是从站的当前时间。SET TIMESTAMP = value。


<font color="#6495ed">State </font>

 线程的状态，和 Command 对应，下面单独解释。

<font color="#6495ed">Info </font>

一般记录的是线程执行的语句。默认只显示前100个字符，也就是你看到的语句可能是截断了的，要看全部信息，需要使用 show full processlist。

> show full processlist
```mysql
mysql> show full processlist\G
*************************** 1. row ***************************
     Id: 123
   User: root
   Host: localhost
     db: performance_schema
Command: Query
   Time: 0
  State: starting
   Info: show full processlist
1 row in set (0.00 sec)
```

### 线程命令（Command）值

线程可以具有以下任何Command值

<font color="#6495ed">Binlog Dump：</font>这是主服务器上的线程，用于将二进制日志内容发送到从服务器。

<font color="#6495ed">Table Dump：</font>线程将表内容发送到从服务器。

<font color="#6495ed">Change user：</font>线程正在执行改变用户操作。

<font color="#6495ed">Close stmt：</font>线程正在关闭准备好的语句。

<font color="#6495ed">Connect：</font>从服务器连接到其主服务器。

<font color="#6495ed">Connect Out：</font>从服务器正在连接到其主服务器。

<font color="#6495ed">Create DB：</font>线程正在执行create-database操作。

<font color="#6495ed">Daemon：</font>此线程在服务器内部，而不是服务客户端连接的线程。或者通俗一点说（Daemon:是服务器内部线程，而不是来自客户端的链接）

<font color="#6495ed">Debug：</font>线程正在生成调试信息。

<font color="#6495ed">Delayed insert：</font>线程是一个延迟插入处理程序。

<font color="#6495ed">Drop DB：</font>线程正在执行drop-database操作。

<font color="#6495ed">Execute：</font>线程正在执行一个准备好的语句（prepare statement类型就是预编译的语句，JDBC支持次类型执行SQL）。

<font color="#6495ed">Fetch：</font>线程正在执行一个准备语句的结果。

<font color="#6495ed">Field List：</font>线程正在检索表列的信息。

<font color="#6495ed">Init DB：</font>线程正在选择默认数据库。

<font color="#6495ed">Kill：</font>线程正在杀死另一个线程。

<font color="#6495ed">Long Data：</font>该线程在执行一个准备语句的结果中检索长数据。

<font color="#6495ed">Ping：</font>线程正在处理服务器ping请求。

<font color="#6495ed">Prepare：</font>线程正在为语句生成执行计划。

<font color="#6495ed">Processlist：</font>线程正在生成有关服务器线程的信息。

<font color="#6495ed">Query：</font>该线程正在执行一个语句。

<font color="#6495ed">Quit：</font>线程正在终止。

<font color="#6495ed">Refresh：</font>线程是刷新表，日志或缓存，或重置状态变量或复制服务器信息。

<font color="#6495ed">Register Slave：</font>线程正在注册从服务器。

<font color="#6495ed">Reset stmt：</font>线程正在重置一个准备好的语句。

<font color="#6495ed">Set option：</font>线程正在设置或重置客户端语句执行选项。

<font color="#6495ed">Shutdown：</font>线程正在关闭服务器。

<font color="#6495ed">Sleep：</font>线程正在等待客户端向其发送新的语句。

<font color="#6495ed">Statistics：</font>线程正在生成服务器状态信息。

<font color="#6495ed">Time：</font>没用过。（Unused）
### 线程命令（Command）值

* **般线程状态（State）值**















