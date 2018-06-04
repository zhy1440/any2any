$#end::
$!end::
    send {home}+{end}Password123{!}
    return 

#space::Run www.google.com

#z::
Run, Notepad, , max
Run, Notepad, , min
return

::btw::by the way

:*:]d::  ; 此热字串通过后面的命令把 "]d" 替换成当前日期和时间.
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; 看起来会像 9/1/2005 3:53 PM 这样
SendInput %CurrentDateTime%
return

^!s::
Send Sincerely,{enter}John Smith  ; 此行发送键击到活动 (最前面的) 窗口.
return


; 快速输入魔兽争霸III秘籍
; Tsybius2014 2016/04/23

; 魔兽争霸III秘籍（混乱之治 & 冰封王座）
resx = greedisgood 1000000     ;加1000000单位金钱和木材
money = keysersoze 1000000     ;加1000000单位金钱
wood = leafittome 1000000      ;加1000000单位木材
power = whosyourdaddy          ;神话模式
radar = iseedeadpeople         ;地图全开
magic = thereisnospoon         ;法力无限
food = pointbreak              ;人口无限（最高100）
fast = warpten                 ;快速建造
win = allyourbasearebelongtous ;快速胜利
lose = somebodysetupusthebomb  ;快速失败

; #IfWinActive Warcraft III
  ; 常规缩写
  ::resx::greedisgood 1000000
  ::money::keysersoze 1000000
  ::wood::leafittome 1000000
  ::power::whosyourdaddy
  ::radar::iseedeadpeople
  ::magic::thereisnospoon
  ::food::pointbreak
  ::fast::warpten
  ::win::allyourbasearebelongtous
  ::lose::somebodysetupusthebomb
  ; 组合输入 - 开局适用
  ^t::
    Send, {enter}%resx%{space}{enter}
    Send, {enter}%power%{space}{enter}
    Send, {enter}%radar%{space}{enter}
    Send, {enter}%magic%{space}{enter}
    Send, {enter}%food%{space}{enter}
    Send, {enter}%fast%{space}{enter}
  Return
; #IfWinActive

/***********************************************
*军团TD
*********************************************** 
*/

;=======================================================
;调整窗口尺寸
!1::
Send  {enter}-zoom -180{enter}
return