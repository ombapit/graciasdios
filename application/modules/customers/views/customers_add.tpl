{include file="breadcrumb.tpl" icon="fa-book" bc="Master Data <span>> Customers > Manage {$module_alias} > {$cond} {$module_alias}</span>"}
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
					<h2>{$cond} {$module_alias} </h2>				
					
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
						<form class="smart-form" id="form1" method="post" action="{php}echo site_url();{/php}/{$module}/{$stat_cond}" novalidate="novalidate">
							<header>{$module_alias} form</header>
							
							<input type="hidden" name="idcustomer" id="idcustomer" value="{$detail['idcustomer']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-4">
										Nama Customer
										<label class="input">
											<input type="text" placeholder="Nama Customer" name="nama_customer" value="{$detail['nama_customer']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-2" id="blok_tipe_customer">
										Tipe Customer
										<label class="input">
											{$tipe_customer}
										</label>
									</section>
									<section class="col col-4" id="blok_contact_person" style="{$blok_contact_person}">
										Contact person
										<label class="input">
											<input type="text" placeholder="Contact Person" name="contact_person" value="{$detail['contact_person']}">
										</label>
									</section>
									<section class="col col-2" id="blok_jenis_kelamin" style="{$blok_jenis_kelamin}">
										Jenis Kelamin
										<label class="input">
											{$jenis_kelamin}
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										Alamat
										<label class="textarea">
											<textarea name="alamat" id="alamat" placeholder="Alamat">{$detail['alamat']}</textarea>
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										Nomor Telepon
										<label class="input">
											<input type="text" placeholder="Nomor Telepon" name="telp" id="telp" value="{$detail['telp']}">
										</label>
									</section>
									<section class="col col-4">
										Fax
										<label class="input">
											<input type="text" placeholder="Fax" name="fax" id="fax" value="{$detail['fax']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										Email
										<label class="input">
											<input type="text" placeholder="Email" name="email" id="email" value="{$detail['email']}">
										</label>
									</section>
									<section class="col col-4">
										NPWP
										<label class="input">
											<input type="text" placeholder="NPWP" name="npwp" id="npwp" value="{$detail['npwp']}">
										</label>
									</section>
								</div>
							</fieldset>
							<footer>
								<div class="row">
									<div class="col-md-12">
										<nav>
											<a id="cancel" href="{php}echo site_url();{/php}/{$module}" class="btn btn-default">
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
	
	$("a[href$='{$module}']").parent().addClass('active');
	// PAGE RELATED SCRIPTS

	// Load form valisation dependency 
	loadScript(base_url + "template/js/plugin/jquery-form/jquery-form.min.js", runFormValidation);
	
	function change_type(val) {
		if (val == "pt") {
			$("#blok_contact_person").css("display","");
			$("#blok_jenis_kelamin").css("display","none");
		} else if (val == "perseorangan") {
			$("#blok_contact_person").css("display","none");
			$("#blok_jenis_kelamin").css("display","");
		} else {
			$("#blok_contact_person").css("display","none");
			$("#blok_jenis_kelamin").css("display","none");
		}
	}
	
	// Registration validation script
	function runFormValidation() {
		var $form1 = $("#form1").validate({
			// Rules for form validation
			rules : {
				nama_customer : {
					required : true
				},
				jenis_kelamin : {
					required : true
				},
				alamat : {
					required : true
				},
				telp : {
					required : true
				},
				email : {
					required : true,
					email : true
				}
			},

			// Messages for form validation
			messages : {
				nama_customer : {
					required : 'Please enter your Nama Customer'
				},
				jenis_kelamin : {
					required : 'Please enter your Jenis Kelamin'
				},
				alamat : {
					required : 'Please enter your Alamat'
				},
				telp : {
					required : 'Please enter your Telp'
				},
				email : {
					required : 'Please enter your email address',
					email : 'Please enter a VALID email address'
				}
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
							if (msg.error == true) {
								write_error_html(msg.field);
								
								//button manipulating
								$("#hiddenElement").val("true");
								$(".fa-spin").remove();
								$("#cancel").removeAttr("disabled");
								$("button[type=submit]").removeAttr("disabled");
							} else if (msg.error == false) {
								window.location.hash = site_url + '{$module}/add_success';
							}
						},
						error: function(msg) {
							window.location = base_url;
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