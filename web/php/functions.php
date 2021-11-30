<?php
	require_once("init.php");
	/* Lấy tất cả dữ liệu trong bảng Cars */
	function get_order_dishes(){
		global $db;
		$sql = "EXECUTE Display_order_dishes_list ''";
		$stmt = sqlsrv_query($db, $sql);
		$result = array();
		while ($order = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
			array_push($result, $order);
		}
		return $result;
	}
	
	function search($text){
		global $db;
		$sql = "EXECUTE Display_order_dishes_list '?'";
		$param = array($text);
		$stmt = sqlsrv_query($db, $sql, $param);
		$result = array();
		while ($order = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
			array_push($result, $order);
		}
		return $result;
	}

	function get_dish_name(){
		global $db;
		$sql = "SELECT dish_id, dish_name, price FROM DISHES";
		$stmt = sqlsrv_query($db, $sql);
		$result = array();
		while ($dish = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
			array_push($result, $dish);
		}
		return $result;
	}

	function get_branch_name(){
		global $db;
		$sql = "SELECT branch_name FROM RESTAURANT_BRANCH";
		$stmt = sqlsrv_query($db, $sql);
		$result = array();
		while ($dish = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
			array_push($result, $dish);
		}
		return $result;
	}

	function random_id($table)
    {
        $permitted_chars = '0123456789';
		$id = substr(str_shuffle($permitted_chars), 0, 7);
		global $db;
		if ($table = "od")
			$sql = "SELECT order_id as ck FROM ORDER_DISHES where order_id = ?";
		$stmt = sqlsrv_query($db, $sql, array($id));
		
		$result = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
		if (!$result || $result['ck'] == "null")
        	return $id;
    }

	function add_order_dishes($id, $username, $voucher_added, $status, $method, $branch_name){
		global $db;
		$sql = "EXECUTE Insert_Tuple_2_ORDER_DISHES ?, ?, ?, ?, ?, ?, ?";
		$params = array($id, $voucher_added, $username, $status, $method, $branch_name, null);
		$stmt = sqlsrv_query($db, $sql, $params);
	}

	function add_dish_2_dishes_list($id, $dish_id, $quantity){
		global $db;
		$sql = "EXECUTE Insert_Tuple_2_DISHES_LIST ?, ?, ?";
		$params = array($id, $dish_id, $quantity);
		$stmt = sqlsrv_query($db, $sql, $params);
	}

	function delete_dishes($order_id){
		global $db;
		$sql = "DELETE from DISHES_LIST where order_id = ?";
		$params = array($order_id);
		$stmt = sqlsrv_query($db, $sql, $params);
	}

	function delete_order_dish($order_id){
		global $db;
		$sql = "EXECUTE delete_a_order_dish ?";
		$params = array($order_id);
		$stmt = sqlsrv_query($db, $sql, $params);
	}
	
	function update_order_dish($id, $username, $status, $method, $branch_name){
		global $db;
		$sql = "UPDATE ORDER_DISHES SET customer_username=?, order_status=?, order_method=?, branch_name=? WHERE order_id = ?";
		$params = array($username, $status, $method, $branch_name, $id);
		$stmt = sqlsrv_query($db, $sql, $params);
	}

	function checker($username, $voucher, $status, $method, $branch) {
		$flag = 0;
		global $db;
		if ($username == ""){
		  echo "Please Enter username! <br>";
		  $flag = -1;
		}
		else{
			$sql = "SELECT username FROM CUSTOMERS";
			$stmt = sqlsrv_query($db, $sql);
			$temp = 0;
			while ($result = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
				if($username == $result['username']){
					$temp = 1;
					break;
				}
			}
			if($temp != 1){
				echo "username is not exist! <br>";
				$flag = -1;
			}
		}
		if (strlen($voucher) != 7 && strlen($voucher) != 0){
			echo "Invalid voucher ID! <br>";
		  	$flag = -1;
		}
		else if(strlen($voucher) != 0){
			$sql = "SELECT voucher_status FROM VOUCHERS where voucher_id = '$voucher'";
			$stmt = sqlsrv_query($db, $sql);
			$result = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
			if($result['voucher_status'] != "Available"){
				echo "Voucher had been used, expired, or no exists! <br>";
				$flag = -1;
			}
		}
		
		if ($status == "undefined" || $status == null || $status == ""){
			echo "Please choose order status! <br>";
		  $flag = -1;
		}
		if ($method == "undefined" || $method == null || $method == ""){
		  echo "Please choose order method! <br>";
		  $flag = -1;
		}
		if ($branch == "undefined" || $branch == null || $branch == ""){
		  echo "Please choose order branch! <br>";
		  $flag = -1;
		}
		return $flag;
	  }