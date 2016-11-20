<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> {$title} </title>
		<meta name="description" content="">
		<meta name="author" content="">
			
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/smartadmin-production.css">
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/smartadmin-skins.css">

		<!-- SmartAdmin RTL Support is under construction
		<link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-rtl.css"> -->

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="css/your_style.css"> -->
		
		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="{php}echo base_url();{/php}template/css/demo.css">

		<!-- FAVICONS -->
		<link rel="shortcut icon" href="{php}echo base_url();{/php}template/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="{php}echo base_url();{/php}template/img/favicon/favicon.ico" type="image/x-icon">

		<!-- GOOGLE FONT -->
		<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">-->

		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="{php}echo base_url();{/php}template/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="{php}echo base_url();{/php}template/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="{php}echo base_url();{/php}template/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="{php}echo base_url();{/php}template/img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="{php}echo base_url();{/php}template/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="{php}echo base_url();{/php}template/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="{php}echo base_url();{/php}template/img/splash/iphone.png" media="screen and (max-device-width: 320px)">

	</head>
	<body class="">
		<!-- POSSIBLE CLASSES: minified, fixed-ribbon, fixed-header, fixed-width
			 You can also add different skin classes such as "smart-skin-1", "smart-skin-2" etc...-->
		
		<!-- HEADER -->
		<header id="header">
			<div id="logo-group">

				<!-- PLACE YOUR LOGO HERE -->
				<span id="logo"> <img src="{php}echo base_url();{/php}template/img/logo.png" alt="Gracios Dios"> </span>
				<!-- END LOGO PLACEHOLDER -->
			</div>

			<!-- pulled right: nav area -->
			<div class="pull-right">

				<!-- collapse menu button -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" title="Collapse Menu"><i class="fa fa-reorder"></i></a> </span>
				</div>
				<!-- end collapse menu -->

				<!-- logout button -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="{php}echo site_url();{/php}/auth/logout" title="Sign Out" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<!-- end logout button -->

				<!-- fullscreen button -->
				<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" onclick="launchFullscreen(document.documentElement);" title="Full Screen"><i class="fa fa-fullscreen"></i></a> </span>
				</div>
				<!-- end fullscreen button -->
			</div>
			<!-- end pulled right: nav area -->

		</header>
		<!-- END HEADER -->

		<!-- Left panel : Navigation area -->
		<!-- Note: This width of the aside area can be adjusted through LESS variables -->
		<aside id="left-panel">

			<!-- User info -->
			<div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut">
						<span>
							{$user->username}
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					
				</span>
			</div>
			<!-- end user info -->

			<!-- NAVIGATION : This navigation is also responsive

			To make this navigation dynamic please make sure to link the node
			(the reference to the nav > ul) after page load. Or the navigation
			will not initialize.
			-->
			<nav>
				<!-- NOTE: Notice the gaps after each icon usage <i></i>..
				Please note that these links work a bit different than
				traditional href="" links. See documentation for details.
				-->
				<ul>
					<li class="">
						<a href="{php}echo site_url();{/php}/dashboard/ajax" title="Dashboard"><i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">Dashboard</span></a>
					</li>
					{if $is_admin == 1 or $is_public == 1}
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-book"></i> <span class="menu-item-parent">Master Data</span></a>
						<ul>
							{if $is_admin == 1}
							<li>
								<a href="#"><i class="fa fa-fw fa-user"></i> Suppliers</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/suppliers/suppliers_type"><i class="fa fa-fw fa-info-circle"></i> Suppliers Type </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/suppliers"><i class="fa fa-fw fa-user"></i> Suppliers</a>
									</li>
								</li>
								</ul>
							</li>
							<li>
								<a href="{php}echo site_url();{/php}/customers"><i class="fa fa-fw fa-user"></i> Customers</a>
							</li>
							<li>
								<a href="{php}echo site_url();{/php}/barang"><i class="fa fa-fw fa-briefcase"></i> Product</a>
							</li>
							{/if}
							<li>
								<a href="{php}echo site_url();{/php}/stock"><i class="fa fa-fw fa-briefcase"></i> Stok Barang</a>
							</li>
						</ul>
					</li>
					{/if}
					{if $is_inputter == 1}
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-list-alt"></i> <span class="menu-item-parent">Transaksi</span></a>
						<ul>
							<li>
								<a href="{php}echo site_url();{/php}/pembelian"><i class="fa fa-fw fa-arrow-circle-down"></i> Pembelian</a>
							</li>
							<li>
								<a href="#"><i class="fa fa-fw fa-arrow-circle-up"></i> Penjualan</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/penjualan"><i class="fa fa-fw fa-briefcase"></i> Retail</a>
										<ul>
											<li><a href="{php}echo site_url();{/php}/penjualan/add"><i class="fa fa-fw fa-plus"></i> add</a></li>
										</ul>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/penjualan_project"><i class="fa fa-fw fa-building "></i> Project</a>
										<ul>
											<li><a href="{php}echo site_url();{/php}/penjualan_project/add"><i class="fa fa-fw fa-plus"></i> add</a></li>
										</ul>
									</li>
								</ul>
							</li>
						</ul>
					</li>
					{/if}
					{if $is_admin == 1}
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-money"></i> <span class="menu-item-parent">Accounting</span></a>
						<ul>
							<li>
								<a href="#"><i class="fa fa-fw fa-wrench"></i> Settings</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/group"> Group </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/subgroup"> Sub Group </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/mata_uang"> Mata Uang </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/account"> Account </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/periode"> Periode </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/tipe_jurnal"> Jurnal Type </a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#"><i class="fa fa-fw fa-book"></i> Input Data</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/saldo_awal"><i class="fa fa-fw fa-arrow-circle-up"></i> Saldo Awal</a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/jurnal_umum"><i class="fa fa-fw fa-arrow-circle-up"></i> Jurnal Umum</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#"><i class="fa fa-fw fa-info-circle"></i> Laporan</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/accounting/buku_besar"> Buku Besar </a>
									</li>
								</ul>
							</li>
						</ul>
					</li>
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-group"></i> <span class="menu-item-parent">User Management</span></a>
						<ul>
							<li>
								<a href="{php}echo site_url();{/php}/user_management/users"><i class="fa fa-fw fa-user"></i> Manage Users</a>
							</li>
							<li>
								<a href="{php}echo site_url();{/php}/user_management/groups"><i class="fa fa-fw fa-group"></i> Manage Groups</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-wrench"></i> <span class="menu-item-parent">Settings</span></a>
						<ul>
							<li>
								<a href="#"><i class="fa fa-fw fa-info-circle"></i> Table Reference</a>
								<ul>
									<li>
										<a href="{php}echo site_url();{/php}/reference/tinggi"> Upright </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/beam"> Beam </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/level"> Level </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/ambalan"> Ambalan </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/footplate"> Foot Plate </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/accessories"> Accessories </a>
									</li>
									<li>
										<a href="{php}echo site_url();{/php}/reference/center_support"> Center Support </a>
									</li>
								</ul>
							</li>
						</ul>
					</li>
					{/if}
				</ul>
			</nav>
			<span class="minifyme"> <i class="fa fa-arrow-circle-left hit"></i> </span>

		</aside>
		<!-- END NAVIGATION -->

		<!-- MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> <span id="refresh" class="btn btn-ribbon" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true" data-reset-msg="Would you like to RESET all your saved widgets and clear LocalStorage?"><i class="fa fa-refresh"></i></span> </span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<!-- This is auto generated -->
				</ol>
				<!-- end breadcrumb -->

				<!-- You can also add more buttons to the
				ribbon for further usability

				Example below:

				<span class="ribbon-button-alignment pull-right">
				<span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
				<span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
				<span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
				</span> -->

			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

		<!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
		Note: These tiles are completely responsive,
		you can add as many as you like
		-->
		<div id="shortcut">
			<ul>
				<li>
					<a href="#ajax/invoice.html" class="jarvismetro-tile big-cubes bg-color-blueDark"> <span class="iconbox"> <i class="fa fa-book fa-4x"></i> <span>Invoice <span class="label pull-right bg-color-darken">99</span></span> </span> </a>
				</li>
			</ul>
		</div>
		<!-- END SHORTCUT AREA -->

		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)
		<script data-pace-options='{ "restartOnRequestAfter": true }' src="{php}echo base_url();{/php}template/js/plugin/pace/pace.min.js"></script>-->

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<!--<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>-->
		<script>
			if (!window.jQuery) {
				document.write('<script src="{php}echo base_url();{/php}template/js/libs/jquery-2.0.2.min.js"><\/script>');
			}
		</script>

		<!--<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>-->
		<script>
			if (!window.jQuery.ui) {
				document.write('<script src="{php}echo base_url();{/php}template/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
			
			base_url = '{php}echo base_url();{/php}';
      site_url = '{php}echo site_url();{/php}/';
		</script>

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

		<!-- FastClick: For mobile devices: you can disable this in app.js
		<script src="{php}echo base_url();{/php}template/js/plugin/fastclick/fastclick.js"></script> -->

		<!--[if IE 7]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->
		<script src="{php}echo base_url();{/php}template/js/php.js"></script>

		<!-- Demo purpose only -->
		<script src="{php}echo base_url();{/php}template/js/demo.js"></script>

		<!-- MAIN APP JS FILE -->
		<script type="text/javascript">
			var APP_NAME = '{php} echo APP_NAME;{/php}';
		</script>
		<script src="{php}echo base_url();{/php}template/js/app.js"></script>

		<!-- Your GOOGLE ANALYTICS CODE Below -->
		<script type="text/javascript">
		/*
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-43548732-3']);
		  _gaq.push(['_trackPageview']);
		
		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		*/
		</script>

	</body>
</html>