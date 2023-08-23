# php 工作中用得到的函数

#### 时间格式转换
```injectablephp
    /**
     * 时间格式转换
     * @param string $format - 时间显示的格式；支持 '-' ,'/' ,'.' 三种格式
     * @param string $date - 默认是当前时间，当有某个时间传入时，则以那个时间转换成对应的格式
     * @param bool $IsTime - 是否需要显示时分秒
     * NationalTimeFormat
     * author  roye
     * datetime 2023/7/24 11:01
     * return string
     */
    function NationalTimeFormat(string $format='-',string  $date = '',bool $IsTime=false)
    {
        $Country = env('Country');
        if (empty($date)) {
            return '';
        }
        if (is_string($date)&&strlen($date)>19&&strstr($date, '.')) {
            $date = (int)strtotime(substr_replace($date, '', strripos($date, '.')));
        } else {
            $date = (int)strtotime($date);
        }
        $time = '';
        if ($IsTime==true) {
            $time = ' H:i:s';
        }
        $YEAR_MONTH_DAY = 1;       // 年-月-日
        $DAY_MONTH_YEAR = 2;       // 日-月-年
        $MONTH_DAY_YEAR = 3;       // 月-日-年

        // 分割格式
        $DATE_SPLIT_HORIZONTAL = '-';
        $DATE_SPLIT_RIGHT_SLASH = '/';

        $FORMAT_ARRAY = [
            $DATE_SPLIT_HORIZONTAL,
            $DATE_SPLIT_RIGHT_SLASH
        ];
        if (!in_array($format, $FORMAT_ARRAY)) {
            $format = '-';
        }
        $TimeArray = [
            $DATE_SPLIT_HORIZONTAL => [
                $YEAR_MONTH_DAY => 'Y-m-d'.$time, // 年-月-日
                $DAY_MONTH_YEAR => 'd-m-Y'.$time, // 日-月-年
                $MONTH_DAY_YEAR => 'm-d-Y'.$time  // 月-日-年
            ],
            $DATE_SPLIT_RIGHT_SLASH => [
                $YEAR_MONTH_DAY => 'Y/m/d'.$time,
                $DAY_MONTH_YEAR => 'd/m/Y'.$time,
                $MONTH_DAY_YEAR => 'm/d/Y'.$time
            ],
            $DATE_SPLIT_DROP=>[
                $YEAR_MONTH_DAY => 'Y.m.d'.$time,
                $DAY_MONTH_YEAR => 'd.m.Y'.$time,
                $MONTH_DAY_YEAR => 'm.d.Y'.$time
            ],
        ];
        $CountryArray = [
            'CHN'=>[ // 中国
                $DATE_SPLIT_HORIZONTAL=>$TimeArray[$DATE_SPLIT_HORIZONTAL][$YEAR_MONTH_DAY],
                $DATE_SPLIT_RIGHT_SLASH=>$TimeArray[$DATE_SPLIT_RIGHT_SLASH][$YEAR_MONTH_DAY],
            ],
            'VNM' => [ // 越南
                $DATE_SPLIT_HORIZONTAL=>$TimeArray[$DATE_SPLIT_HORIZONTAL][$DAY_MONTH_YEAR],
                $DATE_SPLIT_RIGHT_SLASH=>$TimeArray[$DATE_SPLIT_RIGHT_SLASH][$DAY_MONTH_YEAR],
            ],
            'PHL' => [ // 菲律宾
                $DATE_SPLIT_HORIZONTAL=>$TimeArray[$DATE_SPLIT_HORIZONTAL][$MONTH_DAY_YEAR],
                $DATE_SPLIT_RIGHT_SLASH=>$TimeArray[$DATE_SPLIT_RIGHT_SLASH][$MONTH_DAY_YEAR],
            ]
        ];
        return date($CountryArray[$Country][$format], $date);
    }
```

#### 比较一个数组是否包含了另外一个数组所有的值

```injectablephp
    /**
     * 比较一个数组是否包含了另外一个数组所有的值
     * @param array $arrayV1
     * @param array $arrayV2
     * IsComplianceArray
     * author  roye
     * datetime 2023/7/28 9:38
     * return bool
     */
    public function IsComplianceArray(array $arrayV1,array $arrayV2):bool
    {
        if(count($arrayV2)==count(array_intersect($arrayV1, $arrayV2)))
        {
            return true;
        };
        return false;
    }
```
**例：**
```injectablephp
$a1=array("a"=>"red","b"=>"green","c"=>"blue","d"=>"yellow");
$a2=array("e"=>"red","f"=>"green","g"=>"blue");

$result=array_intersect($a1,$a2);
print_r($result);exit;

#以$a2为准，返回在$a1中所有和$a2相同的值。
Array
(
    [a] => red
    [b] => green
    [c] => blue
)
```


#### PHP判断是不是爬虫

```injectablephp
public function isRobot() {
        $agent= strtolower(isset($_SERVER['HTTP_USER_AGENT'])? $_SERVER['HTTP_USER_AGENT'] : '');
        if(!empty($agent)){
            $spiderSite= array(
                "spider",
                "TencentTraveler",
                "Baiduspider+",
                "BaiduGame",
                "Googlebot",
                "msnbot",
                "Sosospider+",
                "Sogou web spider",
                "ia_archiver",
                "Yahoo! Slurp",
                "YoudaoBot",
                "Yahoo Slurp",
                "MSNBot",
                "Java (Often spam bot)",
                "BaiDuSpider",
                "Voila",
                "Yandex bot",
                "BSpider",
                "twiceler",
                "Sogou Spider",
                "Speedy Spider",
                "Google AdSense",
                "Heritrix",
                "Python-urllib",
                "Alexa (IA Archiver)",
                "Ask",
                "Exabot",
                "Custo",
                "OutfoxBot/YodaoBot",
                "yacy",
                "SurveyBot",
                "legs",
                "lwp-trivial",
                "Nutch",
                "StackRambler",
                "The web archive (IA Archiver)",
                "Perl tool",
                "MJ12bot",
                "Netcraft",
                "MSIECrawler",
                "WGet tools",
                "larbin",
                "Fish search",
            );
            foreach($spiderSite as $val){
                $str = strtolower($val);
                if(strpos($agent, $str) !== false){
                	echo "是爬虫";
                    return 2;
                }else{
                	echo "不是爬虫";
                    return 1;
                }
            }
        }
    }
```

#####  Referer检测
Referer是指请求来源的URL地址。可以通过检测Referer信息来判断请求是否来自于正常的网站访问。如果Referer信息为空或者不正确，则很可能是爬虫攻击。下面是一个简单的PHP代码示例：

```injectablephp
<?php
$referer =$_SERVER['HTTP_REFERER'];if (empty($referer)||12get_referer($referer,'')!==0){    header('HTTP/1.1 403 Forbidden');    exit();}

function get_referer(){
$url = $_SERVER["HTTP_REFERER"]; //获取完整的来路URL
$str = str_replace(“http://”,””,$url); //去掉http://
$strdomain = explode(“/”,$str); // 以“/”分开成数组
$domain = $strdomain[0]; //取第一个“/”以前的字符
return $domain;
}
 
//对于百度、谷歌搜索引擎来路判断
function get_seo(){
$s = 0;
if(strstr(get_referer(),'baidu.com')){
$s = 1;
}
else if(strstr(get_referer(),'google.com.hk')){
$s = 1;
}
return $s;
?>

```
