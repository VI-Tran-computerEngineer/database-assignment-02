<?php
  require_once('php/functions.php');
  error_reporting(0);

  $orders = get_order_dishes();
  $dishes = get_dish_name();
  $branches = get_branch_name();

  $check = true;
  if (isset($_POST['btnAdd'])) {
    $username = $_POST['username'];
    $voucher = $_POST['voucher'];
    $status = $_POST['status'];
    $method = $_POST['method'];
    $branch_name = $_POST['branch_n'];
    if (checker($username, $voucher, $status, $method, $branch_name) == 0){
        if(strlen($voucher) == 0)
          $voucher = "null";
        $id = random_id("od");
        
        add_order_dishes($id, $username, $voucher_added, $status, $method, $branch_name);
        
        $flag = 0;
        foreach ($dishes as $dish) {
          $dish_id = $dish['dish_id'];
          $quantity_id = $dish['dish_id'] . "0";
          $quantity = $_POST[$quantity_id];
          if ($_POST[$dish_id] && ($quantity > 0)){
            $flag = 1;
            add_dish_2_dishes_list($id, $dish_id, $quantity);
          }
        }
        if ($flag == 0){
          delete_order_dish($id);
          echo "Please choose dish you want to order!";
        }
        header("Refresh:0");
    } else
        echo "Invalid value! Please check again.";
    
  }

  // Xóa car
  if(isset($_POST['btnDel'])) {
    $id = $_POST['order_id'];
    delete_order_dish($id);
	  header("Refresh:0");
  }
?>

<!doctype html>
<html lang="vi">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <title>Order dishes</title>
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
    <button class="btn btn-primary btnAddNew">New order</button>
      <form class="formAddNew d-none" action="" method="POST">
        <div class="form-group row">
          <label class="col-3 text-right col-form-label">username:</label>
          <input type="text" class="form-control col-7" id="username" name="username" onfocus="this.placeholder=''" onblur="this.placeholder='Enter customer\'s Username'" placeholder="Enter customer's Username">
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
          <label class="col-3 text-right col-form-label">Voucher:</label>
          <input type="text" class="form-control col-7" id="voucher" name="voucher" onfocus="this.placeholder=''" onblur="this.placeholder='Enter voucher ID (Include 7 characters)'" placeholder="Enter voucher ID (Include 7 characters)">
        </div>
        <div class="form-group row">
          <label class="col-3 text-right col-form-label">Status:</label>
          <select class="form-control col-5" id="status" name="status">
                <option selected disabled hidden>Select one</option>
                <option>Unpaid</option>
                <option>Paid</option>
                <option>Delivered</option>
          </select>
        </div>
        <div class="form-group row">
          <label class="col-3 text-right col-form-label">Method:</label>
          <select class="form-control col-5" id="method" name="method">
                <option selected disabled hidden>Select one</option>
                <option>Live</option>
                <option>App</option>
                <option>Website</option>
          </select>
        </div>
        <div class="form-group row">
          <label class="col-3 text-right col-form-label">Branch:</label>
          <select class="form-control col-5" id="branch_n" name="branch_n">
            <option selected disabled hidden>Select one</option>   
		        <?php foreach ($branches as $branch) : ?>
              <option><?php echo $branch['branch_name']; ?></option>
		        <?php endforeach; ?>
          </select>
        </div>
        <div class="form-group row">
          <div class="offset-3">
            <button name="btnAdd" class="btn btn-secondary">OK</button>
          </div>
        </div>
      </form>
      <table class="table table-hover">
        <tr style='margin: center'>
          <th>ID</th> 
          <th>Username</th> 
          <th>Original price</th> 
          <th>Payment price</th>
          <th>Decreased price</th>
          <th>Order method</th>
          <th>Order status</th>
          <th>Branch name</th>
          <th>Manipulations</th>
        </tr>
		    <?php foreach ($orders as $order) : ?>
          <tr>
              <td><?php echo $order['order_id']; ?></td>
              <td><?php echo $order['username']; ?></td>
              <td><?php echo $order['o_price']; ?></td>
              <td><?php echo $order['p_price']; ?></td>
              <td><?php echo $order['d_price']; ?></td>
              <td><?php echo $order['order_method']; ?></td>
              <td><?php echo $order['order_status']; ?></td>
              <td><?php echo $order['branch_name']; ?></td>
              <td class="d-flex">
                <form action="" method="POST">
                  <input type="text" value="<?php echo $order['order_id']; ?>" name="order_id" hidden>
                  <button name="btnDel" type="submit" class="btn btn-outline-danger btn-sm">Del</button>
                </form>
                <form action="edit.php" method="POST">
                  <input type="text" value="<?php echo $order['order_id']; ?>" name="e_order_id" hidden>
                  <input type="text" value="<?php echo $order['username']; ?>" name="e_username" hidden>
                  <input type="text" value="<?php echo $order['order_status']; ?>" name="e_order_status" hidden>
                  <input type="text" value="<?php echo $order['order_method']; ?>" name="e_order_method" hidden>
                  <input type="text" value="<?php echo $order['branch_name']; ?>" name="e_branch_name" hidden>
                  <button name="btnedit" type="submit" class="btn btn-outline-info btn-sm">Edit</button>
                </form>
              </td>
          </tr>
        <?php endforeach; ?>
      </table>
    </div>
  
    <script src="js/fun.js"></script>
  </body>
</html>