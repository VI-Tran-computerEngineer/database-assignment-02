<?php
// Connect database
$serverName = "VII\VII";
$connectionInfo = array( "Database"=>"db_assigment2");
$db = sqlsrv_connect( $serverName, $connectionInfo);
 
if(!$db) {
	echo "Connection error.&lt;br /&gt;";
	die( print_r( sqlsrv_errors(), true));
}