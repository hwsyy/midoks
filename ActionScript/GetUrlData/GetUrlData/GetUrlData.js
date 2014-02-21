/**
 * @func ͨ��flash��ȡ��ҳ������
 * author:midoks
 */
//��������������
(function(){
/**
 * 	@func ͨ��FLASH �����ȡ���� �� ��������
 *	@param string Url ��վ��ַ
 *	@param string Method �� GET POST (��Сд������)
 */
function G(Url,Method){
	
	//����һ������
	var JsFlash = {};
	
	JsFlash.IsReady = false;//Flash�Ƿ��ʼ����� true ��ʼ����� | false δ��ʼ�� | Ĭ��false
	//JsFlash.fId = 'G_' + (Math.random().toString()).substr(2); 	//ID���ֵ
	JsFlash.fId = 'G_007'; 	//FLASH ID
	JsFlash.Id = 'GtUrl';	//��һ��ȷ�ϵ�ֵ
	JsFlash.SwfPath = 'GetUrlData/GetUrlData.swf';				//swf·��

	JsFlash.init = function(){;//������һ��
		if(null!=document.getElementById(JsFlash.Id)){
			return true;
		}	
	}

	//���ݱ���
	JsFlash.resultBool = false;
	JsFlash.result = '';//������
	
	JsFlash.error = new Array;//���������Ϣ
	JsFlash.progress = new Array;//���������Ϣ

	//�������ݱ���
	JsFlash.test = '';

	//�����ռ�
	G.error = function(e){
		JsFlash.error.push(e);
		//console.log(JsFlash.error);
	}

	//������ɼ���
	G.result = function(e){JsFlash.result = e;};

	//���̼���
	G.progress = function(e){JsFlash.progress.push(e);};

	//flash׼���ú�,��������
	G.FlashTrigger = function(e){JsFlash.IsReady = e;};

	//�����õ�
	G.test = function(e){
		JsFlash.test = e;
	}

	//����div���󲢲���BODY��
	function create_div(){
		var d = document.createElement('div');
		d.style.width=0;
		d.style.height=0;
		d.id = JsFlash.Id;
		return d;
	}

	//��HTML�в���FLASH
	function InitFlash(){
		if(JsFlash.init()){return true;}
		var html = new Array();
		var protocol = location.href.match(/^https/i) ? 'https://' : 'http://';//��ȫ����
		//�������
		var fwidth = 0,fheight = 0;
		//Ƕ����ҳ
		html.push('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="'+JsFlash.fId+'" codebase="'+protocol+'download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="'+fwidth+'" height="'+fheight+'" id="'+ JsFlash.fId +'" align="middle">');
		html.push('<param name="allowScriptAccess" value="always" ></param>');//����ű�������� ��:ActionScript
		html.push('<param name="allowFullScreen" value="false" />');
		html.push('<param name="movie" value="'+JsFlash.SwfPath+'" />');
		html.push('<param name="loop" value="false" />');
		html.push('<param name="menu" value="false" />');
		html.push('<param name="quality" value="best" />');
		html.push('<param name="bgcolor" value="#ffffff" />');
		html.push('<param name="flashvars" value="id=123"/>');	//����������Դ�ֵ
		html.push('<param name="wmode" value="transparent"/>');
		html.push('<embed id="'+JsFlash.fId+'" src="'+JsFlash.SwfPath+'" loop="false" menu="false" quality="best" bgcolor="#ffffff" width="'+fwidth+'" height="'+fheight+'" name="'+JsFlash.fId+'" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=123" wmode="transparent" />');
		html.push('</object>');
		//��IE���IE��ѡ���²���	navigator.userAgent.match(/MSIN/)	//document.body.innerHTML = html.join('');
		var c_d = create_div();
		c_d.innerHTML = html.join('');
		document.body.appendChild(c_d);
	}

	//��ʼ��flash
	JsFlash.InitFlash = InitFlash();
	
	//ȡ�ö��� @param string id idֵ
	function getObject(id){
		if (navigator.appName.indexOf("Microsoft") != -1) {
			return window[id];//��IE
		}else{
			return document[id];//IE��
		}
	}

	//ֱ��JsFlash.IsReadyΪ��
	//flash ������ʱ
	function check_ready(bool){
		switch(bool){
			case false:
				//��flash��ʾ�Լ�׼����ʱ,����IEȴ�����������...
				////������޸�:������չǶ��Ԫ����Fire fox ��,����ʹ�ô�ͳ�Ĺ���
				setTimeout(function(){check_ready(JsFlash.IsReady);},1); break;
			case true:	
				setTimeout(function(){
					get(JsFlash.fId,Url);
				},1);break;
			default:
				setTimeout(function(){
					get(JsFlash.fId,Url);
				},1);break;
		}
	}

	//��ȡ��Դ
	function get(id,url){
		var t = getObject(id);
		t.get(url);	
		//��Դ��ȡ��Ĳ���
		var timer = setInterval(function(){
			if(JsFlash.result!=''){//console.log(JsFlash.result);
				clearInterval(timer);
				destory();
			}
		},10);
	}

	//������Դ
	function destory(){
		var res = document.getElementById(JsFlash.Id);
		document.body.removeChild(res);
	}

	//xml�ַ�������
	function xmlparse(data){
		var xmlobject;
		try{
			xmlobject = new ActiveXObject("Microsoft.XMLDOM");
			xmlobject.async = 'false';
			xmlobject.loadXML(data);
		}catch(e){
			var parser = new DOMParser();
			xmlobject = parser.parseFromString(data,'text/xml');
		}
		return xmlobject;
	}

	//�������ݵĴ���
	function datadel(type,func,data){
		switch(type){
			case 'json':func(eval('('+data+')'));break;
			case 'xml':func(xmlparse(data));break;
			default:func(data);
		}
	};
	
	/**
	 *	@param string DataType ���ص����� Ĭ�����ַ���  (�������ִ�С��) | �����ǿ�ѡֵ
	 *  string
	 *  json
	 *  xml
	 *  @paran func �ص�����
	 */
	JsFlash.get = function(DataType,callback){
		var type = (DataType.toString()).toLowerCase();//��������
		//��鲢��ȡ����
		check_ready(this.IsReady);
		var timer = setInterval(function(){
			if(JsFlash.result!=''){
				if(typeof callback == 'function'){//����Ƿ�ص�����
					if('false'==JsFlash.result){
						alert('And allow the domain name in the goal-line, crossdomain.xml file access');
					}
					datadel(type,callback,JsFlash.result);
					//callback(JsFlash.result);
				};
				//console.log(JsFlash.test);
				clearInterval(timer);
			}
		},10);
	}

	return JsFlash;
}
//��Ϊȫ�ֱ���
window.G = G;
})();
