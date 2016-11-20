{include file="breadcrumb.tpl" icon="fa-user" bc="User Management <span>> Manage Users > {$cond} User</span>"}
<!-- widget grid -->
<section id="widget-grid" class="">
	<!-- START ROW -->
	<div class="row">
		<!-- NEW COL START -->
		<article class="col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-8" data-widget-editbutton="false" data-widget-custombutton="false">
				<!-- widget options:
					usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">
					
					data-widget-colorbutton="false"	
					data-widget-editbutton="false"
					data-widget-togglebutton="false"
					data-widget-deletebutton="false"
					data-widget-fullscreenbutton="false"
					data-widget-custombutton="false"
					data-widget-collapsed="true" 
					data-widget-sortable="false"
					
				-->
				<header>
					<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
					<h2>{$cond} User </h2>				
					
				</header>

				<!-- widget div-->
				<div>
					
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
						
					</div>
					<!-- end widget edit box -->
					
					<!-- widget content -->
					<div class="widget-body">
						<form class="smart-form" id="form1" method="post" action="{php}echo base_url();{/php}auth/{$stat_cond}" novalidate="novalidate">
							<header>User form</header>
							
							<input type="hidden" name="id" id="id" value="{$detail['id']}"/>
							{$csrf}
							<fieldset>
								<div class="row">
									<section class="col col-6">
										First Name
										<label class="input">
											<input type="text" placeholder="First name" name="first_name" value="{$detail['first_name']}">
										</label>
									</section>
									<section class="col col-6">
										Last name
										<label class="input">
											<input type="text" placeholder="Last name" name="last_name" value="{$detail['last_name']}">
										</label>
									</section>
								</div>
								{$block_username}
								<div class="row">
									<section class="col col-6">
										Password
										<label class="input"> <i class="icon-append fa fa-lock"></i>
											<input type="password" id="password" placeholder="Password {$change_pwd}" name="password">
											<b class="tooltip tooltip-bottom-right">Don't forget your password</b> </label>
									</section>
									<section class="col col-6">
										Confirm Password
										<label class="input"> <i class="icon-append fa fa-lock"></i>
											<input type="password" id="password_confirm" placeholder="Confirm Password {$change_pwd}" name="password_confirm">
											<b class="tooltip tooltip-bottom-right">Don't forget your password</b> </label>
									</section>
								</div>
								<div class="row">
									<section class="col col-6">
										Company
										<label class="input">
											<input type="text" placeholder="Company Name" name="company" value="{$detail['company']}">
										</label>
									</section>
									<section class="col col-6">
										Email
										<label class="input">
											<input type="text" placeholder="Email" name="email" id="email" value="{$detail['email']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-6">
										Phone
										<label class="input">
											<input type="text" placeholder="Phone" name="phone" value="{$detail['phone']}">
										</label>
									</section>
								</div>
							</fieldset>
							
							{$member_groups}
							
							<footer>
								<div class="row">
									<div class="col-md-12">
										<nav>
											<a id="cancel" href="{php}echo base_url();{/php}user_management/users" class="btn btn-default">
												Cancel
											</a>
										</nav>
										<button type="submit" class="btn btn-primary">
											<i class="fa fa-save"></i>
											Submit
										</button>
									</div>
								</div>
							</footer>
						</form>
						
					</div>
					<!-- end widget content -->
					
				</div>
				<!-- end widget div -->
				
			</div>
			<!-- end widget -->	
		</article>
		<!-- END COL -->		

	</div>

	<!-- END ROW -->

</section>
<!-- end widget grid -->
<input type="hidden" id="hiddenElement" value="true"/>
<!-- SCRIPTS ON PAGE EVENT -->
<script type="text/javascript">
// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	$("a[href$='user_management/users']").parent().addClass('active');
	// PAGE RELATED SCRIPTS

	// Load form valisation dependency 
	loadScript(base_url + "template/js/plugin/jquery-form/jquery-form.min.js", runFormValidation);
	
	
	// Registration validation script
	function runFormValidation() {
		var $form1 = $("#form1").validate({
			// Rules for form validation
			rules : {
				first_name : {
					required : true
				},
				last_name : {
					required : true
				},
				username : {
					required : true
				},
				company : {
					required : true
				},
				email : {
					required : true,
					email : true
				},
				phone : {
					required : true
				}
			},

			// Messages for form validation
			messages : {
				first_name : {
					required : 'Please enter your first name'
				},
				last_name : {
					required : 'Please enter your last name'
				},
				username : {
					required : 'Please enter your username'
				},
				company : {
					required : 'Please enter your Company'
				},
				email : {
					required : 'Please enter your email address',
					email : 'Please enter a VALID email address'
				},
				phone : {
					required : 'Please enter your Phone'
				},
			},
						
			// Ajax form submition
			submitHandler : function(form) {
				var once = $("#hiddenElement").val();
				if (once == "true") {
					$(form).ajaxSubmit({
						beforeSubmit: function() {
							$("#hiddenElement").val("false");
							$("#cancel").attr("disabled","disabled");
							$("button[type=submit]").attr("disabled","disabled");
							$("button[type=submit]").append('<i class="fa fa-gear fa-1x fa-spin"></i>');
						},
						dataType: 'json',
						success : function(msg) {
							if (msg.msg == "noauth") {
								window.location = base_url;
							}
							else if (msg.error == true) {
								write_error_html(msg.field);
								
								//button manipulating
								$("#hiddenElement").val("true");
								$(".fa-spin").remove();
								$("#cancel").removeAttr("disabled");
								$("button[type=submit]").removeAttr("disabled");
							} else {
								window.location.hash = site_url + 'user_management/users/add_success';
							}
						}
					});
				}
			},

			// Do not change code below
			errorPlacement : function(error, element) {
				error.insertAfter(element.parent());
			}
		});
	}
</script>