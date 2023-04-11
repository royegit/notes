# php 优惠券 原型图

### 表单提交


![沙漠中的岩石图片](https://raw.githubusercontent.com/royegit/notes/master/PHP/php_promotion/coupon/images/Quicker_20230330_134013.png "Shiprock")

可用商品：
* 全店通用 - 所有商品产品可用
* 指定商品 - 弹出所有产品窗口选择可使用优惠券的商品
* 指定分类 - 现实联动下来框选择可以使用优惠券的商品分类

* 价格百分比计算公式 ： 原价 x（1-10%）= 优惠10%


### 优惠券列表
![优惠券](https://raw.githubusercontent.com/royegit/notes/master/PHP/php_promotion/coupon/images/Quicker_20230330_141243.png)

##### 优惠券列表
```mysql
CREATE TABLE `tp_coupon`  (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '优惠券名字',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发放类型 0下单赠送1 指定发放 2 免费领取 3线下发放',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠券金额',
  `condition` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '使用条件',
  `createnum` int(11) NULL DEFAULT 0 COMMENT '发放数量',
  `send_num` int(11) NULL DEFAULT 0 COMMENT '已领取数量',
  `use_num` int(11) NULL DEFAULT 0 COMMENT '已使用数量',
  `send_start_time` int(11) NULL DEFAULT NULL COMMENT '发放开始时间',
  `send_end_time` int(11) NULL DEFAULT NULL COMMENT '发放结束时间',
  `use_start_time` int(11) NULL DEFAULT NULL COMMENT '使用开始时间',
  `use_end_time` int(11) NULL DEFAULT NULL COMMENT '使用结束时间',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态：1有效,2无效',
  `use_type` tinyint(1) NULL DEFAULT 0 COMMENT '使用范围：0全店通用1指定商品可用2指定分类商品可用',
  `thumbnail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '免费发放需要显示缩略图',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `use_end_time`(`use_end_time`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;
```

##### 优惠券记录表

```mysql
CREATE TABLE `tp_coupon_list`  (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `cid` int(8) NOT NULL DEFAULT 0 COMMENT '优惠券 对应coupon表id',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发放类型 1 按订单发放 2 注册 3 邀请 4 按用户发放',
  `uid` int(8) NOT NULL DEFAULT 0 COMMENT '用户id',
  `order_id` int(8) NOT NULL DEFAULT 0 COMMENT '订单id',
  `get_order_id` int(11) NULL DEFAULT 0 COMMENT '优惠券来自订单ID',
  `use_time` int(11) NOT NULL DEFAULT 0 COMMENT '使用时间',
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '优惠券兑换码',
  `send_time` int(11) NOT NULL DEFAULT 0 COMMENT '发放时间',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '0未使用1已使用2已过期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `code`(`code`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 324 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;
```

```injectablephp
/**
 * 获取随机字符串
 * @param int $randLength  长度
 * @param int $addtime  是否加入当前时间戳
 * @param int $includenumber   是否包含数字
 * @return string
 */
function get_rand_str($randLength=6,$addtime=1,$includenumber=0){
    if ($includenumber){
        $chars='abcdefghijklmnopqrstuvwxyzABCDEFGHJKLMNPQEST123456789';
    }else {
        $chars='abcdefghijklmnopqrstuvwxyz';
    }
    $len=strlen($chars);
    $randStr='';
    for ($i=0;$i<$randLength;$i++){
        $randStr.=$chars[rand(0,$len-1)];
    }
    $tokenvalue=$randStr;
    if ($addtime){
        $tokenvalue=$randStr.time();
    }
    return $tokenvalue;
}

```

```injectablephp
    /**
     * 领券
     * @param $id 优惠券id
     * @param $user_id
     */
    public function get_coupon($id, $user_id)
    {
        if (empty($id)){
            $return = ['status' => 0, 'msg' => '参数错误'];
        }
        if ($user_id) {
            $_SERVER['HTTP_REFERER'] = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : url('Home/Activity/coupon_list');
            $coupon_info = Db::name('coupon')->where(array('id' => $id, 'status' => 1))->find();
            if (empty($coupon_info)) {
                $return = ['status' => 0, 'msg' => '活动已结束或不存在，看下其他活动吧~','return_url'=>$_SERVER['HTTP_REFERER']];
            } elseif ($coupon_info['send_end_time'] < time()) {
                //来晚了，过了领取时间
                $return = ['status' => 0, 'msg' => '抱歉，已经过了领取时间','return_url'=>$_SERVER['HTTP_REFERER']];
            } elseif ($coupon_info['send_num'] >= $coupon_info['createnum'] && $coupon_info['createnum'] != 0) {
                //来晚了，优惠券被抢完了
                $return = ['status' => 0, 'msg' => '来晚了，优惠券被抢完了','return_url'=>$_SERVER['HTTP_REFERER']];
            } else {
                if (Db::name('coupon_list')->where(array('cid' => $id, 'uid' => $user_id))->find()) {
                    //已经领取过
                    $return = ['status' => 2, 'msg' => '您已领取过该优惠券','return_url'=>$_SERVER['HTTP_REFERER']];
                } else {
                    $data = array('uid' => $user_id, 'cid' => $id, 'type' => 2, 'send_time' => time(),'status'=>0);
                    Db::name('coupon_list')->insert($data);
                    Db::name('coupon')->where(array('id' => $id, 'status' => 1))->inc('send_num')->update();
                    $return = ['status' => 1, 'msg' => '恭喜您，抢到' . $coupon_info['money'] . '元优惠券!','return_url'=>$_SERVER['HTTP_REFERER']];
                }
            }
        } else {
            $return = ['status' => 0, 'msg' => '请先登录','return_url'=>url('User/login')];
        }
        
        return $return;
    }
```

```injectablephp
/**
 * 根据用户发放优惠券 
 */
    public function send_coupon(){
    	$cid = input('cid/d');
    	if(IS_POST){
    		$level_id = input('level_id');
    		$user_id = input('user_id/a');

    		$insert = [];
    		$coupon = Db::name('coupon')->where("id",$cid)->find();
    		if($coupon['createnum']>0){
    			$remain = $coupon['createnum'] - $coupon['send_num'];//剩余派发量
    			if($remain<=0) $this->error($coupon['name'].'已经发放完了');
    		}
    		if(empty($user_id) && $level_id>=0){
    			if($level_id==0){
    				$user = Db::name('users')->where("is_lock",0)->select();
    			}else{
    				$user = Db::name('users')->where("is_lock",0)->where('level', $level_id)->select();
    			}
    			if($user){
    				$able = count($user);//本次发送量
    				if($coupon['createnum']>0 && $remain<$able){
    					$this->error($coupon['name'].'派发量只剩'.$remain.'张');
    				}
    				foreach ($user as $k=>$val){
    					$time = time();
                        $insert[] = ['cid' => $cid, 'type' => 1, 'uid' => $val['user_id'], 'send_time' => $time];
                        $user_id[] = $val['user_id']; //用于通知消息
    				}
    			}
    		}else{
    			$able = count($user_id);//本次发送量
    			if($coupon['createnum']>0 && $remain<$able){
    				$this->error($coupon['name'].'派发量只剩'.$remain.'张');
    			}
    			foreach ($user_id as $k=>$v){
    				$time = time();
                    $insert[] = ['cid' => $cid, 'type' => 1, 'uid' => $v, 'send_time' => $time];
    			}
    		}
			DB::name('coupon_list')->insertAll($insert);
            // 通知消息
            $messageFactory = new MessageFactory();
            $messageLogic = $messageFactory->makeModule(['category' => 0]);
            $messageLogic->getCouponNotice($cid, $user_id);

            // 如果有微信公众号 则推送一条消息到微信.微信浏览器才发消息，否则下单超时。by清华
//            if(is_weixin()){
//                $user_id = ['3661','3645'];
                $user = Db::name('OauthUsers')->where(['user_id'=>['in',$user_id] , 'oauth'=>'weixin' , 'oauth_child'=>'mp'])->select();
                if ($user) {
                    $wx_content = "您刚刚收到了优惠券，请注意查收";
                    $wechat = new WechatUtil();
                    foreach ($user as $v)
                    {
                        $wechat->sendMsg($v['openid'], 'text', $wx_content);
                    }
                }
//            }
			Db::name('coupon')->where("id",$cid)->inc('send_num',$able)->update();
			adminLog("发放".$able.'张'.$coupon['name']);
			$this->success("发放成功");
			exit;
    	}
    	$level = Db::name('user_level')->select();
    	View::assign('level',$level);
    	View::assign('cid',$cid);
    	return View::fetch();
    }
```
