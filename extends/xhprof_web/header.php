<?php
/**
 * Created by PhpStorm.
 * User: show
 * Date: 2018/3/23
 * Time: 12:28
 */
//xh_debug 启用xhprof调试
$xhprof_path = dirname(__FILE__);
//访问调试的绑定地址
$xhprof_url = "http://xhprof.c6t.cn";

$xh_debug_file = file_get_contents($xhprof_path."/data.txt");

if($xh_debug_file==1)
{
    $xh_debug = true;
}
if(isset($_REQUEST['xh_debug'])){
    if($_REQUEST['xh_debug']=='1'){
        $xh_debug=true;
    } elseif($_REQUEST['xhprof']=='0'){
        $xh_debug=false;
    }
}
if(isset($_REQUEST['xh_setting']))
{
    $xh_setting = intval($_REQUEST['xh_setting']);
    file_put_contents($xhprof_path."/data.txt",$xh_setting);
    echo "设置成功!!!";
}
if(isset($_REQUEST['setting']))
{
    echo "是否强制开启xhprof";
    echo "<a href='{$xhprof_url}/header.php?xh_setting=1'>是</a>&nbsp;<a href='{$xhprof_url}/header.php?xh_setting=0'>否</a>";
}

$isExecuteXhprof = false;
if(function_exists("xhprof_enable"))
{
    xhprof_enable();
    $isExecuteXhprof = true;
}

