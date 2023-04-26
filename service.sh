#!/system/bin/sh
MODDIR=${0%/*}

System_Activation()
{
	local wait_start=0
	until [[ $(getprop sys.boot_completed) -eq 1 ]]; do
		local wait_start=$((${wait_start} + 1))
		[[ ${wait_start} -ge 150 ]] && exit 1
		sleep 2
	done
}
System_Activation

sdcard_rw()
{
	local test_file="/sdcard/Android/.ALIST_ENCRYPT_TEST_FILE"
	touch $test_file
	while [[ ! -f $test_file ]]; do
		touch $test_file
		sleep 1
	done
	rm $test_file
}
sdcard_rw


chmod 777 $MODDIR/bin/node_alist
cd $MODDIR/lib
ln -s $MODDIR/lib/libicudata.so.73  $MODDIR/lib/libicudata.so
ln -s $MODDIR/lib/libicudata.so.73  $MODDIR/lib/libicudata.so.73.1
ln -s $MODDIR/lib/libicui18n.so.73  $MODDIR/lib/libicui18n.so
ln -s $MODDIR/lib/libicui18n.so.73  $MODDIR/lib/libicui18n.so.73.1
ln -s $MODDIR/lib/libicutu.so.73  $MODDIR/lib/libicutu.so
ln -s $MODDIR/lib/libicutu.so.73  $MODDIR/lib/libicutu.so.73.1
ln -s $MODDIR/lib/libssl.so.3  $MODDIR/lib/libssl.so
ln -s $MODDIR/lib/libz.so.1  $MODDIR/lib/libz.so
ln -s $MODDIR/lib/libz.so.1  $MODDIR/lib/libz.so.1.2.13
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MODDIR/lib


OLD_CONF=/data/adb/modules/Alist-Encrypt-Switch/conf/config.json
if [ -e $OLD_CONF ];then
cp -R /data/adb/modules/Alist-Encrypt-Switch/conf/* /data/adb/modules/Alist-Encrypt/dist/conf/
fi

while true;
do

    PROCESS=$(ps -ef | grep alist_encrypt.js | grep -v grep | wc -l)
    MODXINXI="$MODDIR/module.prop"
    if [[ -e /data/adb/modules/Alist-Encrypt-Switch/disable ]]; then
        if [[ $PROCESS != 0 ]]; then
            killall node_alist
            sed -i "/^description=/c description=当前运行状态: Stopping 已停止" "$MODXINXI"

        fi
    else
        if [[ $PROCESS == 0 ]]; then
            cd $MODDIR/dist
            $MODDIR/bin/node_alist alist_encrypt.js&
            sed -i "/^description=/c description=当前运行状态: Running 运行中" "$MODXINXI"
        else
            sed -i "/^description=/c description=当前运行状态: Running 运行中" "$MODXINXI"
        fi
    fi
    sleep 5
done