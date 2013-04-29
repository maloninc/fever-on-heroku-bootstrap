<?php
  $url = $argv[1];
  $db = $argv[2];
  $user = $argv[3];
  $pass = $argv[4];


  $link = mysql_connect($url,$user,$pass) or die("Failed to connect MySQL");
  $sdb = mysql_select_db($db,$link) or die("Failed to select DB");

  $purge_day = 2;
  $purge_second = time() - ($purge_day * 24 * 60 * 60);
  $sql = "delete from fever_links  where created_on_time < ".$purge_second.";";
  mysql_query($sql, $link) or die("Failed to query SQL:".$sql);
  $sql = "delete from fever_items  where created_on_time < ".$purge_second.";";
  mysql_query($sql, $link) or die("Failed to query SQL:".$sql);

  mysql_close($link) or die("Failed to close MySQL");
?>
