/**
 * @func ͨ��flash��ȡ��ҳ������
 * author:midoks
 */
(function(){

//��������
var GetUrlData = {
	//url:'',
};

GetUrlData.url = '123';

function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
       return window[movieName];
    } else {
        return document[movieName];
    }
}

GetUrlData.test = function(str){
	//console.log(this);
	this.url = str;
	alert(str);
	//console.log(str);
	//var ss = thisMovie('movieId');
	//console.log(ss);
	//var test = document.getElementById('movie  7 y67tId');
	//console.log(test);
	//ss.test2(str);
};

GetUrlData.test2 = function(v){
	//console.log(thisMovie(movieId));
	(thisMovie('movieId')).test2(v);

};

window.GetUrlData = GetUrlData;
})();
