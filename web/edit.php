<?php
	require_once('php/functions.php');
	error_reporting(0);
	
	$dishes = get_dish_name();
	$branches = get_branch_name();
	
	$id = $_POST['e_order_id'];
	$username = $_POST['e_username'];
	$status = $_POST['e_order_status'];
	$method = $_POST['e_order_method'];
	$branch_name = $_POST['e_branch_name'];
	if(isset($_POST['btnEdit'])) {
		$id_n = $_POST['id-edit'];
		$username_n = $_POST['username-edit'];
		$status_n = $_POST['status-edit'];
		$method_n = $_POST['method-edit'];
		$branch_n = $_POST['branch-edit'];
		if(checker($username_n, "", $status_n, $method_n, $branch_n) == 0) {
			update_order_dish($id_n, $username_n, $status_n, $method_n, $branch_n);
			$flag = 0;
			foreach ($dishes as $dish) {
				$dish_id = $dish['dish_id'];
				$quantity_id = $dish['dish_id'] . "0";
				$quantity = $_POST[$quantity_id];
				if ($_POST[$dish_id] && ($quantity > 0)){
					$flag = 1;
				}
			}
			if ($flag == 1){
				delete_dishes($id_n);
				foreach ($dishes as $dish) {
					$dish_id = $dish['dish_id'];
					$quantity_id = $dish['dish_id'] . "0";
					$quantity = $_POST[$quantity_id];
					if ($_POST[$dish_id] && ($quantity > 0)){
						add_dish_2_dishes_list($id_n, $dish_id, $quantity);
					}
				}
			}
			header('Location: index.php');
		}
	}
?>

<!doctype html>
<html lang="en-US">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
  <title>Edit order dish</title>
    <script>
      function disable_box(id) {
        var val = document.getElementById(id);
        if(val.disabled == true)
          val.disabled = false;
        else
          val.disabled = true;
      }
    </script>
</head>
<body>
	<div class="container">
		<form class="formEdit" action="" method="POST">
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Order ID: </label>
				<input type="text" class="form-control col-7" id="id-edit" name="id-edit" value="<?php echo $id; ?>" readonly>
			</div>
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Username:</label>
				<input type="text" class="form-control col-7" id="username-edit" name="username-edit" value="<?php echo $username; ?>">
			</div>
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Order status:</label>
				<select class="form-control col-5" id="status-edit" name="status-edit">
					<option selected hidden><?php echo $status; ?></option>
					<option>Unpaid</option>
					<option>Paid</option>
					<option>Delivered</option>
          		</select>
			</div>
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Order method:</label>
				<select class="form-control col-5" id="method-edit" name="method-edit">
					<option selected hidden><?php echo $method; ?></option>
					<option>Live</option>
					<option>App</option>
					<option>Website</option>
          		</select>
			</div>
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Branch name:</label>
				<select class="form-control col-5" id="branch-edit" name="branch-edit">
            		<option selected hidden><?php echo $branch_name; ?></option>   
					<?php foreach ($branches as $branch) : ?>
						<option><?php echo $branch['branch_name']; ?></option>
					<?php endforeach; ?>
          		</select>
			</div>
			<div class="form-group row">
				<label class="col-3 text-right col-form-label">Dishes list:</label>
				<div class="checkbox" id="dish_list">
					<?php foreach ($dishes as $dish) : ?>
						<?php $id = $dish['dish_id'] ?>
						<?php $quantity_id = $dish['dish_id'] . "0" ?>
					<label class="col-7"><input type="checkbox" id="<?php echo $id; ?>" name="<?php echo $id; ?>" value="1" onclick="disable_box(<?php echo $quantity_id;?>)"> <?php echo $dish['dish_name'] . " (" . $dish['price'] . " dong)"; ?></label>
					<input class="col-2" type="number" id="<?php echo $quantity_id;?>" name="<?php echo $quantity_id; ?>" value="0" min="0" disabled> <br>
						<?php endforeach; ?>
				</div>
        	</div>

			<div class="form-group row">
				<div class="offset-3">
					<button id="btnEdit" name="btnEdit" class="btn btn-secondary" style="submit">Edit</button>
				</div>
			</div>
		</form>
	</div>
	
	<script src="js/fun.js"></script>
</body>
</html>