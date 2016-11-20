{include file="breadcrumb.tpl" icon="fa-book" bc="Master Data <span>> Product > Manage {$module_alias} > {$cond} {$module_alias}</span>"}
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
							
							<input type="hidden" name="idbarang" id="idbarang" value="{$detail['idbarang']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-2">
										Kode Barang
										<label class="input">
											<input type="text" placeholder="Kode Barang" name="kode_barang" id="kode_barang" value="{$detail['kode_barang']}">
										</label>
									</section>
									<section class="col col-4">
										Nama Barang
										<label class="input">
											<input type="text" placeholder="Nama Barang" name="nama_barang" id="nama_barang" value="{$detail['nama_barang']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-2">
										Tipe Barang
										<label class="select">
											{$tipe_barang}
										</label>
									</section>
									<section class="col col-3">
										Ukuran (MM)
										<label class="select" id="block_idref">
											<select name="idref" id="idref"><option value="">--Select--</option></select>
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-2">
										Berat (Kg)
										<label class="input">
											<input type="text" placeholder="Berat" name="berat" id="berat" value="{$detail['berat']}">
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
				kode_barang : {
					required : true
				}
				,
				nama_barang : {
					required : true
				},
				idtipe_barang : {
					required : true
				},
				idref : {
					required : true
				},
				berat : {
					required : true,
					number: true
				}
			},

			// Messages for form validation
			messages : {
				kode_barang : {
					required : 'Please enter your Kode Barang'
				}
				,
				nama_barang : {
					required : 'Please enter your Nama Barang'
				},
				idtipe_barang : {
					required : 'Please enter your Tipe Barang'
				},
				idref : {
					required : 'Please enter your Ukuran'
				},
				berat : {
					required : 'Please enter your Berat',
					number: 'Digits Only Please'
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
	
	function change_type(id,idref) {
		//jika ambalan&footplate,beda perlakuan
		$.ajax({
			type : "POST",
			url : site_url + '{$module}/change_type',
			dataType : 'html',
			data : 'idtipe_barang='+ id + "&idref="+idref,
			beforeSend : function() {
				// cog placed
				$("#block_idref").html('Populating data, please wait..');
			},
			success : function(data) {
				$("#block_idref").html(data);
			},
			error : function(xhr, ajaxOptions, thrownError) {
				$("#block_idref").html('Populating data failed, contact administrator..');
			}
		});
		return false;
	}
	{$idref_load_js}
</script>