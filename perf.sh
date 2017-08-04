#!/bin/bash
LANG=zh_CN.UTF-8

#做一些初始化
if [ ! -d "/mnt/perf_log" ]; then
  mkdir /mnt/perf_log
fi

if [ ! -d "/mnt/perf_report" ]; then
  mkdir /mnt/perf_report
fi

#echo "请输入您想测试的模块(nova/keystone/neutron/ceph): "
module=$1
_date=`date +"%Y%m%d%H%M"`
#touch /mnt/perf_log/$_date.log ---不需要了
function run(){       #---定义函数，运行脚本和生成报告
     start_time=$(date +%s)
     echo "~~~~开始执行测试，请耐心等待~~~~"
     rm -rf /mnt/perf_log/$1_$_date.log  #清空日志，避免影响
     DIR=`find /mnt/perf_scripts/$1/ -name "*.json"`
     for i in $DIR
     do
       rally task start --task $i >> /mnt/perf_log/$1_$_date.log 2>&1
     done
     awk '$3=="report"&&!a[$4]++{print $4}' /mnt/perf_log/$1_$_date.log > key_col.id
     rep_id=`awk BEGIN{RS=EOF}'{gsub(/\n/," ");print}' key_col.id`
     #echo $rep_id
     rally task report --tasks $rep_id --out /mnt/perf_report/$1_$_date.html
     end_time=$(date +%s)
     echo "测试完成，本次测试用时 $(($end_time-$start_time))s；详情见报告：/mnt/perf_report/$1_$_date.html"
     echo "请输入您想测试的模块(nova/keystone/neutron/ceph)，如想退出请输入（quit/exit）"
}
  case $1 in
    nova)
    run nova
  ;;
    keystone)
    run keystone
  ;;
    neutron)
    run neutron
  ;;
    ceph)
    run ceph
  ;;
    quit|exit)
     break
  ;;
    *)
     echo -e "输入有误，请重新输入: "
  esac
