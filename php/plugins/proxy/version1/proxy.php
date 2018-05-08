<?php
/**
 *       @func �Դ��ҵ�BLOG�Ƶ�SAE��,���ҵ�����û�б���,�ٶ�ֱ�Ӱ�ʱ���е���.
 *        ��ͻȻ���뵽�˷�ǽ-����ȵȶ���,�Ҿ���û�б����������������
 *        Ҳ�����ܸ��õķ������.
 */

//ʵ�ʵ�ַ
define('DOMAIN', 'http://midoks.duapp.com');
//����ʹ�õ�ַ
define('NOW_DOMAIN', 'http://www.qq.com');

class proxy{

	//����header�ļ�ƥ��
	public function mimeTypeMatch($url){
		$allow = array(
			'css' => 'text/css',
			'js'  => 'application/x-javascript', 
			'png' => 'image/png',
			'ico' => 'image/x-icon',
			'jpg' => 'image/jpeg',
			'gif' => 'image/gif',
			'swf' => 'application/x-shockwave-flash',
		   	'htm' => 'text/html', 
			'html' => 'text/html',	
		);
		foreach($allow as $k=>$v){
			if(preg_match("/.{$k}/", $url)){
				//var_dump($v);
				return $allow[$k];
			}
		}
		return false;
	}

	public function _get(){
		$ch = curl_init();

		//����URL��ַ
		if(isset($_SERVER['REQUEST_URI'])){
			//echo DOMAIN.$_SERVER['REQUEST_URI'];
			curl_setopt($ch, CURLOPT_URL , DOMAIN.$_SERVER['REQUEST_URI']);
		}else{
			curl_setopt($ch, CURLOPT_URL , DOMAIN);
		}

		curl_setopt($ch, CURLOPT_FOLLOWLOCATION , 1);//�����Ƿ������ת
		curl_setopt($ch, CURLOPT_MAXREDIRS , 5);//������ת�Ĵ���
		curl_setopt($ch, CURLOPT_HEADER , 0);//ͷ�ļ�
		curl_setopt($ch, CURLOPT_RETURNTRANSFER , 1);//����������

		//referer
		if(isset($_SERVER['HTTP_REFERER'])){
			curl_setopt($ch, CURLOPT_REFERER , $_SERVER['HTTP_REFERER']);
		}

		//user-agent
		if(isset($_SERVER['HTTP_USER_AGENT'])){
			curl_setopt($ch, CURLOPT_USERAGENT , $_SERVER['HTTP_USER_AGENT']);
		}
		//COOKIE
		if(isset($_SERVER['HTTP_COOKIE'])){
			//var_dump($_SERVER['HTTP_COOKIE']);
			curl_setopt($ch, CURLOPT_COOKIE , $_SERVER['HTTP_COOKIE']);
		}
		//POST���� && $GLOBALS['HTTP_RAW_POST_DATA']
		if((isset($_POST) && !empty($_POST)) || (isset($GLOBALS['HTTP_RAW_POST_DATA']))){
			curl_setopt($ch, CURLOPT_POST ,1);
			if(isset($GLOBALS['HTTP_RAW_POST_DATA'])){
				$raw_Data = $GLOBALS['HTTP_RAW_POST_DATA'];
			}else{
				$raw_Data = file_get_contents('php://input');
			}
				
			if(!empty($raw_Data)){
				curl_setopt($ch, CURLOPT_POSTFIELDS , $raw_Data);
			}else{
				curl_setopt($ch, CURLOPT_POSTFIELDS , http_build_query($_POST));
			}
			
		}

		$data = curl_exec($ch);
		curl_close($ch);
		
		if($_SERVER['REQUEST_URI']){
			$h = $this->mimeTypeMatch($_SERVER['REQUEST_URI']);
			//var_dump($h);exit;
			if($h){
				header("Content-type: ".$h);
			}
		}

		if(!empty($data) && false!=$data){
			if('/wp-login.php'==$_SERVER['REQUEST_URI']){
				
			}else if('/wp-admin'==substr($_SERVER['REQUEST_URI'], 0, 9)){
			
			}else{
				$data = str_replace(DOMAIN, NOW_DOMAIN, $data);
				$data = str_replace('http://midoks.cachecha.com', NOW_DOMAIN, $data);
			}
			//�滻ע��
			$data =  preg_replace('/<!--(.*)?-->/', '', $data);

			$uri = $_SERVER['REQUEST_URI'];
			///var_dump($_SERVER);
			$uri = parse_url($uri);
			$uri = $uri['path'];
			$uri = basename($uri);
			if(in_array($this->gfsuffix($uri), array('html', ''))){
				$server_name = "<!-- openshift proxy server -->";
		    	$data = preg_replace("/<head>(.*)<\/head>/ims", $server_name."\n \\0", $data);
			}	
			echo($data);
		}
	}

	//��ȡ�ļ���׺��
	public function gfsuffix($fn){
		$f = explode('.', $fn);
		return $f[1];
	}

	public function run(){
		$this->_get();
	}
}
$obj = new proxy();
$obj->run();
?>
