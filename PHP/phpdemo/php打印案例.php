<?php
header("Content-type: text/html; charset=utf-8");
 
class Netprint{
    public $host = '192.168.2.200';  //打印机IP
    public $port = 9100;  //默认端口
    public $socket;
     
    function initcon($host, $port = '9100'){//连接打印机
 
        if(!empty($host) && !empty($port)){
            $this->host = $host;
            $this->port = $port;
            $socket = socket_create(AF_INET,SOCK_STREAM,SOL_TCP) or die("Could not create socket.\n");
            socket_set_nonblock($socket);
            $con = @socket_connect($socket,$this->host,$this->port) or die("Could not connect server.\n");;
            $flag = socket_select($r=array($socket), $w = array($socket), $f = array($socket), 2);
            if($flag == '1'){
                socket_set_block($socket);
            }else{
                $flag = socket_select($r=array($socket), $w = array($socket), $f = array($socket), 2);
                if($flag == '1'){
                    socket_set_block($socket);
                }else{
                    return false;
                }
            }
            $this->socket = $socket;
            return true;
        }else{
            return false;
        }
    }
	//初始化打印
    function initprint(){
        if($this->socket){
            $sendstr1 = pack("C*", '27', '64');
            socket_sendto($this->socket,$sendstr1,strlen($sendstr1),0,$this->host,$this->port);
 
            $sendstr2 = pack("C*", '27', '83');
            socket_sendto($this->socket,$sendstr2,strlen($sendstr2),0,$this->host,$this->port);
 
            $sendstr3 = pack("C*", '27', '33', '0');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function sendprint($content){//打印内容
 
        if($this->socket){
 
            //$content = mb_convert_encoding($content,"GB2312","UTF-8");
            $content = iconv("UTF-8","GB18030",$content);
            $sendstr4 = pack('A*', $content);
            socket_sendto($this->socket,$sendstr4,strlen($sendstr4),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function cutter(){//切纸
        if($this->socket){
 
            $content = mb_convert_encoding("\n\n\n\n\n\n\n","GB2312","UTF-8");
            $sendstr4 = pack('A*', $content);
            socket_sendto($this->socket,$sendstr4,strlen($sendstr4),0,$this->host,$this->port);
 
            $sendstr5 = pack("C*", '29', '86', '48');
            socket_sendto($this->socket,$sendstr5,strlen($sendstr5),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function closecon(){//关闭连接
        if($this->socket){
 
            socket_close($this->socket);
 
            return true;
        }else{
            return false;
        }
    }
    function normal(){
        if($this->socket){
 
            $sendstr3 = pack("C*", '29', '33', '0');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function middle(){//居中
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '97', '49');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function width_2x(){//宽*2
        if($this->socket){
             
            $sendstr3 = pack("C*", '29', '33', '16');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function height_2x(){//高*2
        if($this->socket){
             
            $sendstr3 = pack("C*", '29', '33', '1');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function bold(){//加粗
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '33', '8');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function underline(){//下划线
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '33', '128');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function align_left(){//左对齐
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '97', '48');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function align_right(){//右对齐
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '97', '50');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
    function font_1x(){//字体大小1x
        if($this->socket){
 
            $sendstr3 = pack("C*", '27', '33', '0');
            socket_sendto($this->socket,$sendstr3,strlen($sendstr3),0,$this->host,$this->port);
 
            return true;
        }else{
            return false;
        }
    }
}
 
$net = new Netprint();
$msgtext = '';
$ret = $net->initcon('192.168.00.00'); //打印机IP
if($ret){
    $net->initprint();
 
    $net->width_2x();
    $content = "宽成二\n";
    $net->sendprint($content);
     
    $net->normal();
    $net->normal();
    $net->height_2x();
    $content = "高成二\n";
    $net->sendprint($content);
 
    $net->normal();
    $net->normal();
    $net->width_2x();
    $net->height_2x();
    //$net->bold();
    //$net->middle();
    $content = "宽高成二\n";
    $net->sendprint($content);
 
    $net->normal();
    $net->normal();
    $net->font_1x();
    $content = "普通字体\n";
    $net->sendprint($content);
 
    $net->cutter();
    //$net->closecon();
    $msgtext = '打印成功';
}else{
    $msgtext .= "打印机连接不上 ";
}
echo $msgtext;
?>