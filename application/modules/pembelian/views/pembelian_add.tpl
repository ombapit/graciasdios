{include file="breadcrumb.tpl" icon="fa-list-alt" bc="Transaksi <span> > Pembelian > Manage {$module_alias} > {$cond} {$module_alias}</span>"}
<!-- widget grid -->
<section id="widget-grid" class="">
	<!-- START ROW -->
	<div class="row">
		<!-- NEW COL START -->
		<article class="col-sm-12 col-md-12 col-lg-12">
			<div id="pembelian_alert"></div>
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
					<h2>{$cond} {$module_alias}</h2>				
					
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
							
							<input type="hidden" name="idsupplier" id="idsupplier" value="{$detail['idsupplier']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-4">
										<label>Tanggal Pembelian</label>
										<div class="input-group">
											<input type="text" placeholder="Select a date" class="form-control datepicker" data-dateformat="dd/mm/yy" name="tanggal_pembelian" id="tanggal_pembelian"/>
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										<label>Supplier</label>
										<div>{$idsupplier}</div>
									</section>
								</div>
							</fieldset>
							<fieldset>
								<label>Detail Pembelian</label>
								<div class="table-responsive">
									<hr/><br/>
									<a class="btn btn-primary btn-sm" href="javascript:void(0)" onclick="add_row()">
										<i class="fa fa-plus"></i>
										Add Row
									</a>
									<table class="table table-bordered col-6">
										<thead>
											<tr>
												<th class="col-3">Kode Barang</th>
												<th class="col-2">Jumlah</th>
												<th class="col-1">Action</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<section>
														{$idbarang}
													</section>
												</td>
												<td>
													<section>
														<label class="input">
															Jakarta <input type="text" placeholder="Input Jumlah Jakarta" class="" name="jumlah[]" id="jumlah[]" value="0"/>
															Surabaya <input type="text" placeholder="Input Jumlah Surabaya" class="" name="jumlah_sby[]" id="jumlah_sby[]" value="0"/>
														</label>
													</section>
												</td>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
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
<div style="display: none;" id="idbarang_ref">{$idbarang_ref}</div>
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
				tanggal_pembelian : {
					required : true
				}
				,
				idsupplier : {
					required : true
				}
			},

			// Messages for form validation
			messages : {
				tanggal_pembelian : {
					required : 'Please enter your Tanggal Pembelian'
				},
				idsupplier : {
					required : 'Please enter your Supplier'
				}
			},
						
			// Ajax form submition
			submitHandler : function(form) {
				var once = $("#hiddenElement").val();
				if (once == "true") {
					$(form).ajaxSubmit({
						beforeSubmit: function() {
							/*$("#hiddenElement").val("false");
							$("#cancel").attr("disabled","disabled");
							$("button[type=submit]").attr("disabled","disabled");
							$("button[type=submit]").append('<i class="fa fa-gear fa-1x fa-spin"></i>');*/
						},
						dataType: 'json',
						success : function(msg) {
							if (msg.error == true) {
								alert_msg = '';
								$.each(msg.field, function(i, item) {
									alert_msg = alert_msg + item.message + '<br/>';
								});
								html = '<div class="alert alert-block alert-danger" id="pembelian_alert_msg">'
										+'<a href="#" data-dismiss="alert" class="close">×</a>'
										+'	<h4 class="alert-heading"><i class="glyphicon glyphicon-remove"></i> Error!</h4>'
										+'	<p>'
										+ alert_msg
										+'	</p>'
										+'</div>';
								$("#pembelian_alert").html(html);
								
								//button manipulating
								$("#hiddenElement").val("true");
								$(".fa-spin").remove();
								$("#cancel").removeAttr("disabled");
								$("button[type=submit]").removeAttr("disabled");
								$('html, body').animate({ scrollTop: 0 }, 0);
							} else if (msg.error == false) {
								window.location.hash = site_url + '{$module}/add_success';
							}
						},
						error: function(msg) {
							//window.location = base_url;
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
	
	row = 3;
	function add_row() {
		idbarang_ref = $("#idbarang_ref").html();
		idbarang_ref = str_replace('name="idbarang_ref"','name="idbarang[]" id="idbarang'+ row + '" class="select'+ row +'"',idbarang_ref);
		html_block = '<tr id="row'+ row +'">'
					+ '	<td>'
					+'		<section>' + idbarang_ref
					+'		</section>'
					+'	</td>'
					+'	<td>'
					+'		<section>'
					+'			<label class="input">'
					+'				Jakarta <input type="text" placeholder="Input Jumlah Jakarta" class="" name="jumlah[]" id="jumlah[]" value="0"/>'
					+'				Surabaya <input type="text" placeholder="Input Jumlah Surabaya" class="" name="jumlah_sby[]" id="jumlah_sby[]" value="0"/>'
					+'			</label>'
					+'		</section>'
					+'	</td>'
					+'	<td>'
					+'		<a onclick="delete_row('+ row +')" href="javascript:void(0)" class="btn btn-sm btn-danger">'
					+'			<i class="glyphicon glyphicon-remove"></i>'
					+'		</a>'
					+'	</td>'
					+'</tr>';
		$(".table tbody").append(html_block);
		
		$('.select'+row).each(function() {
			var $this = $(this);
			var width = $this.attr('data-select-width') || '100%';
			//, _showSearchInput = $this.attr('data-select-search') === 'true';
			$this.select2({
				//showSearchInput : _showSearchInput,
				allowClear : true,
				width : width
			})
		});
		row++;
	}
	
	function delete_row(row) {
		$("#row"+row).remove();
	}
</script>