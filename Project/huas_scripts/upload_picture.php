<?php
include("image_compress_script.php");
//ini_set("upload_max_filesize","3M");
$php_session="n/a";
if(isset($_COOKIE["PHP_SESSION"]))
$php_session=$_COOKIE["PHP_SESSION"];
//echo $php_session;
if($php_session=="H94U25A71S6530")
{
$con=mysql_connect("localhost","hucky","13071992");
if(!$con)
{
	die('Connection failed!...'.mysql_error());
}
mysql_select_db("HUAS",$con);
$allowedExts = array(".jpg", ".jpeg", ".gif", ".png");
$file_name = $_FILES["file"]["name"];
$extension=substr($file_name,strlen($file_name)-4);
$extension=strtolower($extension);
if($extension=="jpeg")
{$extension=".jpeg";}
//echo $extension.",".$_FILES["file"]["size"].",".$_FILES["file"]["type"];
if ((($_FILES["file"]["type"] == "image/bmp")
|| ($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 2048000)
&& in_array($extension, $allowedExts))
{
	if ($_FILES["file"]["error"] > 0)
  	{
    	echo "Error: ".$_FILES["file"]["error"] . "<br>";
  	}
	else
	{
			$item_id=$_REQUEST["item_id"];


			$targetfilepath= "uploads/".$item_id.$extension;
/*
                        if( is_file ($targetfilepath) )	
			{unlink($targetfilepath);}
                        move_uploaded_file($_FILES["file"]["tmp_name"],$targetfilepath);
                        createThumbnail($targetfilepath,$targetfilepath,400,800,85);
			mysql_query("update seller_items set seller_item_image='".$item_id.$extension."' where seller_item_id='".$item_id."'");
*/

$ftp_server = "ftp.huas.co.in";
$ftp_user_name = "hucky_ftp";
$ftp_user_pass = "animesh13071992";
$remote_dir = "/uploads";

// set up basic connection
$conn_id = ftp_connect($ftp_server);

// login with username and password
$login_result = @ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);

//default values
$file_url = "";

if($login_result) {
//set passive mode enabled
ftp_pasv($conn_id, true);

//check if directory exists and if not then create it
if(!@ftp_chdir($conn_id, $remote_dir)) {
//create diectory
ftp_mkdir($conn_id, $remote_dir);
//change directory
ftp_chdir($conn_id, $remote_dir);
}

$file = $_FILES["file"]["tmp_name"];
$remote_file = $item_id.$extension;

if(ftp_size ($conn_id, $remote_file)!=-1)	
{
//echo "File Found!\n";
ftp_delete($conn_id, $remote_file);
}

$ret = ftp_nb_put($conn_id, $remote_file, $file, FTP_BINARY, FTP_AUTORESUME);
while(FTP_MOREDATA == $ret) {
$ret = ftp_nb_continue($conn_id);
}

if($ret == FTP_FINISHED) {
//echo "File '" . $remote_file . "' uploaded successfully.";
createThumbnail($targetfilepath,$targetfilepath,400,800,85);
mysql_query("update seller_items set seller_item_image='".$item_id.$extension."' where seller_item_id='".$item_id."'");
} else {
echo "Failed uploading file '" . $remote_file . "'.";
}
} else {
echo "Cannot connect to FTP server at " . $ftp_server;
}


	}
}
else
{
 echo "Invalid file";
}
header("location:/HUAS/User/user_items.jsp");
}
else
{
	echo "Unauthorised Access!";
}
?>
