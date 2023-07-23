
# MySQL 优化思路
#### 1、硬件优化
腾讯.CPU 64位CPU 一台机器8-16颗CPU
百度：mem（内存） 96G - 128G。一台服务器会跑3-4个实例。在那种大公司：不是门户网站的一般是32G - 64G的内存，跑两个实例。然后CPU一般是2-4颗。
disk（硬盘）数量越多越好。性能ssd（做高并发业务）优于sas（做普通业务）优于sata（用做线下）。如果是高并发的业务，选择ssd
raid 4块盘：RAID0 优于 RAID10 优于 RAID5 优于 RAID1。
网卡。多块网卡bond（多个网卡合成一块提升性能） ，以及buffer,tcp优化

#### 软件优化
操作系统：x86_64,
软件：mysql 编译的优化

#### 2、my.cnf 里参数的优化
优化幅度很小。大部分是架构的优化，以及SQL语句的优化。

server-id = 371
innodb_additional_mem_pool size = 16M
innodb_buffer_pool_size = 2048M  # 主要是这个参数，一般可以配置到硬件的3分之一到2分之一（一些公司会设置到百分之八十，一般建议是不超过百分之五十 ）
innodb_data_file_path = ibdatal: 1024M: autoextend
innodb_file_io_threads = 41
innodb_thread_concurrencv = &1
innodb_flush_log_at_trx_commit= 21
innodb_log_buffer_size== 16M
innodb_log_file_size = 128M
innodb_log_files_in_group=3
innodb_max_dirty_pages_pct= 90
innodb_lock_wait_timeout = 120
innodb_file_per_table = 0
[mysqldump]
quick
max allowed packet = 32M
[mysqld safe]


socket= /data/3306/mysql. sock
basedir=/usr/local/mysql
datadir =/data/3306/data
open_files_limit= 10240
back_log = 600
max_connections = 3000
max_connect_errors = 6000
table_cache = 614
external-locking = FALSE
max_allowed_packet= 32M
sort_buffer_size = 2M  # 线程buffer不能给大了
join_buffer_size = 2M  # 线程buffer不能给大了
thread_cache_size = 300  # 线程缓存不能给大了
thread_concurrency = 8
query_cache_size = 64M
query_cache_limit = 4M
query_cache min_res unit = 2k
default_table_type = InnoDB
thread_stack = 192K
transaction isolation = READ-CONMITTED
tmp_table_size = 256M        #临时表会占用磁盘空间，可以给大一点，但也不用给特别大
max_heap_table_size = 256M       #临时表会占用磁盘空间，可以给大一点，但也不用给特别大
long_query_time = 2         # 慢查询，查询时间最长的设置
log_long_formaty
log-error = /data/3306/error.log
log-slow-queries=/data/3306/slow-log.log  # 查询时间超过2秒的记录到慢查询日志里
pid-file = /data/3306/mysql. pid
log-bin=/data/3306/mysql-bin
relay-log=/data/3306/relay-binv
relay-log-info-file = /data/3306/relay-log.infov
binlog_cache_size = 4M
max_binlog_cache_size = 8M
max_binlog_size = 512M
expire_logs_days = 7     # binlog 过期的天数(注意：平时不要手动去删除binlog,容易出问题)
key_buffer_size = 32M    # 索引的缓存，主要用于myIson引擎
read_buffer_size = 1Mb
read_rnd_buffer_size = 16M
bulk_insert_buffer_size = 64M
myisam_sort_buffer size = 128M
myisam_max_sort_file_size = 10G
myisam_max_extra sort file size = 10G
myisam_repair_threads = 1
skip-name-resolve # 这个参数很重要不加入的话会导致很多莫名其妙的错误


#### 3、SQL语句的优化

#### 4、架构的优化
#### 5、流程，制度，安全优化

### 一、在业务中有很多 like 语句时

1、从业务上实现用户登陆后在搜索，这样减少搜索次数，从而减轻数据库服务压力。
2、如果有大量频繁的搜索，一般是爬虫在趴你的网站，分析WEB日志IP封掉之(AWSTATS)
3、配置多个主从同步，程序上实现读写分离（最好让 LIKE '%杜冷丁%' 这样的查询去从库查询），减轻主库读写压力。
4、在数据库前端加上 memcached 缓存服务器。
5、LIKE '%杜冷丁%' 的语句，一般在mysql里很难优化，可以通过搜索服务Sphinx或者ElasticSearch
6、还可以用c,ruby开发程序，实现每日读库计算搜索索引，保存在服务器上提供搜索，然后，每5分钟多一个从库做一次增量。这是大公司针对站内搜索采用的比较好的方案。
短期来看，我更倾向于1，2的方案。简单，可实施，3，4是后期要发展的目标，

如果前端有人爬站，封掉IP就好了。



