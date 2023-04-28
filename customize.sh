#!/system/bin/sh
MODDIR=${0%/*}
ui_print " -------------------------- "
ui_print " ------ 安装中，请稍等 ------ "

OLD_CONF=/data/adb/modules/Alist-Encrypt/dist/conf/config.json
if [ -e $OLD_CONF ];then
ui_print "检测到本地已存在一份配置文件，是否备份？
—————————————————————————————————————
 - 按音量键＋: 备份
 - 按音量键－: 不备份
—————————————————————————————————————"
while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "${choose}" in 
    KEY_VOLUMEUP)
        rm -rf /data/adb/modules/Alist-Encrypt-Switch/conf
        mkdir /data/adb/modules/Alist-Encrypt-Switch/conf
        cp -R /data/adb/modules/Alist-Encrypt/dist/conf/* /data/adb/modules/Alist-Encrypt-Switch/conf/
        ui_print "备份配置成功，已备份到/data/adb/modules/Alist-Encrypt-Switch/conf/"
        ui_print "重启后将自动还原配置~"
        ;;
    KEY_VOLUMEDOWN)
        ui_print "未备份"
        ;;
    *)
        sleep 1
        continue 
        ;;
    esac
    break
done
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
