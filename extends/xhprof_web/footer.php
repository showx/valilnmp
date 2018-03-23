<?php
/**
 * Created by PhpStorm.
 * User: show
 * Date: 2018/3/23
 * Time: 12:28
 */

if($isExecuteXhprof && $xh_debug==true ){
    $xhprof_data = xhprof_disable();
    
    include_once $xhprof_path . "/xhprof_lib/utils/xhprof_lib.php";
    include_once $xhprof_path . "/xhprof_lib/utils/xhprof_runs.php";
    
    $xhprof_runs = new XHProfRuns_Default();
    $run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_foo");
    
    echo '<br /><a id="xhprof_result_link" href="'.$xhprof_url.'/xhprof_html/index.php?run='.$run_id.'&source=xhprof_foo" target="_blank">xhprof</a>';
}