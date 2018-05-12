<?php
/*
    Create a thumbnail of $srcFile and save it to $destFile.
    The thumbnail will be $width pixels.
*/
function createThumbnail($srcFile, $destFile, $new_w, $new_h, $quality = 75)
{
    $thumbnail = '';
    
    if (file_exists($srcFile)  && isset($destFile))
    {
        $size=getimagesize($srcFile);
        $old_x = $size[0];
        $old_y = $size[1];
        $ratio1=$old_x/$new_w;
        $ratio2=$old_y/$new_h;
        if($ratio1>$ratio2) {
            $thumb_w=$new_w;
            $thumb_h=$old_y/$ratio1;
        }
        else {
            $thumb_h=$new_h;
            $thumb_w=$old_x/$ratio2;
        }
            
        $thumbnail =  copyImage($srcFile, $destFile, $thumb_w, $thumb_h, $quality);
    }
    
    // return the thumbnail file name on sucess or blank on fail
    return basename($thumbnail);
}
 
/*
    Copy an image to a destination file. The destination
    image size will be $w X $h pixels
*/
function copyImage($srcFile, $destFile, $w, $h, $quality = 75)
{
    $tmpSrc     = pathinfo(strtolower($srcFile));
    $tmpDest    = pathinfo(strtolower($destFile));
    $size       = getimagesize($srcFile);
 
    if ($tmpDest['extension'] == "gif" || $tmpDest['extension'] == "jpg")
    {
       $destFile  = substr_replace($destFile, 'jpg', -3);
       $dest      = imagecreatetruecolor($w, $h);
       imageantialias($dest, TRUE);
    } elseif ($tmpDest['extension'] == "png") {
       $dest = imagecreatetruecolor($w, $h);
       imageantialias($dest, TRUE);
    } else {
      return false;
    }
 	echo $size[2];
    switch($size[2])
    {
       case 1:       //GIF
           $src = imagecreatefromgif($srcFile);
           break;
       case 2:       //JPEG
           $src = imagecreatefromjpeg($srcFile);
           break;
       case 3:       //PNG
           $src = imagecreatefrompng($srcFile);
           break;
       default:
           return false;
           break;
    }
 
    imagecopyresampled($dest, $src, 0, 0, 0, 0, $w, $h, $size[0], $size[1]);
 
    switch($size[2])
    {
       case 1:
       case 2:
           imagejpeg($dest,$destFile, $quality);
           break;
       case 3:
           imagepng($dest,$destFile);
    }
    return $destFile;
 
}

?>