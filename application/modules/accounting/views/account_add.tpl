{include file="breadcrumb.tpl" icon="fa-money" bc="Accounting <span>Settings > Manage {$module_alias} > {$cond} {$module_alias}</span>"}
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
							
							<input type="hidden" name="idaccount" id="idaccount" value="{$detail['idaccount']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-3">
										Nama Group
										<label class="input">
											{$idgroup}
										</label>
									</section>
									<section class="col col-4">
										Nama Subgroup
										<label class="select" id="block_idsubgroup">
											<select name="idsubgroup" id="idsubgroup" class="select2"><option value="">--Select--</option></select>
										</label>
									</section>
									<section class="col col-2">
										Mata Uang
										<label class="input">
											{$idmata_uang}
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-3">
										Kode Account
										<label class="input">
											<input type="text" placeholder="Kode Account" name="kode" value="{$detail['kode']}">
										</label>
									</section>
									<section class="col col-4">
										Nama Account
										<label class="input">
											<input type="text" placeholder="Nama Account" name="nama" value="{$detail['nama']}">
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
	
	
	// Registration validation script
	function runFormValidation() {
		var $form1 = $("#form1").validate({
			// Rules for form validation
			rules : {
				idgroup : {
					required : true
				},
				idsubgroup : {
					required : true
				},
				idmata_uang : {
					required : true
				},
				kode : {
					required : true
				},
				nama : {
					required : true
				}
			},

			// Messages for form validation
			messages : {
				idgroup : {
					required : 'Please enter your Group'
				},
				idsubgroup : {
					required : 'Please enter your Sub group'
				},
				idmata_uang : {
					required : 'Please enter your Mata Uang'
				},
				kode : {
					required : 'Please enter your Kode Account'
				},
				nama : {
					required : 'Please enter your Nama Account'
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
							window.location = site_url;
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
	
	function get_child(idgroup,idsubgroup) {
		//jika ambalan&footplate,beda perlakuan
		$.ajax({
			type : "POST",
			url : site_url + '{$module}/get_child',
			dataType : 'html',
			data : 'idgroup='+ idgroup + "&idsubgroup="+idsubgroup,
			beforeSend : function() {
				// cog placed
				$("#block_idsubgroup").html('Populating data, please wait..');
			},
			success : function(data) {
				$("#block_idsubgroup").html(data);
				
				$('.sel'+idgroup).each(function() {
					var $this = $(this);
					var width = $this.attr('data-select-width') || '100%';
					$this.select2({
						allowClear : true,
						width : width
					})
				});
			},
			error : function(xhr, ajaxOptions, thrownError) {
				$("#block_idsubgroup").html('Populating data failed, contact administrator..');
			}
		});
		return false;
	}
	{$idsubgroup_load_js}
</script>