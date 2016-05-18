<?php
session_start();

// clear all session
if(isset($_SESSION['user'])){
	$_SESSION['user'] = null;
	unset($_SESSION['user']);
}


// validate user credential
if( isset($_GET['email']) && isset($_GET['password']) ){
	// response array of error and data to client
	$response = array('error'=>'undefined','data'=>null);

	// check form token
	// ...

	// includes helper function
	require_once('./includes/functions.php');
	require_once('./includes/dbhandler.php');
	$db = new dbhandler();

	// get variables
	$email = $db->clean($_GET['email']);
	$password = passwordHash($db->clean($_GET['password']));

	// query
	$query = "Select user_id,password,role,blocked from tb_user where user_id=".$db->quote($email);
	$data = $db->selectQuery($query);

	if($db->error!=""){
		$response['error'] = $db->error;
	}else{
		if(count($data)>0){
			if(1!=(int)$data[0]['blocked']){
				if( strcmp($data[0]['password'],$password)==0 ){
					$_SESSION['user_id'] = $data[0]['user_id'];
					$response['error'] = '';
					if( (int)$data[0]['role']==1){
						$response['data'] = 'admin/index.php';
					}else{
						$response['data'] = 'index.php';
					}
				}else{
					// invalid password
					$response['error'] = 'Invalid email or password';
				}
			}else{
				// email is blocked
				$response['error'] = 'The email is blocked';
			}
		}else{
			// invalid user id
			$response['error'] = 'The email is not register';
		}
	} // ./database
	echo json_encode($response);
	exit();
} // ./isset
?>

<?php /* ----- start html ----- */ ?>
<?php
	// include header
	include('./includes/header.php');
?>

<style type="text/css">
	#form-login{
		width : 600px;
		margin: 0 auto;
	}
	#form-error{
		color: #ff0000;
		font-size : 11px;
	}
</style>
<script type="text/javascript">
	function checkForm(evt,frm){
		var isError = false;
		var e = evt || this.event;
		e.preventDefault();

		if(isValidEmail(frm.email.value)){
				jQuery('#email-group').removeClass('has-error');
		}else{
			jQuery('#email-group').addClass('has-error');
			isError = true;
		}

		if(frm.password.value==""){
			jQuery('#password-group').addClass('has-error');
			isError = true;
		}
		if(isError){
			jQuery('#message-bar').html("Please correct information below");
      if(!jQuery('#message-bar').hasClass('error')){
        jQuery('#message-bar').addClass('error');
      }
			jQuery('#message-bar').show();
		}else{
			jQuery('#message-bar').html('Log in ...');
      jQuery('#message-bar').removeClass();
      jQuery('#btnSubmit').attr('disabled','disabled');
      jQuery('#btnSubmit').addClass('disabled');
			// call ajax from java.js
			// ajaxUrl is defined in header.php
			ajaxForm({
				'url':ajaxUrl, 'form':frm, 'log':false,
				'complete':function(response){
					if(response.error!=""){
						// error occured
						jQuery('#message-bar').html(response.error);
						jQuery('#message-bar').addClass('error');
						jQuery('#btnSubmit').removeAttr('disabled');
						jQuery('#btnSubmit').removeClass('disabled');
					}else{
						// success
						jQuery('#message-bar').html('Redirect ...');
			      jQuery('#message-bar').removeClass();
						jQuery('#message-bar').addClass('success');
			      jQuery('#btnSubmit').attr('disabled','disabled');
			      jQuery('#btnSubmit').addClass('disabled');
						window.location.href = response.data;
					}
				}
			});
			jQuery('#message-bar').show();
		}
		return false;
	}
</script>

<!-- html -->
<div class="container">
	<form id="form-login" action="login.php" method="get" class="form-horizontal" onsubmit="checkForm(event,this); return false;">
		<div class="form-group" id="email-group">
			<label for="email" class="col-sm-2 control-label">Email</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="email" name="email">
			</div>
		</div>
		<div class="form-group" id="password-group">
			<label for="password" class="col-sm-2 control-label">Password</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="password" name="password">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="btnSubmit" class="btn btn-default">Log in</button>
			</div>
		</div>
		<input type="hidden" name="task" value="select">
		<input type="hidden" name="token" value="">
	</form>
	<br>
	<h3>Demo Login</h3>
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<legend>Administrator</legend>
			Email : admin@swin.edu.au <br>
			Password : admin
		</div>
		<div class="col-xs-12 col-sm-6">
			<legend>User</legend>
			Email : demo@student.edu.au <br>
			Password : demo
		</div>
	</div>
</div>
<!-- end of html -->

<?php
// include footer
include('./includes/footer.php');
?>

<?php /* ----- end html ----- */ ?>
