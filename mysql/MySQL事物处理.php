<?php

/*
MYSQL����������Ҫ�����ַ�����
1����begin,rollback,commit��ʵ��
begin ��ʼһ������
rollback ����ع�
commit ����ȷ��
2��ֱ����set���ı�mysql���Զ��ύģʽ
MYSQLĬ�����Զ��ύ�ģ�Ҳ�������ύһ��QUERY������ֱ��ִ�У����ǿ���ͨ��
set autocommit=0 ��ֹ�Զ��ύ
set autocommit=1 �����Զ��ύ
��ʵ������Ĵ���
������ set autocommit=0 ��ʱ�����Ժ����е�SQL������Ϊ������ֱ������commitȷ�ϻ�rollback������
ע�⵱�������������ͬʱҲ�����˸��µ����񣡰���һ�ַ���ֻ����ǰ����Ϊһ������
�����Ƽ�ʹ�õ�һ�ַ�����
MYSQL��ֻ��INNODB��BDB���͵����ݱ����֧�������������������ǲ�֧�ֵģ�
***��һ��MYSQL���ݿ�Ĭ�ϵ�������MyISAM,�������治֧���������Ҫ��MYSQL֧�����񣬿����Լ��ֶ��޸�:
�������£�1.�޸�c:\appserv\mysql\my.ini�ļ����ҵ�skip-InnoDB,��ǰ�����#���󱣴��ļ���
2.�����������룺services.msc,����mysql����
3.��phpmyadmin�У�mysql->show engines;(��ִ��mysql->show variables like 'have_%'; ),�鿴InnoDBΪYES,����ʾ���ݿ�֧��InnoDB�ˡ�
Ҳ��˵��֧������transaction�ˡ�
4.�ڴ�����ʱ���Ϳ���ΪStorage Engineѡ��InnoDB�����ˡ��������ǰ�����ı�����ʹ��mysql->alter table table_name type=InnoDB;
�� mysql->alter table table_name engine=InnoDB;���ı����ݱ��������֧������
*/

/*************** transaction--1 ***************/
$conn = mysql_connect('localhost','root','root') or die ("�������Ӵ���!!!");
mysql_select_db('test',$conn);
mysql_query("set names 'UTF-8'"); //ʹ��GBK���ı���;
//��ʼһ������
mysql_query("BEGIN"); //����mysql_query("START TRANSACTION");
$sql = "INSERT INTO `user` (`id`, `username`, `sex`) VALUES (NULL, 'test1', '0')";
$sql2 = "INSERT INTO `user` (`did`, `username`, `sex`) VALUES (NULL, 'test1', '0')";//�����ҹ���д��
$res = mysql_query($sql);
$res1 = mysql_query($sql2); 
if($res && $res1){
	mysql_query("COMMIT");
	echo '�ύ�ɹ���';
}else{
	mysql_query("ROLLBACK");
	echo '���ݻع���';
}
mysql_query("END"); 

/**************** transaction--2 *******************/
/*������*/
mysql_query("SET AUTOCOMMIT=0"); //����mysql���Զ��ύ����������commit����ύ
$sql = "INSERT INTO `user` (`id`, `username`, `sex`) VALUES (NULL, 'test1', '0')";
$sql2 = "INSERT INTO `user` (`did`, `username`, `sex`) VALUES (NULL, 'test1', '0')";//�����ҹ���д��
$res = mysql_query($sql);
$res1 = mysql_query($sql2); 
if($res && $res1){
	mysql_query("COMMIT");
	echo '�ύ�ɹ���';
}else{
mysql_query("ROLLBACK");
	echo '���ݻع���';
}
mysql_query("END"); //��������ʱ������mysql_query("SET AUTOCOMMIT=1");�Զ��ύ






/******************���ڲ�֧�������MyISAM�������ݿ����ʹ�ñ������ķ�����********************/
//MyISAM & InnoDB ��֧��,
/*
LOCK TABLES�����������ڵ�ǰ�̵߳ı�����������߳�����������ɶ�����ֱ�����Ի�ȡ��������Ϊֹ��
UNLOCK TABLES�����ͷű���ǰ�̱߳��ֵ��κ����������̷߳�����һ��LOCK TABLESʱ����������������ӱ��ر�ʱ�������ɵ�ǰ�߳������ı������ؽ�����
*/
mysql_query("LOCK TABLES `user` WRITE");//��ס`user`��
$sql = "INSERT INTO `user` (`id`, `username`, `sex`) VALUES (NULL, 'test1', '0')";
$res = mysql_query($sql);
if($res){
	echo '�ύ�ɹ���!';
}else{
	echo 'ʧ��!';
}
mysql_query("UNLOCK TABLES");//�������

