<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> {$title} </title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="HandheldFriendly" content="True">
		<meta name="MobileOptimized" content="320">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/bootstrap.min.css">	
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/smartadmin-production.css">
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/smartadmin-skins.css">	
		
		<!-- SmartAdmin RTL Support is under construction
			<link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-rtl.css"> -->
		
		<!-- FAVICONS -->
		<link rel="shortcut icon" href="{php}echo base_url();{/php}template/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="{php}echo base_url();{/php}template/img/favicon/favicon.ico" type="image/x-icon">

		<!-- GOOGLE FONT -->
		<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">-->

	</head>
	<body id="login" class="animated fadeInDown">
		<!-- possible classes: minified, no-right-panel, fixed-ribbon, fixed-header, fixed-width-->
		<header id="header">
			<!--<span id="logo"></span>-->

			<div id="logo-group">
				<span id="logo"> <img src="{php}echo base_url();{/php}template/img/logo.png" alt="Gudang"> </span>

				<!-- END AJAX-DROPDOWN -->
			</div>

		</header>

		<div id="main" role="main">

			<!-- MAIN CONTENT -->
			<div id="content" class="container">

				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-7 col-lg-8 hidden-xs hidden-sm">
						<h1 class="txt-color-red login-header-big">Gudang</h1>
						<div class="hero">

							<div class="pull-left login-desc-box-l">
								<h4 class="paragraph-header">Aplikasi pergudangan</h4>
							</div>
							
							<img src="{php}echo base_url();{/php}template/img/demo/iphoneview.png" class="pull-right display-image" alt="" style="width:210px">

						</div>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-5 col-lg-4">
						<div class="well no-padding">
							<form action="{php}echo site_url();{/php}/auth/login" id="login-form" class="smart-form client-form" method="post">
								<header>
									Sign In
								</header>
								<fieldset>
									{$message}
									<section>
										<label class="label">Username</label>
										<label class="input"> <i class="icon-append fa fa-user"></i>
											{$identity}
											<b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> Please enter username</b></label>
									</section>

									<section>
										<label class="label">Password</label>
										<label class="input"> <i class="icon-append fa fa-lock"></i>
											{$password}
											<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your password</b> </label>
										<div class="note">
											<a href="forgotpassword.html">Forgot password?</a>
										</div>
									</section>
									
									<section>
										<label class="checkbox">
											<input type="checkbox" id="remember" value="1" name="remember">
											<i></i>Stay signed in</label>
									</section>
								</fieldset>
								<footer>
									<button type="submit" class="btn btn-primary">
										Sign in
									</button>
								</footer>
							</form>

						</div>
						
					</div>
				</div>
			</div>

		</div>

		<!--================================================== -->	

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
		<script src="{php}echo base_url();{/php}template/js/plugin/pace/pace.min.js"></script>

	    <!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
	    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		<script> if (!window.jQuery) { document.write('<script src="{php}echo base_url();{/php}template/js/libs/jquery-2.0.2.min.js"><\/script>');} </script>

	    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
		<script> if (!window.jQuery.ui) { document.write('<script src="{php}echo base_url();{/php}template/js/libs/jquery-ui-1.10.3.min.js"><\/script>');} </script>

		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events 		
		<script src="{php}echo base_url();{/php}template/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> -->

		<!-- BOOTSTRAP JS -->		
		<script src="{php}echo base_url();{/php}template/js/bootstrap/bootstrap.min.js"></script>

		<!-- CUSTOM NOTIFICATION -->
		<script src="{php}echo base_url();{/php}template/js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
		<script src="{php}echo base_url();{/php}template/js/smartwidgets/jarvis.widget.min.js"></script>
		
		<!-- EASY PIE CHARTS -->
		<script src="{php}echo base_url();{/php}template/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
		
		<!-- SPARKLINES -->
		<script src="{php}echo base_url();{/php}template/js/plugin/sparkline/jquery.sparkline.min.js"></script>
		
		<!-- JQUERY VALIDATE -->
		<script src="{php}echo base_url();{/php}template/js/plugin/jquery-validate/jquery.validate.min.js"></script>
		
		<!-- JQUERY MASKED INPUT -->
		<script src="{php}echo base_url();{/php}template/js/plugin/masked-input/jquery.maskedinput.min.js"></script>
		
		<!-- JQUERY SELECT2 INPUT -->
		<script src="{php}echo base_url();{/php}template/js/plugin/select2/select2.min.js"></script>

		<!-- JQUERY UI + Bootstrap Slider -->
		<script src="{php}echo base_url();{/php}template/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>
		
		<!-- browser msie issue fix -->
		<script src="{php}echo base_url();{/php}template/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>
		
		<!-- FastClick: For mobile devices -->
		<script src="{php}echo base_url();{/php}template/js/plugin/fastclick/fastclick.js"></script>
		
		<!--[if IE 7]>
			
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
			
		<![endif]-->

		<!-- MAIN APP JS FILE -->
		<script src="{php}echo base_url();{/php}template/js/app.js"></script>

		<script type="text/javascript">
			runAllForms();

			$(function() {
				// Validation
				$("#login-form").validate({
					// Rules for form validation
					rules : {
						identity : {
							required : true,
							email : false
						},
						password : {
							required : true,
							minlength : 3,
							maxlength : 20
						}
					},

					// Messages for form validation
					messages : {
						identity : {
							required : 'Please enter your username'
						},
						password : {
							required : 'Please enter your password'
						}
					},

					// Do not change code below
					errorPlacement : function(error, element) {
						error.insertAfter(element.parent());
					}
				});
			});
		</script>
	</body>
</html>