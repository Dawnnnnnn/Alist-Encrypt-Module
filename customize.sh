#!/system/bin/sh
MODDIR=${0%/*}
ui_print " -------------------------- "
ui_print " ------ 安装中，请稍等 ------ "

OLD_CONF=/data/local/tmp/Alist-Encrypt-conf/config.json
if [ -e $OLD_CONF ];then
ui_print "检测到本地已存在一份备份配置文件，默认恢复"
cp -R /data/local/tmp/Alist-Encrypt-conf/ /data/adb/modules/Alist-Encrypt/dist/conf/
ui_print "备份恢复成功"
fi

ui_print "通过开启/禁用附属模块`Alist-Encrypt开关[Switch]`来控制加密组件的开关"

ui_print "
请使用浏览器访问 
http://127.0.0.1:5344/public/index.html 
或
http://127.0.0.1:5344/index
默认账户 admin 密码 123456"

ui_print " ----- 安装已完成，请重启 ---- "
ui_print " -------------------------- "
