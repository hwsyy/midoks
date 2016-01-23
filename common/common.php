<?php
/*-------------------------
	@func $ ʱ���¼�� $
---------------------------*/
function G($start, $end='', $dec=3) {
    static $_info = array();
    if(!empty($end)) { // ͳ��ʱ��
        if(!isset($_info[$end])) {
            $_info[$end] = microtime(TRUE);
        }
        return number_format(($_info[$end]-$_info[$start]),$dec);
    }else{ // ��¼ʱ��
        $_info[$start] = microtime(TRUE);
    }
}
//static $baseUsage = memory_get_usage();
/*-------------------------
	@func $ �ڴ��¼�� $
---------------------------*/
function M( $start , $end = '' , $dec = 4){
	static $_memory =  array();
	if(!empty($end)){
		if(!isset($memory[$end])){
			$_info[$end] = memory_get_usage();
		}
		return number_format( ($_memory[$end] - $_memory[$start]) , $dec);
	}else{
		$_memory[$start] = memory_get_usage();
	}
}

/*----------------------------
	@func 			$ ʱ����ڴ��¼�� $
	@return array 	$ �������� $
------------------------------*/
function R($start,$end='',$dec=3) {
    static $_info = array();
    if(!empty($end)) { // ͳ��ʱ����ڴ�
        if(!isset($_info['time'][$end]) && ! isset($_info['mem'][$end])) {
            $_info['time'][$end]   =  microtime(TRUE);
			$_info['mem'][$end] = memory_get_usage();
        }
        return array(
			number_format(($_info['time'][$end]-$_info['time'][$start]),$dec),
			number_format(($_info['mem'][$end]-$_info['mem'][$start]),$dec)
		);
    }else{ // ��¼ʱ���ڴ�
        $_info['time'][$start]  =  microtime(TRUE);
		$_info['mem'][$start] = memory_get_usage();
    }
}


/*----------------------------------------------------------------------------------
	@return $ ����һ���ձ�׼������ exp[1990��8��9�� 12:59:20] $	
	@type $ ����һ��ʱ�������mysql[���ݼ�¼��ʱ��] file[�ļ���ʱ����] time[ʱ��] $
------------------------------------------------------------------------------------*/	
function DateTime( $type = '' ){
	switch( $type ){
		case '':
			$DateTime = date( 'Y-m-d H:i:s' , time() );break;
		case 'file';
			$DateTime = date( 'Y-m-d' , time() );break;
		case 'time';
			$DateTime = date( 'H:i:s' , time() );break;
		default:
			$DateTime = date( 'H:i:s' , time() );
	}
	return $DateTime;
}


/*---------------------
	��ȡ�ͷ���IP��ַ
-----------------------*/
function get_client_ip(){
	static $ip = null;
	if($ip != null) return $ip;
	if( isset( $_SERVER['HTTP_X_FORWARDED_FOR'] ) ){
		$arr = explode( ',' ,$_SERVER['HTTP_X_FORWARDED_FOR'] );
		$pos = array_search( 'unknown' , $arr );
		if( false !=$pos ) unset($arr[$pos]);
		$ip = trim( $arr[0] );
	}elseif( isset( $_SERVER['HTTP_CLIENT_IP'] ) ){
		$ip = $_SERVER['HTTP_CLIENT_IP'];
	}elseif( isset($_SERVER['REMOTE_ADDR'] ) ){
		$ip = $_SERVER['REMOTE_ADDR'];
	}
	//���IP��ַ�ĺϷ���
	$ip = (false!==ip2long($ip)) ? $ip : '0,0,0,0';
}

//д����Ϣ
function Write($fn, $text){
	$fp = fopen($fn, 'ab');
	fwrite($fp, $text."\n");
	fclose($fp);
}



// ��ȡ�����ļ���,����Ŀ¼
function src_dir_file($name){

	$name = rtrim($name,'/').'/';
	$fp = opendir($name);
	$arr = array();
	while($n = readdir($fp))
		if($n=='.'|| $n=='..'){
		}else if(is_dir($name.$n)){
			$arr[]= src_dir_file($name.$n);
		}else if(is_file($name.$n)){
			$arr[] = $name.$n;
		}
	closedir($fp);
	return $arr;

}
?>
