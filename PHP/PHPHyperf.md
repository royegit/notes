# php hyperf 框架

#### Hyperf 框架字符串处理 Abstract String Wrapper 

获取字符串长度
> (new Iconv())->strlen('fffffffffwetrowertowie;lk');

字符串截取（从第五个开始截取10个）
> (new Iconv())->substr('fffffffffwetrowertowie;lk',5,10);

查找字符串第一次出现的位置(从0位开始找)
> (new Iconv())->strpos('fffffffffwetrowertowie;lk','to',0);

#### Carbon DateTime的简单API扩展。
```injectablephp
use Carbon\Carbon;

printf("Right now is %s", Carbon::now()->toDateTimeString());
printf("Right now in Vancouver is %s", Carbon::now('America/Vancouver'));  //implicit __toString()
$tomorrow = Carbon::now()->addDay();
$lastWeek = Carbon::now()->subWeek();
$nextSummerOlympics = Carbon::createFromDate(2016)->addYears(4);

$officialDate = Carbon::now()->toRfc2822String();

$howOldAmI = Carbon::createFromDate(1975, 5, 21)->age;

$noonTodayLondonTime = Carbon::createFromTime(12, 0, 0, 'Europe/London');

$internetWillBlowUpOn = Carbon::create(2038, 01, 19, 3, 14, 7, 'GMT');

// Don't really want this to happen so mock now
Carbon::setTestNow(Carbon::createFromDate(2000, 1, 1));

// comparisons are always done in UTC
if (Carbon::now()->gte($internetWillBlowUpOn)) {
    die();
}

// Phew! Return to normal behaviour
Carbon::setTestNow();

if (Carbon::now()->isWeekend()) {
    echo 'Party!';
}
// Over 200 languages (and over 500 regional variants) supported:
echo Carbon::now()->subMinutes(2)->diffForHumans(); // '2 minutes ago'
echo Carbon::now()->subMinutes(2)->locale('zh_CN')->diffForHumans(); // '2分钟前'
echo Carbon::parse('2019-07-23 14:51')->isoFormat('LLLL'); // 'Tuesday, July 23, 2019 2:51 PM'
echo Carbon::parse('2019-07-23 14:51')->locale('fr_FR')->isoFormat('LLLL'); // 'mardi 23 juillet 2019 14:51'

// ... but also does 'from now', 'after' and 'before'
// rolling up to seconds, minutes, hours, days, months, years

$daysSinceEpoch = Carbon::createFromTimestamp(0)->diffInDays();
```

