# rally_autotest
A shell script to run rally performance test auto

To run this script,you shold do things before:

1.copy the rally test script in dir /mnt/perf_scripts

2.run the script like this: nohup ./perf.sh nova &

3.check your report in : /mnt/perf_report/


#添加中文说明:
使用脚本前,请做一下工作:

1.将想要测试的rally脚本复制到目录如:/mnt/perf_scripts/nova

2.运行脚本:nohup ./perf.sh nova & 这样做主要是避免由于终端断开造成rllay停止

3.查看报告,报告会按照模块+日期生成,在目录:/mnt/perf_report中
