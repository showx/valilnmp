<?php
error_reporting(0);
/**
 * c/s监控引用接口
 * Author:show
 * version 2.0
 * 检查文件夹是否可写
 * 服务连接是否正常
 */
//【配置项】
//使用超全局变量不怕，单页不怕bug

//========服务有多个，继续添加数组即可=====

//mysql 从库往下添加array即可
$GLOBALS['config_mysql'] = array(
    //mysql 主
    array(
        "host"=>"127.0.0.1",
        "user"=>"root",
        "pass"=>"root",
    ),
    
);
//memecache
$GLOBALS['config_memcache'] = array(
    array(
        "host"=>"127.0.0.1",
    ),
);
//redis
$GLOBALS['config_redis'] = array(
    array(
        "host"=>"127.0.0.1",
    ),
);
//mongodb
$GLOBALS['config_mongodb'] = array(
    array(
        "host"=>"127.0.0.1",
        "user"=>"",
        "pass"=>"",
    ),
);

//要检查的文件夹,相对项目的文件夹
$write_folder_config = array(
    "/bone/data/",
    "/bone/data/cache/",
);
//============end 配置==========

//=================【wraning】要检查的项,开启请设置为1 不检测请设置为0
$_env_radio = array(
    //filecache一般有权限就无问题
    
    "folder"=>1,  
    "mysql"=>1,
    "memcache"=>0,
    "mongodb"=>0,
    "redis"=>0,
);
class detection{
    private $path = '';
    private $msg = "ok";
    //要检查的文件夹
    public $write_folder_config = array();
    //错误变量
    public $err = array();
    protected $ext = array();
    //各服务端口
    public $mysql_port = 3306;
    public $memcache_port = 11211;
    public $redis_port = 6379;
    public $mongodb_port = 27017;

    public function __construct($config='',$write_folder='')
    {
        //没配置就是不用检查 
        if(empty($config))
        {
            die($this->msg);
        }
        $this->path = dirname(__FILE__);
        $this->_env_radio = $config;
        $this->write_folder_config = $write_folder;
        $this->ip = $_SERVER['SERVER_ADDR'];
        $this->ext = get_loaded_extensions();
    }
    /**
     * 查看info
     */
    public function info()
    {
        phpinfo();
        exit();
    }
    /**
     * 检查指定文件夹
     */
    public function check_folder()
    {
        if($this->write_folder_config)
        {
            foreach($this->write_folder_config as $folder)
            {
                $path = $this->path.$folder; 
                if(!is_writeable($path))
                {
                    return "folder :".$folder." is not writeable";
                } 
            }
        }    
        return '';
    }
    /**
     * 检查mysql
     * php新版本统一使用mysqli
     */
    public function check_mysql()
    {
        $err = '';
        if(function_exists("mysqli_connect"))
        {
            foreach($GLOBALS['config_mysql'] as $num=>$val)
            {
                $conn = mysqli_connect($val['host'], $val['user'], $val['pass'],"",$this->mysql_port);
                if($conn == false)
                {
                    $err.= "mysql connect err!(".$val['host']."|".$val['user']."|".$this->mysql_port.")".PHP_EOL;
                }
            }
        }
        return $err;
    }
    /**
     * 检查memcache
     * 只检查本机
     */
    public function check_memcache()
    {
        $err = '';
        if(function_exists("memcache_connect"))
        {
            foreach($GLOBALS['config_memcache'] as $num=>$val)
            {
                $memcache_obj = memcache_connect($val['host'], $this->memcache_port);
                if($memcache_obj == false)
                {
                    $err .= "memcache connect err! (".$val['host'].":{$this->memcache_port})".PHP_EOL; 
                }
            }
        }
        return $err;
    }
    /**
     * 检查mongodb
     * 扩展有两种
     * @todo mongodb判断需优化
     */
    public function check_mongodb()
    {
        $err = $class = ''; 
        if(class_exists("MongoClient"))
        { 
            $class = "MongoClient"; 
        }elseif(class_exists("Mongo"))
        {
            $class = "Mongo";
        }elseif(class_exists("MongoDB\Driver\Manager"))
        {
            $class = "MongoDB\Driver\Manager";
        }
        if($class)
        {
            foreach($GLOBALS['config_mongodb'] as $num=>$val)
            {
                if($val['user'])
                {
                    $user = $val['user'].":".$val['pass']."@";
                }else{
                    $user = "";
                }
                $str = "mongodb://".$user.$val['host'].":{$this->mongodb_port}";
                $conn = new $class($str); 
                if(!$conn)
                {
                    $err .= "mongodb connect err! (".$val['host'].":{$this->mongodb_port})".PHP_EOL; 
                }
            }
        }
        return $err;
    }
    /**
     * 检查redis
     * 使用扩展或predis
     * 这个检测，不支持predis
     */
    public function check_redis()
    {
        $err = '';
        foreach($GLOBALS['config_redis'] as $num=>$val)
        {
            $redis = new redis();  
            $result = $redis->connect($val['host'], $this->redis_port);  
            if(!$result)
            {
                $err .= "redis connect err! (".$val['host'].":{$this->redis_port})"; 
            }
        }
        return $err;
    }
    /*
     * 运行
     */
    public function run()
    {
        foreach($this->_env_radio as $serve=>$examine)
        {
            if($examine == '0')
            {
                continue;
            }
            $exe_fun = "check_{$serve}";
            $tmp = $this->{$exe_fun}();
            if(!empty($tmp))
            {
                $this->err[$serve] = $tmp.PHP_EOL;
            }
        }
        if($this->err)
        {
            $err = implode("|",$this->err);
            echo "本机ip:{$this->ip} ".$err;
        }else{
            echo $this->msg;
        }
    }
}
$app = new detection($_env_radio,$write_folder_config);
$app->run();
// $app->info();