```injectablephp
 * @property      int                 $year
 * @property      int                 $yearIso
 * @property      int                 $month
 * @property      int                 $day
 * @property      int                 $hour
 * @property      int                 $minute
 * @property      int                 $second
 * @property      int                 $micro
 * @property      int                 $microsecond
 * @property      int|float|string    $timestamp                                                                           从Unix纪元以来的几秒
 * @property      string              $englishDayOfWeek                                                                    英语中的星期几
 * @property      string              $shortEnglishDayOfWeek                                                               英语中星期的缩写
 * @property      string              $englishMonth                                                                        英文月份
 * @property      string              $shortEnglishMonth                                                                   英文中缩写的月份
 * @property      int                 $milliseconds
 * @property      int                 $millisecond
 * @property      int                 $milli
 * @property      int                 $week                                                                                1至53
 * @property      int                 $isoWeek                                                                             1至53
 * @property      int                 $weekYear                                                                            年按周格式 - year according to week format
 * @property      int                 $isoWeekYear                                                                         年按ISO周格式 - year according to ISO week format
 * @property      int                 $dayOfYear                                                                           1至366 - 1 through 366
 * @property      int                 $age                                                                                 diffInYears()与默认参数
 * @property      int                 $offset                                                                              以秒为单位的UTC时区偏移量 - the timezone offset in seconds from UTC
 * @property      int                 $offsetMinutes                                                                       以分钟为单位的时区与UTC的偏移量 - the timezone offset in minutes from UTC
 * @property      int                 $offsetHours                                                                         以小时为单位的UTC时区偏移量 - the timezone offset in hours from UTC
 * @property      CarbonTimeZone      $timezone                                                                            当前时区
 * @property      CarbonTimeZone      $tz                                                                                  $timezone的别名
 * @property-read int                 $dayOfWeek                                                                           0(星期日)至6(星期六)
 * @property-read int                 $dayOfWeekIso                                                                        1(周一)至7(周日)
 * @property-read int                 $weekOfYear                                                                          ISO-8601年的周数，周从星期一开始
 * @property-read int                 $daysInMonth                                                                         给定月份中的天数
 * @property-read string              $latinMeridiem                                                                       “am”/“pm”(子午线前或子午线后拉丁小写标记) - "am"/"pm" (Ante meridiem or Post meridiem latin lowercase mark)
 * @property-read string              $latinUpperMeridiem                                                                  “AM”/“PM”(子午线前或子午线后拉丁文大写标记) - "AM"/"PM" (Ante meridiem or Post meridiem latin uppercase mark)
 * @property-read string              $timezoneAbbreviatedName                                                             当前时区的缩写名 - the current timezone abbreviated name
 * @property-read string              $tzAbbrName                                                                          $ timezone缩写名称的别名 - alias of $timezoneAbbreviatedName
 * @property-read string              $dayName                                                                             工作日的长名称翻译根据碳地区，在英语中，如果没有翻译可用的当前语言 - long name of weekday translated according to Carbon locale, in english if no translation available for current language
 * @property-read string              $shortDayName                                                                        工作日的短名称，根据碳地区翻译，在英语中，如果没有翻译可用的当前语言 - short name of weekday translated according to Carbon locale, in english if no translation available for current language
 * @property-read string              $minDayName                                                                          非常短的工作日名称翻译根据碳地区，在英语中，如果没有翻译可用的当前语言 - very short name of weekday translated according to Carbon locale, in english if no translation available for current language
 * @property-read string              $monthName                                                                           如果没有当前语言的翻译可用，则根据Carbon地区翻译的长月份名称为英语 - long name of month translated according to Carbon locale, in english if no translation available for current language
 * @property-read string              $shortMonthName                                                                      月的简称，根据碳地区翻译，如果没有翻译可用的当前语言，在英语 - short name of month translated according to Carbon locale, in english if no translation available for current language
 * @property-read string              $meridiem                                                                            小写子午线标记根据Carbon地区翻译，如果当前语言没有可用的翻译，则为拉丁语 - lowercase meridiem mark translated according to Carbon locale, in latin if no translation available for current language
 * @property-read string              $upperMeridiem                                                                       大写子午线标记根据Carbon地区翻译，如果当前语言没有可用的翻译，则为拉丁语 - uppercase meridiem mark translated according to Carbon locale, in latin if no translation available for current language
 * @property-read int                 $noZeroHour                                                                          当前小时从1到24 - current hour from 1 to 24
 * @property-read int                 $weeksInYear                                                                         51 - 53 - 51 through 53
 * @property-read int                 $isoWeeksInYear                                                                      51 - 53 - 51 through 53
 * @property-read int                 $weekOfMonth                                                                         1 ~ 5 - 1 through 5
 * @property-read int                 $weekNumberInMonth                                                                   1 through 5
 * @property-read int                 $firstWeekDay                                                                        0 through 6
 * @property-read int                 $lastWeekDay                                                                         0 through 6
 * @property-read int                 $daysInYear                                                                          365或366 - 365 or 366
 * @property-read int                 $quarter                                                                             在这种情况下，t的夸脱是1 - 4 - the quart**er of t**his instance, 1 - 4
 * @property-read int                 $decade                                                                              这个例子的十年 - the decade of this instance
 * @property-read int                 $century                                                                             这个例子的世纪 - the century of this instance
 * @property-read int                 $millennium                                                                          这个例子的千年 - the millennium of this instance
 * @property-read bool                $dst                                                                                 夏令时指示器，如果是夏令时为true，否则为false - daylight savings time indicator, true if DST, false otherwise
 * @property-read bool                $local                                                                               检查时区是否为本地，如果为本地则为true，否则为false - checks if the timezone is local, true if local, false otherwise
 * @property-read bool                $utc                                                                                 检查时区是否为UTC，如果为true，否则为false - checks if the timezone is UTC, true if UTC, false otherwise
 * @property-read string              $timezoneName                                                                        当前时区名称 - the current timezone name
 * @property-read string              $tzName                                                                              $timezoneName的别名 - alias of $timezoneName
 * @property-read string              $locale                                                                              当前实例的区域设置 - locale of the current instance
 *
 * @method        bool                isUtc()                                                                              检查当前实例是否具有UTC时区。(isUtc和isUtc情况都有效。) - Check if the current instance has UTC timezone. (Both isUtc and isUTC cases are valid.)
 * @method        bool                isLocal()                                                                            检查当前实例是否具有非utc时区。 - Check if the current instance has non-UTC timezone.
 * @method        bool                isValid()                                                                            检查当前实例是否为有效日期。 - Check if the current instance is a valid date.
 * @method        bool                isDST()                                                                              检查当前实例是否采用夏令时。 - Check if the current instance is in a daylight saving time.
 * @method        bool                isSunday()                                                                           检查实例日是否为星期日 - Checks if the instance day is sunday.
 * @method        bool                isMonday()                                                                           检查实例日是否为星期一。 - Checks if the instance day is monday.
 * @method        bool                isTuesday()                                                                          检查实例日是否为星期二。 - Checks if the instance day is tuesday.
 * @method        bool                isWednesday()                                                                        检查实例日是否为星期三。 - Checks if the instance day is wednesday.
 * @method        bool                isThursday()                                                                         检查实例日是否为星期四。 - Checks if the instance day is thursday.
 * @method        bool                isFriday()                                                                           检查实例日是否为星期五。 - Checks if the instance day is friday.
 * @method        bool                isSaturday()                                                                         检查实例日是否为星期六。 - Checks if the instance day is saturday.
 * @method        bool                isSameYear(Carbon|DateTimeInterface|string|null $date = null)                        检查给定的日期是否与实例在同一年。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same year as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentYear()                                                                      检查实例是否与当前时刻处于同一年。 - Checks if the instance is in the same year as the current moment.
 * @method        bool                isNextYear()                                                                         检查实例是否与明年的当前时刻处于同一年。 - Checks if the instance is in the same year as the current moment next year.
 * @method        bool                isLastYear()                                                                         检查实例是否与去年的当前时刻处于同一年。 - Checks if the instance is in the same year as the current moment last year.
 * @method        bool                isSameWeek(Carbon|DateTimeInterface|string|null $date = null)                        检查给定的日期是否与实例在同一周。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same week as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentWeek()                                                                      检查实例是否与当前时刻处于同一周。 - Checks if the instance is in the same week as the current moment.
 * @method        bool                isNextWeek()                                                                         检查实例是否与下周的当前时刻处于同一周。 - Checks if the instance is in the same week as the current moment next week.
 * @method        bool                isLastWeek()                                                                         检查实例是否与上周的当前时刻处于同一周。 - Checks if the instance is in the same week as the current moment last week.
 * @method        bool                isSameDay(Carbon|DateTimeInterface|string|null $date = null)                         检查给定的日期是否与实例在同一天。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same day as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentDay()                                                                       检查实例是否与当前时刻在同一天。 - Checks if the instance is in the same day as the current moment.
 * @method        bool                isNextDay()                                                                          检查实例是否与第二天的当前时刻在同一天。 - Checks if the instance is in the same day as the current moment next day.
 * @method        bool                isLastDay()                                                                          检查实例是否与前一天的当前时刻在同一天。 - Checks if the instance is in the same day as the current moment last day.
 * @method        bool                isSameHour(Carbon|DateTimeInterface|string|null $date = null)                        检查给定的日期是否与实例在同一小时内。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same hour as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentHour()                                                                      检查实例是否与当前时刻处于同一小时。 - Checks if the instance is in the same hour as the current moment.
 * @method        bool                isNextHour()                                                                         检查实例是否与下一小时的当前时刻处于同一小时。 - Checks if the instance is in the same hour as the current moment next hour.
 * @method        bool                isLastHour()                                                                         检查实例是否与当前时刻(上一小时)处于同一小时。 - Checks if the instance is in the same hour as the current moment last hour.
 * @method        bool                isSameMinute(Carbon|DateTimeInterface|string|null $date = null)                      检查给定的日期是否与实例属于同一分钟。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same minute as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentMinute()                                                                    检查实例是否与当前时刻处于同一分钟。 - Checks if the instance is in the same minute as the current moment.
 * @method        bool                isNextMinute()                                                                       检查实例是否与下一分钟的当前时刻处于同一分钟。 - Checks if the instance is in the same minute as the current moment next minute.
 * @method        bool                isLastMinute()                                                                       检查实例是否与当前时刻的最后一分钟处于同一分钟。 - Checks if the instance is in the same minute as the current moment last minute.
 * @method        bool                isSameSecond(Carbon|DateTimeInterface|string|null $date = null)                      检查给定的日期是否与实例在同一秒内。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same second as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentSecond()                                                                    检查实例是否与当前时刻处于同一秒。 - Checks if the instance is in the same second as the current moment.
 * @method        bool                isNextSecond()                                                                       检查实例是否在下一秒与当前时刻处于同一秒。 - Checks if the instance is in the same second as the current moment next second.
 * @method        bool                isLastSecond()                                                                       检查实例是否与上一秒的当前时刻处于同一秒。 - Checks if the instance is in the same second as the current moment last second.
 * @method        bool                isSameMicro(Carbon|DateTimeInterface|string|null $date = null)                       检查给定的日期是否与实例在同一微秒内。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same microsecond as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentMicro()                                                                     检查实例是否与当前时刻处于同一微秒内。 - Checks if the instance is in the same microsecond as the current moment.
 * @method        bool                isNextMicro()                                                                        检查实例是否与当前时刻处于同一微秒内。 - Checks if the instance is in the same microsecond as the current moment next microsecond.
 * @method        bool                isLastMicro()                                                                        检查实例是否与当前时刻在同一微秒内。 - Checks if the instance is in the same microsecond as the current moment last microsecond.
 * @method        bool                isSameMicrosecond(Carbon|DateTimeInterface|string|null $date = null)                 检查给定的日期是否与实例在同一微秒内。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same microsecond as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentMicrosecond()                                                               检查实例是否与当前时刻处于同一微秒内。 - Checks if the instance is in the same microsecond as the current moment.
 * @method        bool                isNextMicrosecond()                                                                  检查实例是否与当前时刻处于同一微秒内。 - Checks if the instance is in the same microsecond as the current moment next microsecond.
 * @method        bool                isLastMicrosecond()                                                                  检查实例是否与当前时刻在同一微秒内。 - Checks if the instance is in the same microsecond as the current moment last microsecond.
 * @method        bool                isCurrentMonth()                                                                     检查实例是否与当前时刻在同一个月份。 - Checks if the instance is in the same month as the current moment.
 * @method        bool                isNextMonth()                                                                        检查实例是否与下个月的当前时刻在同一个月份。 - Checks if the instance is in the same month as the current moment next month.
 * @method        bool                isLastMonth()                                                                        检查实例是否与上个月的当前时刻在同一个月份。 - Checks if the instance is in the same month as the current moment last month.
 * @method        bool                isCurrentQuarter()                                                                   检查实例是否与当前时刻处于同一季度。 - Checks if the instance is in the same quarter as the current moment.
 * @method        bool                isNextQuarter()                                                                      检查实例是否与下一季度的当前时刻处于同一季度。 - Checks if the instance is in the same quarter as the current moment next quarter.
 * @method        bool                isLastQuarter()                                                                      检查实例是否与上一季度的当前时刻处于同一季度 - Checks if the instance is in the same quarter as the current moment last quarter.
 * @method        bool                isSameDecade(Carbon|DateTimeInterface|string|null $date = null)                      检查给定的日期是否与实例属于同一十年。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same decade as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentDecade()                                                                    检查实例是否与当前时刻处于同一十年内。 - Checks if the instance is in the same decade as the current moment.
 * @method        bool                isNextDecade()                                                                       检查实例是否在下一个十年中与当前时刻处于同一十年中。 - Checks if the instance is in the same decade as the current moment next decade.
 * @method        bool                isLastDecade()                                                                       检查实例是否与过去十年的当前时刻处于同一十年中。 - Checks if the instance is in the same decade as the current moment last decade.
 * @method        bool                isSameCentury(Carbon|DateTimeInterface|string|null $date = null)                     检查给定的日期是否与实例处于同一世纪。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same century as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentCentury()                                                                   检查实例是否与当前时刻处于同一世纪。 - Checks if the instance is in the same century as the current moment.
 * @method        bool                isNextCentury()                                                                      检查实例是否与下一个世纪的当前时刻处于同一世纪。 - Checks if the instance is in the same century as the current moment next century.
 * @method        bool                isLastCentury()                                                                      检查实例是否与上个世纪的当前时刻处于同一世纪。 - Checks if the instance is in the same century as the current moment last century.
 * @method        bool                isSameMillennium(Carbon|DateTimeInterface|string|null $date = null)                  检查给定的日期是否与实例属于同一千禧年。如果传递null，与现在(使用相同的时区)进行比较。 - Checks if the given date is in the same millennium as the instance. If null passed, compare to now (with the same timezone).
 * @method        bool                isCurrentMillennium()                                                                检查实例是否与当前时刻处于同一千禧年。 - Checks if the instance is in the same millennium as the current moment.
 * @method        bool                isNextMillennium()                                                                   检查实例是否与下一个千禧年的当前时刻处于同一千禧年。 - Checks if the instance is in the same millennium as the current moment next millennium.
 * @method        bool                isLastMillennium()                                                                   检查实例是否与上一千年的当前时刻处于同一千年中。 - Checks if the instance is in the same millennium as the current moment last millennium.
 * @method        $this               years(int $value)                                                                    将当前实例年份设置为给定值。 - Set current instance year to the given value.
 * @method        $this               year(int $value)                                                                     将当前实例年份设置为给定值。 - Set current instance year to the given value.
 * @method        $this               setYears(int $value)                                                                 将当前实例年份设置为给定值。 - Set current instance year to the given value.
 * @method        $this               setYear(int $value)                                                                  将当前实例年份设置为给定值。 - Set current instance year to the given value.
 * @method        $this               months(int $value)                                                                   将当前实例月份设置为给定值。 - Set current instance month to the given value.
 * @method        $this               month(int $value)                                                                    将当前实例月份设置为给定值。 - Set current instance month to the given value.
 * @method        $this               setMonths(int $value)                                                                将当前实例月份设置为给定值。 - Set current instance month to the given value.
 * @method        $this               setMonth(int $value)                                                                 将当前实例月份设置为给定值。 - Set current instance month to the given value.
 * @method        $this               days(int $value)                                                                     将当前实例日设置为给定值。 - Set current instance day to the given value.
 * @method        $this               day(int $value)                                                                      将当前实例日设置为给定值。 - Set current instance day to the given value.
 * @method        $this               setDays(int $value)                                                                  将当前实例日设置为给定值。 - Set current instance day to the given value.
 * @method        $this               setDay(int $value)                                                                   将当前实例日设置为给定值。 - Set current instance day to the given value.
 * @method        $this               hours(int $value)                                                                    将当前实例小时设置为给定值。 - Set current instance hour to the given value.
 * @method        $this               hour(int $value)                                                                     将当前实例小时设置为给定值。 - Set current instance hour to the given value.
 * @method        $this               setHours(int $value)                                                                 将当前实例小时设置为给定值。 - Set current instance hour to the given value.
 * @method        $this               setHour(int $value)                                                                  将当前实例小时设置为给定值。 - Set current instance hour to the given value.
 * @method        $this               minutes(int $value)                                                                  将当前实例分钟设置为给定值。 - Set current instance minute to the given value.
 * @method        $this               minute(int $value)                                                                   将当前实例分钟设置为给定值。 - Set current instance minute to the given value.
 * @method        $this               setMinutes(int $value)                                                               将当前实例分钟设置为给定值。 - Set current instance minute to the given value.
 * @method        $this               setMinute(int $value)                                                                将当前实例分钟设置为给定值。 - Set current instance minute to the given value.
 * @method        $this               seconds(int $value)                                                                  将当前实例秒设置为给定值。 - Set current instance second to the given value.
 * @method        $this               second(int $value)                                                                   将当前实例秒设置为给定值。 - Set current instance second to the given value.
 * @method        $this               setSeconds(int $value)                                                               将当前实例秒设置为给定值。 - Set current instance second to the given value.
 * @method        $this               setSecond(int $value)                                                                将当前实例秒设置为给定值。 - Set current instance second to the given value.
 * @method        $this               millis(int $value)                                                                   将当前实例秒设置为给定值。 - Set current instance millisecond to the given value.
 * @method        $this               milli(int $value)                                                                    Set current instance millisecond to the given value.
 * @method        $this               setMillis(int $value)                                                                Set current instance millisecond to the given value.
 * @method        $this               setMilli(int $value)                                                                 Set current instance millisecond to the given value.
 * @method        $this               milliseconds(int $value)                                                             Set current instance millisecond to the given value.
 * @method        $this               millisecond(int $value)                                                              Set current instance millisecond to the given value.
 * @method        $this               setMilliseconds(int $value)                                                          Set current instance millisecond to the given value.
 * @method        $this               setMillisecond(int $value)                                                           Set current instance millisecond to the given value.
 * @method        $this               micros(int $value)                                                                   将当前实例微秒设置为给定值。 - Set current instance microsecond to the given value.
 * @method        $this               micro(int $value)                                                                    Set current instance microsecond to the given value.
 * @method        $this               setMicros(int $value)                                                                Set current instance microsecond to the given value.
 * @method        $this               setMicro(int $value)                                                                 Set current instance microsecond to the given value.
 * @method        $this               microseconds(int $value)                                                             Set current instance microsecond to the given value.
 * @method        $this               microsecond(int $value)                                                              Set current instance microsecond to the given value.
 * @method        $this               setMicroseconds(int $value)                                                          Set current instance microsecond to the given value.
 * @method        $this               setMicrosecond(int $value)                                                           Set current instance microsecond to the given value.
 * @method        $this               addYears(int $value = 1)                                                             向实例添加年数(传入的$value计数)(使用日期间隔)。 - Add years (the $value count passed in) to the instance (using date interval).
 * @method        $this               addYear()                                                                            向实例添加一年(使用日期间隔)。 - Add one year to the instance (using date interval).
 * @method        $this               subYears(int $value = 1)                                                             子年份(传入的$value计数)到实例(使用日期间隔)。 - Sub years (the $value count passed in) to the instance (using date interval).
 * @method        $this               subYear()                                                                            为实例添加一年(使用日期间隔)。 - Sub one year to the instance (using date interval).
 * @method        $this               addYearsWithOverflow(int $value = 1)                                                 向实例(使用日期间隔)添加年数(传入的$value计数)，明确允许溢出。 - Add years (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addYearWithOverflow()                                                                向实例添加一年(使用日期间隔)，明确允许溢出。 - Add one year to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subYearsWithOverflow(int $value = 1)                                                 子年(传入的$value计数)到实例(使用日期间隔)，明确允许溢出。 - Sub years (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subYearWithOverflow()                                                                为实例指定一年(使用日期间隔)，并明确允许溢出。 - Sub one year to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addYearsWithoutOverflow(int $value = 1)                                              向实例(使用日期间隔)添加年份(传入的$value计数)，明确禁止溢出。 - Add years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addYearWithoutOverflow()                                                             向实例添加一年(使用日期间隔)，明确禁止溢出。 - Add one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearsWithoutOverflow(int $value = 1)                                              子年(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearWithoutOverflow()                                                             为实例指定一年(使用日期间隔)，明确禁止溢出。 - Sub one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addYearsWithNoOverflow(int $value = 1)                                               向实例(使用日期间隔)添加年份(传入的$value计数)，明确禁止溢出。 - Add years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addYearWithNoOverflow()                                                              向实例添加一年(使用日期间隔)，明确禁止溢出。 - Add one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearsWithNoOverflow(int $value = 1)                                               子年(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearWithNoOverflow()                                                              为实例指定一年(使用日期间隔)，明确禁止溢出。 - Sub one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addYearsNoOverflow(int $value = 1)                                                   向实例(使用日期间隔)添加年份(传入的$value计数)，明确禁止溢出。 - Add years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addYearNoOverflow()                                                                  向实例添加一年(使用日期间隔)，明确禁止溢出。 - Add one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearsNoOverflow(int $value = 1)                                                   子年(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub years (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subYearNoOverflow()                                                                  为实例指定一年(使用日期间隔)，明确禁止溢出。 - Sub one year to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonths(int $value = 1)                                                            向实例添加月份(传入的$value计数)(使用日期间隔)。 - Add months (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMonth()                                                                           向实例添加一个月(使用日期间隔)。 - Add one month to the instance (using date interval).
 * @method        $this               subMonths(int $value = 1)                                                            子月份(传入的$value计数)到实例(使用日期间隔)。 - Sub months (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMonth()                                                                           为实例添加一个月(使用日期间隔)。 - Sub one month to the instance (using date interval).
 * @method        $this               addMonthsWithOverflow(int $value = 1)                                                向实例(使用日期间隔)添加月份(传入的$value计数)，明确允许溢出。 - Add months (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addMonthWithOverflow()                                                               向实例添加一个月(使用日期间隔)，明确允许溢出。 - Add one month to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subMonthsWithOverflow(int $value = 1)                                                子月份(传入的$value计数)到实例(使用日期间隔)，明确允许溢出。 - Sub months (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subMonthWithOverflow()                                                               为实例添加一个月(使用日期间隔)，明确允许溢出。 - Sub one month to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addMonthsWithoutOverflow(int $value = 1)                                             向实例(使用日期间隔)添加月份(传入的$value计数)，明确禁止溢出。 - Add months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonthWithoutOverflow()                                                            向实例添加一个月(使用日期间隔)，明确禁止溢出。 - Add one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthsWithoutOverflow(int $value = 1)                                             明确禁止溢出的子月份(传入的$value计数)到实例(使用日期间隔)。 - Sub months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthWithoutOverflow()                                                            为实例指定一个月(使用日期间隔)，明确禁止溢出。 - Sub one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonthsWithNoOverflow(int $value = 1)                                              向实例(使用日期间隔)添加月份(传入的$value计数)，明确禁止溢出。 - Add months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonthWithNoOverflow()                                                             向实例添加一个月(使用日期间隔)，明确禁止溢出。 - Add one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthsWithNoOverflow(int $value = 1)                                              明确禁止溢出的子月份(传入的$value计数)到实例(使用日期间隔)。 - Sub months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthWithNoOverflow()                                                             为实例指定一个月(使用日期间隔)，明确禁止溢出。 - Sub one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonthsNoOverflow(int $value = 1)                                                  向实例(使用日期间隔)添加月份(传入的$value计数)，明确禁止溢出。 - Add months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMonthNoOverflow()                                                                 向实例添加一个月(使用日期间隔)，明确禁止溢出。 - Add one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthsNoOverflow(int $value = 1)                                                  明确禁止溢出的子月份(传入的$value计数)到实例(使用日期间隔)。 - Sub months (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMonthNoOverflow()                                                                 为实例指定一个月(使用日期间隔)，明确禁止溢出。 - Sub one month to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDays(int $value = 1)                                                              向实例添加天数(传入的$value计数)(使用日期间隔)。 - Add days (the $value count passed in) to the instance (using date interval).
 * @method        $this               addDay()                                                                             向实例添加一天(使用日期间隔)。 - Add one day to the instance (using date interval).
 * @method        $this               subDays(int $value = 1)                                                              子天(传入的$value计数)到实例(使用日期间隔)。 - Sub days (the $value count passed in) to the instance (using date interval).
 * @method        $this               subDay()                                                                             为实例添加一天(使用日期间隔)。 - Sub one day to the instance (using date interval).
 * @method        $this               addHours(int $value = 1)                                                             向实例添加小时数(传入的$value计数)(使用日期间隔)。 - Add hours (the $value count passed in) to the instance (using date interval).
 * @method        $this               addHour()                                                                            向实例添加一个小时(使用日期间隔)。 - Add one hour to the instance (using date interval).
 * @method        $this               subHours(int $value = 1)                                                             子小时数(传入的$value计数)到实例(使用日期间隔)。 - Sub hours (the $value count passed in) to the instance (using date interval).
 * @method        $this               subHour()                                                                            为实例减去一个小时(使用日期间隔)。 - Sub one hour to the instance (using date interval).
 * @method        $this               addMinutes(int $value = 1)                                                           向实例添加分钟数(传入的$value计数)(使用日期间隔)。 - Add minutes (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMinute()                                                                          向实例添加一分钟(使用日期间隔)。 - Add one minute to the instance (using date interval).
 * @method        $this               subMinutes(int $value = 1)                                                           分分钟(传入的$value计数)到实例(使用日期间隔)。 - Sub minutes (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMinute()                                                                          将实例减去一分钟(使用日期间隔)。 - Sub one minute to the instance (using date interval).
 * @method        $this               addSeconds(int $value = 1)                                                           向实例添加秒数(传入的$value计数)(使用日期间隔)。 - Add seconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               addSecond()                                                                          向实例添加一秒(使用日期间隔)。 - Add one second to the instance (using date interval).
 * @method        $this               subSeconds(int $value = 1)                                                           子秒(传入的$value计数)到实例(使用日期间隔)。 - Sub seconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               subSecond()                                                                          为实例减去一秒(使用日期间隔)。 - Sub one second to the instance (using date interval).
 * @method        $this               addMillis(int $value = 1)                                                            向实例添加毫秒数(传入的$value计数)(使用日期间隔)。 - Add milliseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMilli()                                                                           向实例添加1毫秒(使用日期间隔)。 - Add one millisecond to the instance (using date interval).
 * @method        $this               subMillis(int $value = 1)                                                            子毫秒(传入的$value计数)到实例(使用日期间隔)。 - Sub milliseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMilli()                                                                           将一毫秒分配给实例(使用日期间隔)。 - Sub one millisecond to the instance (using date interval).
 * @method        $this               addMilliseconds(int $value = 1)                                                      向实例添加毫秒数(传入的$value计数)(使用日期间隔)。 - Add milliseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMillisecond()                                                                     向实例添加1毫秒(使用日期间隔)。 - Add one millisecond to the instance (using date interval).
 * @method        $this               subMilliseconds(int $value = 1)                                                      子毫秒(传入的$value计数)到实例(使用日期间隔)。 - Sub milliseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMillisecond()                                                                     将一毫秒分配给实例(使用日期间隔)。 - Sub one millisecond to the instance (using date interval).
 * @method        $this               addMicros(int $value = 1)                                                            向实例添加微秒数(传入的$value计数)(使用日期间隔)。 - Add microseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMicro()                                                                           为实例添加一微秒(使用日期间隔)。 - Add one microsecond to the instance (using date interval).
 * @method        $this               subMicros(int $value = 1)                                                            子微秒(传入的$value计数)到实例(使用日期间隔)。 - Sub microseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMicro()                                                                           将实例缩短一微秒(使用日期间隔)。 - Sub one microsecond to the instance (using date interval).
 * @method        $this               addMicroseconds(int $value = 1)                                                      向实例添加微秒数(传入的$value计数)(使用日期间隔)。 - Add microseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMicrosecond()                                                                     为实例添加一微秒(使用日期间隔)。 - Add one microsecond to the instance (using date interval).
 * @method        $this               subMicroseconds(int $value = 1)                                                      子微秒(传入的$value计数)到实例(使用日期间隔)。 - Sub microseconds (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMicrosecond()                                                                     将实例缩短一微秒(使用日期间隔)。 - Sub one microsecond to the instance (using date interval).
 * @method        $this               addMillennia(int $value = 1)                                                         向实例添加千年(传入的$value计数)(使用日期间隔)。 - Add millennia (the $value count passed in) to the instance (using date interval).
 * @method        $this               addMillennium()                                                                      向实例添加一个千禧年(使用日期间隔)。 - Add one millennium to the instance (using date interval).
 * @method        $this               subMillennia(int $value = 1)                                                         次千年(传入的$value计数)到实例(使用日期间隔)。 - Sub millennia (the $value count passed in) to the instance (using date interval).
 * @method        $this               subMillennium()                                                                      将千禧年添加到实例(使用日期间隔)。 - Sub one millennium to the instance (using date interval).
 * @method        $this               addMillenniaWithOverflow(int $value = 1)                                             将千年(传入的$value计数)添加到实例(使用日期间隔)，明确允许溢出。 - Add millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addMillenniumWithOverflow()                                                          向实例添加一个千禧年(使用日期间隔)，明确允许溢出。 - Add one millennium to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subMillenniaWithOverflow(int $value = 1)                                             次千年(传入的$value计数)到实例(使用日期间隔)，明确允许溢出。 - Sub millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subMillenniumWithOverflow()                                                          向实例添加一个千禧年(使用日期间隔)，明确允许溢出。 - Sub one millennium to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addMillenniaWithoutOverflow(int $value = 1)                                          向实例(使用日期间隔)添加千年(传入的$value计数)，明确禁止溢出。 - Add millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMillenniumWithoutOverflow()                                                       向实例添加一个千禧年(使用日期间隔)，明确禁止溢出。 - Add one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniaWithoutOverflow(int $value = 1)                                          次千年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniumWithoutOverflow()                                                       向实例指定一个千禧年(使用日期间隔)，明确禁止溢出。 - Sub one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMillenniaWithNoOverflow(int $value = 1)                                           向实例(使用日期间隔)添加千年(传入的$value计数)，明确禁止溢出。 - Add millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMillenniumWithNoOverflow()                                                        向实例添加一个千禧年(使用日期间隔)，明确禁止溢出。 - Add one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniaWithNoOverflow(int $value = 1)                                           次千年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniumWithNoOverflow()                                                        向实例指定一个千禧年(使用日期间隔)，明确禁止溢出。 - Sub one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMillenniaNoOverflow(int $value = 1)                                               向实例(使用日期间隔)添加千年(传入的$value计数)，明确禁止溢出。 - Add millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addMillenniumNoOverflow()                                                            向实例添加一个千禧年(使用日期间隔)，明确禁止溢出。 - Add one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniaNoOverflow(int $value = 1)                                               次千年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub millennia (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subMillenniumNoOverflow()                                                            向实例指定一个千禧年(使用日期间隔)，明确禁止溢出。 - Sub one millennium to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturies(int $value = 1)                                                         向实例添加世纪数(传入的$value计数)(使用日期间隔)。 - Add centuries (the $value count passed in) to the instance (using date interval).
 * @method        $this               addCentury()                                                                         向实例添加一个世纪(使用日期间隔)。 - Add one century to the instance (using date interval).
 * @method        $this               subCenturies(int $value = 1)                                                         子世纪(传入的$value计数)到实例(使用日期间隔)。 - Sub centuries (the $value count passed in) to the instance (using date interval).
 * @method        $this               subCentury()                                                                         为实例添加一个世纪(使用日期间隔)。 - Sub one century to the instance (using date interval).
 * @method        $this               addCenturiesWithOverflow(int $value = 1)                                             将世纪数(传入的$value计数)添加到实例(使用日期间隔)，明确允许溢出。 - Add centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addCenturyWithOverflow()                                                             向实例添加一个世纪(使用日期间隔)，明确允许溢出。 - Add one century to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subCenturiesWithOverflow(int $value = 1)                                             子世纪(传入的$value计数)到实例(使用日期间隔)，明确允许溢出。 - Sub centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subCenturyWithOverflow()                                                             向实例添加一个世纪(使用日期间隔)，明确允许溢出。 - Sub one century to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addCenturiesWithoutOverflow(int $value = 1)                                          向实例(使用日期间隔)添加世纪数(传入的$value计数)，明确禁止溢出。 - Add centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturyWithoutOverflow()                                                          向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Add one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturiesWithoutOverflow(int $value = 1)                                          子世纪(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturyWithoutOverflow()                                                          向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Sub one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturiesWithNoOverflow(int $value = 1)                                           向实例(使用日期间隔)添加世纪数(传入的$value计数)，明确禁止溢出。 - Add centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturyWithNoOverflow()                                                           向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Add one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturiesWithNoOverflow(int $value = 1)                                           子世纪(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturyWithNoOverflow()                                                           向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Sub one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturiesNoOverflow(int $value = 1)                                               向实例(使用日期间隔)添加世纪数(传入的$value计数)，明确禁止溢出。 - Add centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addCenturyNoOverflow()                                                               向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Add one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturiesNoOverflow(int $value = 1)                                               子世纪(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub centuries (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subCenturyNoOverflow()                                                               向实例添加一个世纪(使用日期间隔)，明确禁止溢出。 - Sub one century to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecades(int $value = 1)                                                           向实例添加年代(传入的$value计数)(使用日期间隔)。 - Add decades (the $value count passed in) to the instance (using date interval).
 * @method        $this               addDecade()                                                                          向实例添加十年(使用日期间隔)。 - Add one decade to the instance (using date interval).
 * @method        $this               subDecades(int $value = 1)                                                           子几十年(传入的$value计数)到实例(使用日期间隔)。 - Sub decades (the $value count passed in) to the instance (using date interval).
 * @method        $this               subDecade()                                                                          向实例添加一个十年(使用日期间隔)。 - Sub one decade to the instance (using date interval).
 * @method        $this               addDecadesWithOverflow(int $value = 1)                                               在明确允许溢出的情况下，向实例(使用日期间隔)添加几十年(传入的$value计数)。 - Add decades (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addDecadeWithOverflow()                                                              在明确允许溢出的情况下，为实例添加一个十年(使用日期间隔)。 - Add one decade to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subDecadesWithOverflow(int $value = 1)                                               在显式允许溢出的情况下，将数十年(传入的$value计数)分配给实例(使用日期间隔)。 - Sub decades (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subDecadeWithOverflow()                                                              在明确允许溢出的情况下，向实例添加一个十年(使用日期间隔)。 - Sub one decade to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addDecadesWithoutOverflow(int $value = 1)                                            向实例(使用日期间隔)添加几十年(传入的$value计数)，明确禁止溢出。 - Add decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecadeWithoutOverflow()                                                           为实例添加一个十年(使用日期间隔)，明确禁止溢出。 - Add one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadesWithoutOverflow(int $value = 1)                                            子几十年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadeWithoutOverflow()                                                           向实例分配十年(使用日期间隔)，明确禁止溢出。 - Sub one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecadesWithNoOverflow(int $value = 1)                                             向实例(使用日期间隔)添加几十年(传入的$value计数)，明确禁止溢出。 - Add decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecadeWithNoOverflow()                                                            为实例添加一个十年(使用日期间隔)，明确禁止溢出。 - Add one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadesWithNoOverflow(int $value = 1)                                             子几十年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadeWithNoOverflow()                                                            向实例分配十年(使用日期间隔)，明确禁止溢出。 - Sub one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecadesNoOverflow(int $value = 1)                                                 向实例(使用日期间隔)添加几十年(传入的$value计数)，明确禁止溢出。 - Add decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addDecadeNoOverflow()                                                                为实例添加一个十年(使用日期间隔)，明确禁止溢出。 - Add one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadesNoOverflow(int $value = 1)                                                 子几十年(传入的$value计数)到实例(使用日期间隔)，明确禁止溢出。 - Sub decades (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subDecadeNoOverflow()                                                                向实例分配十年(使用日期间隔)，明确禁止溢出。 - Sub one decade to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuarters(int $value = 1)                                                          向实例添加四分之一(传入的$value计数)(使用日期间隔)。 - Add quarters (the $value count passed in) to the instance (using date interval).
 * @method        $this               addQuarter()                                                                         向实例添加1 / 4(使用日期间隔)。 - Add one quarter to the instance (using date interval).
 * @method        $this               subQuarters(int $value = 1)                                                          子季度(传入的$value计数)到实例(使用日期间隔)。 - Sub quarters (the $value count passed in) to the instance (using date interval).
 * @method        $this               subQuarter()                                                                         为实例减去四分之一(使用日期间隔)。 - Sub one quarter to the instance (using date interval).
 * @method        $this               addQuartersWithOverflow(int $value = 1)                                              向实例(使用日期间隔)添加四分之一(传入的$value计数)，明确允许溢出。 - Add quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addQuarterWithOverflow()                                                             向实例添加四分之一(使用日期间隔)，明确允许溢出。 - Add one quarter to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subQuartersWithOverflow(int $value = 1)                                              子季度(传入的$value计数)到实例(使用日期间隔)，明确允许溢出。 - Sub quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               subQuarterWithOverflow()                                                             向实例添加四分之一(使用日期间隔)，明确允许溢出。 - Sub one quarter to the instance (using date interval) with overflow explicitly allowed.
 * @method        $this               addQuartersWithoutOverflow(int $value = 1)                                           向实例(使用日期间隔)添加四分之一(传入的$value计数)，明确禁止溢出。 - Add quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuarterWithoutOverflow()                                                          向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Add one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuartersWithoutOverflow(int $value = 1)                                           子季度(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuarterWithoutOverflow()                                                          向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Sub one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuartersWithNoOverflow(int $value = 1)                                            向实例(使用日期间隔)添加四分之一(传入的$value计数)，明确禁止溢出。 - Add quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuarterWithNoOverflow()                                                           向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Add one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuartersWithNoOverflow(int $value = 1)                                            子季度(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuarterWithNoOverflow()                                                           向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Sub one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuartersNoOverflow(int $value = 1)                                                向实例(使用日期间隔)添加四分之一(传入的$value计数)，明确禁止溢出。 - Add quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addQuarterNoOverflow()                                                               向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Add one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuartersNoOverflow(int $value = 1)                                                子季度(传入的$value计数)到实例(使用日期间隔)明确禁止溢出。 - Sub quarters (the $value count passed in) to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               subQuarterNoOverflow()                                                               向实例添加四分之一(使用日期间隔)，明确禁止溢出。 - Sub one quarter to the instance (using date interval) with overflow explicitly forbidden.
 * @method        $this               addWeeks(int $value = 1)                                                             向实例添加周数(传入的$value计数)(使用日期间隔)。 - Add weeks (the $value count passed in) to the instance (using date interval).
 * @method        $this               addWeek()                                                                            向实例添加一周(使用日期间隔)。 - Add one week to the instance (using date interval).
 * @method        $this               subWeeks(int $value = 1)                                                             将周(传入的$value计数)分配给实例(使用日期间隔)。 - Sub weeks (the $value count passed in) to the instance (using date interval).
 * @method        $this               subWeek()                                                                            为实例添加一周(使用日期间隔)。 - Sub one week to the instance (using date interval).
 * @method        $this               addWeekdays(int $value = 1)                                                          向实例添加工作日(传入的$value计数)(使用日期间隔)。 - Add weekdays (the $value count passed in) to the instance (using date interval).
 * @method        $this               addWeekday()                                                                         向实例添加一个工作日(使用日期间隔)。 - Add one weekday to the instance (using date interval).
 * @method        $this               subWeekdays(int $value = 1)                                                          子工作日(传入的$value计数)到实例(使用日期间隔)。 - Sub weekdays (the $value count passed in) to the instance (using date interval).
 * @method        $this               subWeekday()                                                                         为实例添加一个工作日(使用日期间隔)。 - Sub one weekday to the instance (using date interval).
 * @method        $this               addRealMicros(int $value = 1)                                                        向实例添加微秒数(传入的$value计数)(使用时间戳)。 - Add microseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMicro()                                                                       向实例添加一微秒(使用时间戳)。 - Add one microsecond to the instance (using timestamp).
 * @method        $this               subRealMicros(int $value = 1)                                                        子微秒(传入的$value计数)到实例(使用时间戳)。 - Sub microseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMicro()                                                                       将实例缩短一微秒(使用时间戳)。 - Sub one microsecond to the instance (using timestamp).
 * @method        CarbonPeriod        microsUntil($endDate = null, int $factor = 1)                                        每微秒返回一个可迭代周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，如果给定了一个因子，则每X微秒返回一个可迭代周期。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each microsecond or every X microseconds if a factor is given.
 * @method        $this               addRealMicroseconds(int $value = 1)                                                  向实例添加微秒数(传入的$value计数)(使用时间戳)。 - Add microseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMicrosecond()                                                                 向实例添加一微秒(使用时间戳)。 - Add one microsecond to the instance (using timestamp).
 * @method        $this               subRealMicroseconds(int $value = 1)                                                  子微秒(传入的$value计数)到实例(使用时间戳)。 - Sub microseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMicrosecond()                                                                 将实例缩短一微秒(使用时间戳)。 - Sub one microsecond to the instance (using timestamp).
 * @method        CarbonPeriod        microsecondsUntil($endDate = null, int $factor = 1)                                  每微秒返回一个可迭代周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，如果给定了一个因子，则每X微秒返回一个可迭代周期。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each microsecond or every X microseconds if a factor is given.
 * @method        $this               addRealMillis(int $value = 1)                                                        向实例添加毫秒数(传入的$value计数)(使用时间戳)。 - Add milliseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMilli()                                                                       向实例添加1毫秒(使用时间戳)。 - Add one millisecond to the instance (using timestamp).
 * @method        $this               subRealMillis(int $value = 1)                                                        子毫秒(传入的$value计数)到实例(使用时间戳)。 - Sub milliseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMilli()                                                                       为实例添加1毫秒(使用时间戳)。 - Sub one millisecond to the instance (using timestamp).
 * @method        CarbonPeriod        millisUntil($endDate = null, int $factor = 1)                                        返回一个可迭代周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，周期为每毫秒，如果给定一个因子，则为每X毫秒。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each millisecond or every X milliseconds if a factor is given.
 * @method        $this               addRealMilliseconds(int $value = 1)                                                  向实例添加毫秒数(传入的$value计数)(使用时间戳)。 - Add milliseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMillisecond()                                                                 向实例添加1毫秒(使用时间戳)。 - Add one millisecond to the instance (using timestamp).
 * @method        $this               subRealMilliseconds(int $value = 1)                                                  子毫秒(传入的$value计数)到实例(使用时间戳)。 - Sub milliseconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMillisecond()                                                                 为实例添加1毫秒(使用时间戳)。 - Sub one millisecond to the instance (using timestamp).
 * @method        CarbonPeriod        millisecondsUntil($endDate = null, int $factor = 1)                                  返回一个可迭代周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，周期为每毫秒，如果给定一个因子，则为每X毫秒。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each millisecond or every X milliseconds if a factor is given.
 * @method        $this               addRealSeconds(int $value = 1)                                                       向实例添加秒数(传入的$value计数)(使用时间戳)。 - Add seconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealSecond()                                                                      向实例添加1秒(使用时间戳)。 - Add one second to the instance (using timestamp).
 * @method        $this               subRealSeconds(int $value = 1)                                                       子秒(传入的$value计数)到实例(使用时间戳)。 - Sub seconds (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealSecond()                                                                      给实例减去1秒(使用时间戳)。 - Sub one second to the instance (using timestamp).
 * @method        CarbonPeriod        secondsUntil($endDate = null, int $factor = 1)                                       返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，每秒一次，如果给定一个因子，则每X秒一次。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each second or every X seconds if a factor is given.
 * @method        $this               addRealMinutes(int $value = 1)                                                       向实例添加分钟数(传入的$value计数)(使用时间戳)。 - Add minutes (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMinute()                                                                      向实例添加一分钟(使用时间戳)。 - Add one minute to the instance (using timestamp).
 * @method        $this               subRealMinutes(int $value = 1)                                                       分分钟(传入的$value计数)到实例(使用时间戳)。 - Sub minutes (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMinute()                                                                      给实例减去一分钟(使用时间戳)。 - Sub one minute to the instance (using timestamp).
 * @method        CarbonPeriod        minutesUntil($endDate = null, int $factor = 1)                                       如果给定了一个因子，则为每分钟或每X分钟返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each minute or every X minutes if a factor is given.
 * @method        $this               addRealHours(int $value = 1)                                                         向实例添加小时数(传入的$value计数)(使用时间戳)。 - Add hours (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealHour()                                                                        向实例添加一个小时(使用时间戳)。 - Add one hour to the instance (using timestamp).
 * @method        $this               subRealHours(int $value = 1)                                                         子小时数(传入的$value计数)到实例(使用时间戳)。 - Sub hours (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealHour()                                                                        为实例减去一个小时(使用时间戳)。 - Sub one hour to the instance (using timestamp).
 * @method        CarbonPeriod        hoursUntil($endDate = null, int $factor = 1)                                         如果给定一个因子，则为每小时或每X小时返回从当前日期到给定结束(字符串、DateTime或Carbon实例)的可迭代周期。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each hour or every X hours if a factor is given.
 * @method        $this               addRealDays(int $value = 1)                                                          向实例添加天数(传入的$value计数)(使用时间戳)。 - Add days (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealDay()                                                                         向实例添加一天(使用时间戳)。 - Add one day to the instance (using timestamp).
 * @method        $this               subRealDays(int $value = 1)                                                          子天(传入的$value计数)到实例(使用时间戳)。 - Sub days (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealDay()                                                                         为实例添加一天(使用时间戳)。 - Sub one day to the instance (using timestamp).
 * @method        CarbonPeriod        daysUntil($endDate = null, int $factor = 1)                                          返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，对于每天或每X天(如果给定了一个因子)。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each day or every X days if a factor is given.
 * @method        $this               addRealWeeks(int $value = 1)                                                         向实例添加周数(传入的$value计数)(使用时间戳)。 - Add weeks (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealWeek()                                                                        向实例添加一周(使用时间戳)。 - Add one week to the instance (using timestamp).
 * @method        $this               subRealWeeks(int $value = 1)                                                         将周(传入的$value计数)分配给实例(使用时间戳)。 - Sub weeks (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealWeek()                                                                        为实例添加一个星期(使用时间戳)。 - Sub one week to the instance (using timestamp).
 * @method        CarbonPeriod        weeksUntil($endDate = null, int $factor = 1)                                         返回一个可迭代的周期，从当前日期到给定的结束(字符串，DateTime或Carbon实例)，对于每个星期，或者如果给定一个因子，则每X周。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each week or every X weeks if a factor is given.
 * @method        $this               addRealMonths(int $value = 1)                                                        向实例添加月份(传入的$value计数)(使用时间戳)。 - Add months (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMonth()                                                                       向实例添加一个月(使用时间戳)。 - Add one month to the instance (using timestamp).
 * @method        $this               subRealMonths(int $value = 1)                                                        子月份(传入的$value计数)到实例(使用时间戳)。 - Sub months (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMonth()                                                                       为实例添加一个月(使用时间戳)。 - Sub one month to the instance (using timestamp).
 * @method        CarbonPeriod        monthsUntil($endDate = null, int $factor = 1)                                        如果给定了一个因子，则为每个月或每X个月返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each month or every X months if a factor is given.
 * @method        $this               addRealQuarters(int $value = 1)                                                      向实例添加四分之一(传入的$value计数)(使用时间戳)。 - Add quarters (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealQuarter()                                                                     向实例添加1 / 4(使用时间戳)。 - Add one quarter to the instance (using timestamp).
 * @method        $this               subRealQuarters(int $value = 1)                                                      子季度(传入的$value计数)到实例(使用时间戳)。 - Sub quarters (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealQuarter()                                                                     将四分之一添加到实例中(使用时间戳)。 - Sub one quarter to the instance (using timestamp).
 * @method        CarbonPeriod        quartersUntil($endDate = null, int $factor = 1)                                      如果给定了一个因子，则为每个季度或每X个季度返回从当前日期到给定结束(字符串、DateTime或Carbon实例)的可迭代周期。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each quarter or every X quarters if a factor is given.
 * @method        $this               addRealYears(int $value = 1)                                                         向实例添加年数(传入的$value计数)(使用时间戳)。 - Add years (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealYear()                                                                        向实例添加一年(使用时间戳)。 - Add one year to the instance (using timestamp).
 * @method        $this               subRealYears(int $value = 1)                                                         子年(传入的$value计数)到实例(使用时间戳)。 - Sub years (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealYear()                                                                        为实例添加一年(使用时间戳)。 - Sub one year to the instance (using timestamp).
 * @method        CarbonPeriod        yearsUntil($endDate = null, int $factor = 1)                                         返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，为每年，如果给定了一个因子，则为每X年。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each year or every X years if a factor is given.
 * @method        $this               addRealDecades(int $value = 1)                                                       向实例添加几十年(传入的$value计数)(使用时间戳)。 - Add decades (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealDecade()                                                                      向实例添加一个十年(使用时间戳)。 - Add one decade to the instance (using timestamp).
 * @method        $this               subRealDecades(int $value = 1)                                                       子几十年(传入的$value计数)到实例(使用时间戳)。 - Sub decades (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealDecade()                                                                      向实例添加一个十年(使用时间戳)。 - Sub one decade to the instance (using timestamp).
 * @method        CarbonPeriod        decadesUntil($endDate = null, int $factor = 1)                                       返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，周期为每十年，如果给定一个因子，则为每X十年。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each decade or every X decades if a factor is given.
 * @method        $this               addRealCenturies(int $value = 1)                                                     向实例添加世纪数(传入的$value计数)(使用时间戳)。 - Add centuries (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealCentury()                                                                     向实例添加一个世纪(使用时间戳)。 - Add one century to the instance (using timestamp).
 * @method        $this               subRealCenturies(int $value = 1)                                                     子世纪(传入的$value计数)到实例(使用时间戳)。 - Sub centuries (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealCentury()                                                                     为实例添加一个世纪(使用时间戳)。 - Sub one century to the instance (using timestamp).
 * @method        CarbonPeriod        centuriesUntil($endDate = null, int $factor = 1)                                     返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，对应每个世纪，如果给定一个因子，则对应每X个世纪。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each century or every X centuries if a factor is given.
 * @method        $this               addRealMillennia(int $value = 1)                                                     向实例添加千年(传入的$value计数)(使用时间戳)。 - Add millennia (the $value count passed in) to the instance (using timestamp).
 * @method        $this               addRealMillennium()                                                                  向实例添加一个千禧年(使用时间戳)。 - Add one millennium to the instance (using timestamp).
 * @method        $this               subRealMillennia(int $value = 1)                                                     次千年(传入的$value计数)到实例(使用时间戳)。 - Sub millennia (the $value count passed in) to the instance (using timestamp).
 * @method        $this               subRealMillennium()                                                                  为实例添加一个千年(使用时间戳)。 - Sub one millennium to the instance (using timestamp).
 * @method        CarbonPeriod        millenniaUntil($endDate = null, int $factor = 1)                                     返回一个可迭代的周期，从当前日期到给定的结束(字符串、DateTime或Carbon实例)，对于每千禧年，或者如果给定了一个因子，则每X千禧年。 - Return an iterable period from current date to given end (string, DateTime or Carbon instance) for each millennium or every X millennia if a factor is given.
 * @method        $this               roundYear(float $precision = 1, string $function = "round")                          使用给定函数以给定精度舍入当前实例年份 - Round the current instance year with given precision using the given function.
 * @method        $this               roundYears(float $precision = 1, string $function = "round")                         使用给定函数以给定精度舍入当前实例年份。 - Round the current instance year with given precision using the given function.
 * @method        $this               floorYear(float $precision = 1)                                                      以给定的精度截断当前实例年份。 - Truncate the current instance year with given precision.
 * @method        $this               floorYears(float $precision = 1)                                                     以给定的精度截断当前实例年份。 - Truncate the current instance year with given precision.
 * @method        $this               ceilYear(float $precision = 1)                                                       以给定的精度指定当前实例年份。 - Ceil the current instance year with given precision.
 * @method        $this               ceilYears(float $precision = 1)                                                      以给定的精度指定当前实例年份。 - Ceil the current instance year with given precision.
 * @method        $this               roundMonth(float $precision = 1, string $function = "round")                         使用给定函数以给定精度舍入当前实例月份。 - Round the current instance month with given precision using the given function.
 * @method        $this               roundMonths(float $precision = 1, string $function = "round")                        使用给定函数以给定精度舍入当前实例月份。 - Round the current instance month with given precision using the given function.
 * @method        $this               floorMonth(float $precision = 1)                                                     以给定的精度截断当前实例月份。 - Truncate the current instance month with given precision.
 * @method        $this               floorMonths(float $precision = 1)                                                    以给定的精度截断当前实例月份。 - Truncate the current instance month with given precision.
 * @method        $this               ceilMonth(float $precision = 1)                                                      以给定的精度指定当前实例月份。 - Ceil the current instance month with given precision.
 * @method        $this               ceilMonths(float $precision = 1)                                                     以给定的精度指定当前实例月份。 - Ceil the current instance month with given precision.
 * @method        $this               roundDay(float $precision = 1, string $function = "round")                           使用给定函数以给定精度舍入当前实例日。 - Round the current instance day with given precision using the given function.
 * @method        $this               roundDays(float $precision = 1, string $function = "round")                          使用给定函数以给定精度舍入当前实例日。  -  Round the current instance day with given precision using the given function.
 * @method        $this               floorDay(float $precision = 1)                                                       以给定的精度截断当前实例日。 - Truncate the current instance day with given precision.
 * @method        $this               floorDays(float $precision = 1)                                                      以给定的精度截断当前实例日。 - Truncate the current instance day with given precision.
 * @method        $this               ceilDay(float $precision = 1)                                                        以给定的精度指定当前实例日。 - Ceil the current instance day with given precision.
 * @method        $this               ceilDays(float $precision = 1)                                                       以给定的精度指定当前实例日。 - Ceil the current instance day with given precision.
 * @method        $this               roundHour(float $precision = 1, string $function = "round")                          使用给定函数以给定精度四舍五入当前实例小时。 - Round the current instance hour with given precision using the given function.
 * @method        $this               roundHours(float $precision = 1, string $function = "round")                         使用给定函数以给定精度四舍五入当前实例小时。 - Round the current instance hour with given precision using the given function.
 * @method        $this               floorHour(float $precision = 1)                                                      以给定精度截断当前实例小时。 - Truncate the current instance hour with given precision.
 * @method        $this               floorHours(float $precision = 1)                                                     以给定精度截断当前实例小时。 - Truncate the current instance hour with given precision.
 * @method        $this               ceilHour(float $precision = 1)                                                       以给定的精度指定当前实例小时。 - Ceil the current instance hour with given precision.
 * @method        $this               ceilHours(float $precision = 1)                                                      以给定的精度指定当前实例小时。 - Ceil the current instance hour with given precision.
 * @method        $this               roundMinute(float $precision = 1, string $function = "round")                        使用给定函数以给定精度舍入当前实例分钟。 - Round the current instance minute with given precision using the given function.
 * @method        $this               roundMinutes(float $precision = 1, string $function = "round")                       使用给定函数以给定精度舍入当前实例分钟。 - Round the current instance minute with given precision using the given function.
 * @method        $this               floorMinute(float $precision = 1)                                                    以给定的精度截断当前实例分钟。 - Truncate the current instance minute with given precision.
 * @method        $this               floorMinutes(float $precision = 1)                                                   以给定的精度截断当前实例分钟。 - Truncate the current instance minute with given precision.
 * @method        $this               ceilMinute(float $precision = 1)                                                     以给定的精度计算当前实例分钟。 - Ceil the current instance minute with given precision.
 * @method        $this               ceilMinutes(float $precision = 1)                                                    以给定的精度计算当前实例分钟。 - Ceil the current instance minute with given precision.
 * @method        $this               roundSecond(float $precision = 1, string $function = "round")                        使用给定函数以给定精度舍入当前实例秒。 - Round the current instance second with given precision using the given function.
 * @method        $this               roundSeconds(float $precision = 1, string $function = "round")                       使用给定函数以给定精度舍入当前实例秒。 - Round the current instance second with given precision using the given function.
 * @method        $this               floorSecond(float $precision = 1)                                                    以给定的精度截断当前实例秒。 - Truncate the current instance second with given precision.
 * @method        $this               floorSeconds(float $precision = 1)                                                   以给定的精度截断当前实例秒。 - Truncate the current instance second with given precision.
 * @method        $this               ceilSecond(float $precision = 1)                                                     以给定的精度将当前实例延迟。 - Ceil the current instance second with given precision.
 * @method        $this               ceilSeconds(float $precision = 1)                                                    以给定的精度将当前实例延迟。 - Ceil the current instance second with given precision.
 * @method        $this               roundMillennium(float $precision = 1, string $function = "round")                    使用给定函数以给定精度舍入当前实例千禧年。 - Round the current instance millennium with given precision using the given function.
 * @method        $this               roundMillennia(float $precision = 1, string $function = "round")                     使用给定函数以给定精度舍入当前实例千禧年。 - Round the current instance millennium with given precision using the given function.
 * @method        $this               floorMillennium(float $precision = 1)                                                以给定精度截断当前实例千禧年。 - Truncate the current instance millennium with given precision.
 * @method        $this               floorMillennia(float $precision = 1)                                                 以给定精度截断当前实例千禧年。 - Truncate the current instance millennium with given precision.
 * @method        $this               ceilMillennium(float $precision = 1)                                                 以给定的精度对当前实例进行千禧年计数。 - Ceil the current instance millennium with given precision.
 * @method        $this               ceilMillennia(float $precision = 1)                                                  以给定的精度对当前实例进行千禧年计数。 - Ceil the current instance millennium with given precision.
 * @method        $this               roundCentury(float $precision = 1, string $function = "round")                       使用给定函数以给定精度舍入当前实例世纪。 - Round the current instance century with given precision using the given function.
 * @method        $this               roundCenturies(float $precision = 1, string $function = "round")                     使用给定函数以给定精度舍入当前实例世纪。 - Round the current instance century with given precision using the given function.
 * @method        $this               floorCentury(float $precision = 1)                                                   以给定的精度截断当前实例世纪。 - Truncate the current instance century with given precision.
 * @method        $this               floorCenturies(float $precision = 1)                                                 以给定的精度截断当前实例世纪。 - Truncate the current instance century with given precision.
 * @method        $this               ceilCentury(float $precision = 1)                                                    以给定的精度计算当前实例的世纪值。 - Ceil the current instance century with given precision.
 * @method        $this               ceilCenturies(float $precision = 1)                                                  以给定的精度计算当前实例的世纪值。 - Ceil the current instance century with given precision.
 * @method        $this               roundDecade(float $precision = 1, string $function = "round")                        使用给定函数以给定精度舍入当前实例的十年。 - Round the current instance decade with given precision using the given function.
 * @method        $this               roundDecades(float $precision = 1, string $function = "round")                       使用给定函数以给定精度舍入当前实例的十年。 - Round the current instance decade with given precision using the given function.
 * @method        $this               floorDecade(float $precision = 1)                                                    以给定的精度截断当前实例的十年。 - Truncate the current instance decade with given precision.
 * @method        $this               floorDecades(float $precision = 1)                                                   以给定的精度截断当前实例的十年。 - Truncate the current instance decade with given precision.
 * @method        $this               ceilDecade(float $precision = 1)                                                     以给定的精度计算当前实例的十年。 - Ceil the current instance decade with given precision.
 * @method        $this               ceilDecades(float $precision = 1)                                                    以给定的精度计算当前实例的十年。 - Ceil the current instance decade with given precision.
 * @method        $this               roundQuarter(float $precision = 1, string $function = "round")                       使用给定函数以给定精度舍入当前实例的四分之一。 - Round the current instance quarter with given precision using the given function.
 * @method        $this               roundQuarters(float $precision = 1, string $function = "round")                      使用给定函数以给定精度舍入当前实例的四分之一。 - Round the current instance quarter with given precision using the given function.
 * @method        $this               floorQuarter(float $precision = 1)                                                   以给定精度截断当前实例的四分之一。 - Truncate the current instance quarter with given precision.
 * @method        $this               floorQuarters(float $precision = 1)                                                  以给定精度截断当前实例的四分之一。 - Truncate the current instance quarter with given precision.
 * @method        $this               ceilQuarter(float $precision = 1)                                                    以给定的精度计算当前实例的四分之一。 - Ceil the current instance quarter with given precision.
 * @method        $this               ceilQuarters(float $precision = 1)                                                   以给定的精度计算当前实例的四分之一。 - Ceil the current instance quarter with given precision.
 * @method        $this               roundMillisecond(float $precision = 1, string $function = "round")                   使用给定函数以给定精度舍入当前实例毫秒数。 - Round the current instance millisecond with given precision using the given function.
 * @method        $this               roundMilliseconds(float $precision = 1, string $function = "round")                  使用给定函数以给定精度舍入当前实例毫秒数。 - Round the current instance millisecond with given precision using the given function.
 * @method        $this               floorMillisecond(float $precision = 1)                                               以给定精度截断当前实例毫秒数。 - Truncate the current instance millisecond with given precision.
 * @method        $this               floorMilliseconds(float $precision = 1)                                              以给定精度截断当前实例毫秒数。 - Truncate the current instance millisecond with given precision.
 * @method        $this               ceilMillisecond(float $precision = 1)                                                以给定的精度计算当前实例毫秒数。 - Ceil the current instance millisecond with given precision.
 * @method        $this               ceilMilliseconds(float $precision = 1)                                               以给定的精度计算当前实例毫秒数。 - Ceil the current instance millisecond with given precision.
 * @method        $this               roundMicrosecond(float $precision = 1, string $function = "round")                   使用给定函数以给定精度舍入当前实例微秒。 - Round the current instance microsecond with given precision using the given function.
 * @method        $this               roundMicroseconds(float $precision = 1, string $function = "round")                  使用给定函数以给定精度舍入当前实例微秒。 - Round the current instance microsecond with given precision using the given function.
 * @method        $this               floorMicrosecond(float $precision = 1)                                               以给定精度截断当前实例微秒。 - Truncate the current instance microsecond with given precision.
 * @method        $this               floorMicroseconds(float $precision = 1)                                              以给定精度截断当前实例微秒。 - Truncate the current instance microsecond with given precision.
 * @method        $this               ceilMicrosecond(float $precision = 1)                                                以给定精度计算当前实例的微秒数。 - Ceil the current instance microsecond with given precision.
 * @method        $this               ceilMicroseconds(float $precision = 1)                                               以给定精度计算当前实例的微秒数。 - Ceil the current instance microsecond with given precision.
 * @method        string              shortAbsoluteDiffForHumans(DateTimeInterface $other = null, int $parts = 1)          获取当前语言环境中人类可读格式的差异(短格式，'Absolute'模式)。($other和$parts参数可以互换。) - Get the difference (short format, 'Absolute' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              longAbsoluteDiffForHumans(DateTimeInterface $other = null, int $parts = 1)           获取当前语言环境中人类可读格式的差异(长格式，'Absolute'模式)。($other和$parts参数可以互换。) - Get the difference (long format, 'Absolute' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              shortRelativeDiffForHumans(DateTimeInterface $other = null, int $parts = 1)          获取当前语言环境中人类可读格式的差异(短格式，'相对'模式)。($other和$parts参数可以互换。) - Get the difference (short format, 'Relative' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              longRelativeDiffForHumans(DateTimeInterface $other = null, int $parts = 1)           获取当前语言环境中人类可读格式的差异(长格式，'相对'模式)。($other和$parts参数可以互换。) - Get the difference (long format, 'Relative' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              shortRelativeToNowDiffForHumans(DateTimeInterface $other = null, int $parts = 1)     在当前语言环境中以人类可读的格式获取差异(短格式，'RelativeToNow'模式)。($other和$parts参数可以互换。) - Get the difference (short format, 'RelativeToNow' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              longRelativeToNowDiffForHumans(DateTimeInterface $other = null, int $parts = 1)      在当前语言环境中以人类可读的格式获取差异(长格式，'RelativeToNow'模式)。($other和$parts参数可以互换。) - Get the difference (long format, 'RelativeToNow' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              shortRelativeToOtherDiffForHumans(DateTimeInterface $other = null, int $parts = 1)   获取当前语言环境中人类可读格式的差异(短格式，'RelativeToOther'模式)。($other和$parts参数可以互换。) - Get the difference (short format, 'RelativeToOther' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        string              longRelativeToOtherDiffForHumans(DateTimeInterface $other = null, int $parts = 1)    在当前语言环境中以人类可读的格式获取差异(长格式，'RelativeToOther'模式)。($other和$parts参数可以互换。) - Get the difference (long format, 'RelativeToOther' mode) in a human readable format in the current locale. ($other and $parts parameters can be swapped.)
 * @method        static Carbon|false createFromFormat(string $format, string $time, string|DateTimeZone $timezone = null) P根据指定的格式将字符串解析为新的Carbon对象。 - arse a string into a new Carbon object according to the specified format.
 * @method        static Carbon       __set_state(array $array)                                                            https://php.net/manual/en/datetime.set-state.php

```

