<?php
namespace app\index\controller;
use think\Controller;
/*Thinkphp5.0环境下*/
class Index extends Controller
{
  private $redis=[
    'DATA_CACHE_PREFIX' => 'Redis_',//缓存前缀
    'DATA_CACHE_TYPE'=>'Redis',//默认动态缓存为Redis
    'DATA_CACHE_TIMEOUT' => false,
    'REDIS_RW_SEPARATE' => true, //Redis读写分离 true 开启
    'REDIS_HOST'=>'127.0.0.1', //redis服务器ip，多台用逗号隔开；读写分离开启时，第一台负责写，其它[随机]负责读；
    'REDIS_PORT'=>'6379',//端口号
    'REDIS_TIMEOUT'=>86400,//超时时间
    'REDIS_PERSISTENT'=>false,//是否长连接 false=短连接
    'REDIS_AUTH'=>'',//AUTH认证密码
    
  ];
  private $user_id=1;

  //现在初始化里面定义后边要使用的redis参数
  public function _initialize(){
      $goods_id = input("goods_id",'0','intval');
      $_SESSION['uid']=1;
      if($goods_id){
        $this->goods_id = $goods_id;
        $this->user_queue_key = "goods_".$goods_id."_user";//当前商品队列的用户情况
        $this->goods_number_key = "goods".$goods_id;//当前商品的库存队列
      }
      $this->user_id = $this->user_id ? $this->user_id : $_SESSION['uid'];   
    }

    public function index()
    {
        return 222;
    }

    /**
    * redis连接
    * @access private
    * @return resource
    * @author bieanju
    */
  private function connectRedis(){
    $redis=new \Redis();
    $redis->pconnect($this->redis["REDIS_HOST"],$this->redis["REDIS_PORT"],$this->redis["REDIS_TIMEOUT"]);    
    return $redis;
  }

  /**
   * 商品详情
  * 访问产品前先将当前产品库存队列
  * @access public
  * @author bieanju
  */
  public function _before_detail(){
    $where['goods_id'] = $this->goods_id;
    $where['start_time'] = array("lt",time());
    //$where['end_time'] = array("gt",time()+345600);
    $where['end_time'] = array("gt",time());
    //商品详情表
    $goods = db("redis_goods_miaosha")->where($where)->field('goods_num')->find();
    $order['order_num']=90;
    !$goods && $this->error("当前秒杀已结束！");
    if($goods['goods_num'] > $order['order_num']){
      $redis = $this->connectRedis();
      $getUserRedis = $redis->hGetAll("{$this->user_queue_key}");  //查询当前用户有没有商品在队列中
      $gnRedis = $redis->llen("{$this->goods_number_key}");        //查询当前商品的库存队列
      /* 如果没有会员进来队列库存 */
      if(!count($getUserRedis) && !$gnRedis){
        for ($i = 0; $i < $goods['goods_num']; $i ++) {
          $redis->lpush("{$this->goods_number_key}", 1);           //把所有库存商品都放到队列中
        }
      }
      $resetRedis = $redis->llen("{$this->goods_number_key}");     //查询当前商品的库存队列
      if(!$resetRedis){
        $this->error("系统繁忙，请稍后抢购！");
      }
    }else{
      $this->error("当前产品已经秒杀完！");
    }
      
  }


  /**
   * 商品加入购物车
   * 抢购商品前处理当前会员是否进入队列
   * @access public
   * @author bieanju
   */
  public function goods_number_queue(){
    !$this->user_id && $this->ajaxReturn(array("status" => "-1","msg" => "请先登录"));
    $model = db("flash_sale");     //秒杀商品表(秒杀相关的参数)
    $where['goods_id'] = $this->goods_id;
    $goods_info = $model->where($where)->field('start_time,end_time')->find();
    !$goods_info && $this->error("对不起当前商品不存在或已下架！"); 
    /* redis 队列 */
    $redis = $this->connectRedis();
    /* 进入队列 */
    $goods_number_key = $redis->llen("{$this->goods_number_key}");
    if (!$redis->hGet("{$this->user_queue_key}", $this->user_id)) {
    //秒杀商品减抢购库存
      $goods_number_key = $redis->lpop("{$this->goods_number_key}");
    }

    if($goods_number_key){
      // 判断用户是否已在队列
      if (!$redis->hGet("{$this->user_queue_key}", $this->user_id)) {
      // 插入抢购用户信息
        $userinfo = array(
          "user_id" => $this->user_id,
          "create_time" => time()
        );        
        $redis->hSet("{$this->user_queue_key}", $this->user_id, serialize($userinfo));
        $this->ajaxReturn(array("status" => "1"));
      }else{
        //查询用户购物车
        $modelCart = db("cart");
        $condition['user_id'] = $this->user_id;
        $condition['goods_id'] = $this->goods_id;
        $condition['prom_type'] = 1;
        $cartlist = $modelCart->where($condition)->count();
        if($cartlist > 0){
          $this->ajaxReturn(array("status" => "2"));
        }else{
          $this->ajaxReturn(array("status" => "1"));
        }

      }

    }else{
      $this->ajaxReturn(array("status" => "-1","msg" => "系统繁忙,请重试！"));
    }
  }

  //测试
  public function clearRedis(){
    set_time_limit(0);
    $redis = $this->connectRedis();
    //$Rd = $redis->del("{$this->user_queue_key}");
    $Rd = $redis->hDel("goods49",'用户id');
    $a = $redis->hGet("goods_49_user", '用户id');
    if(!$a){
      dump($a);
    }
     
    if($Rd == 0){
      exit("Redis队列已释放！");      
    }
  }


}
