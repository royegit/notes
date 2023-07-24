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
            $date = time();
        }
        if (is_string($date)) {
            $time = explode('.',$date);
            $date = (int)strtotime($time[0]);
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
        $DATE_SPLIT_DROP = '.';

        $FORMAT_ARRAY = [
            $DATE_SPLIT_HORIZONTAL,
            $DATE_SPLIT_RIGHT_SLASH,
            $DATE_SPLIT_DROP
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