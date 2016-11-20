{include file="breadcrumb.tpl" icon="fa-money" bc="Accounting <span>Settings > Manage {$module_alias} > {$cond} {$module_alias}</span>"}
<!-- widget grid -->
<section id="widget-grid" class="">
	<!-- START ROW -->
	<div class="row">
		<!-- NEW COL START -->
		<article class="col-sm-12 col-md-12 col-lg-12">
			<div id="ju_alert"></div>
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
							
							<input type="hidden" name="idjurnal" id="idjurnal" value="{$detail['idjurnal']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-2">
										Periode
										<label class="select">
											{$idperiode}
										</label>
									</section>
									<section class="col col-2">
										Tanggal
										<div class="input-group">
											<input type="text" placeholder="Select a date" class="form-control datepicker" data-dateformat="dd/mm/yy" name="tanggal_jurnal" id="tanggal_jurnal"/>
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										Kode Jurnal
										<label class="select">
											{$idtipe_jurnal}
										</label>
									</section>
									<section class="col col-2">
										No Bukti
										<label class="input">
											<input type="text" placeholder="No. Bukti" name="no_bukti" value="{$detail['no_bukti']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										Keterangan
										<label class="textarea">
											<textarea name="keterangan">{$detail['keterangan']}</textarea>
										</label>
									</section>
								</div>
							</fieldset>
							<fieldset>
								<label>Jurnal Detail</label>
								<div class="table-responsive">
									<hr/><br/>
									<a class="btn btn-primary btn-sm" href="javascript:void(0)" onclick="add_row()">
										<i class="fa fa-plus"></i>
										Add Row
									</a>
									<table class="table table-bordered col-6">
										<thead>
											<tr>
												<th class="col-3">Account Name</th>
												<th class="col-2">Debet</th>
												<th class="col-2">Kredit</th>
												<th class="col-1">Action</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<section>
														{$idaccount}
													</section>
												</td>
												<td>
													<section>
														<label class="input">
															<input type="text" placeholder="Input Debet" name="debet[]" class="debet" onblur="sum_debet()" onkeypress="return numeralsOnly(event)"/>
														</label>
													</section>
												</td>
												<td>
													<section>
														<label class="input">
															<input type="text" placeholder="Input Kredit" name="kredit[]" class="kredit" onblur="sum_kredit()" onkeypress="return numeralsOnly(event)"/>
														</label>
													</section>
												</td>
												<td>&nbsp;</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<th style="text-align: right;">Saldo</th>
												<th id="block_debet"></th>
												<th id="block_kredit"></th>
										</tfoot>
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
<div style="display: none;" id="idaccount_ref">{$idaccount_ref}</div>
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
				idperiode : {
					required : true
				},
				tanggal_jurnal : {
					required : true
				},
				idtipe_jurnal : {
					required : true
				},
				no_bukti : {
					required : true
				}
			},

			// Messages for form validation
			messages : {
				idperiode : {
					required : 'Please enter your Periode'
				},
				tanggal_jurnal : {
					required : 'Please enter your Tanggal'
				},
				idtipe_jurnal : {
					required : 'Please enter your Kode Jurnal'
				},
				no_bukti : {
					required : 'Please enter your No Bukti'
				}
			},
						
			// Ajax form submition
			submitHandler : function(form) {
				var once = $("#hiddenElement").val();
				if (once == "true") {
					$(form).ajaxSubmit({
						beforeSubmit: function() {
							//$("#hiddenElement").val("false");
							//$("#cancel").attr("disabled","disabled");
							//$("button[type=submit]").attr("disabled","disabled");
							//$("button[type=submit]").append('<i class="fa fa-gear fa-1x fa-spin"></i>');
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
								$("#ju_alert").html(html);
								
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
		idaccount_ref = $("#idaccount_ref").html();
		idaccount_ref = str_replace('name="idaccount_ref"','name="idaccount[]" id="idaccount'+ row + '" class="select'+ row +'"',idaccount_ref);
		html_block = '<tr id="row'+ row +'">'
					+ '	<td>'
					+'		<section>' + idaccount_ref
					+'		</section>'
					+'	</td>'
					+'	<td>'
					+'		<section>'
					+'			<label class="input">'
					+'				<input type="text" placeholder="Input Debet" name="debet[]" class="debet" onblur="sum_debet()" onkeypress="return numeralsOnly(event)"/>'
					+'			</label>'
					+'		</section>'
					+'	</td>'
					+'	<td>'
					+'		<section>'
					+'			<label class="input">'
					+'				<input type="text" placeholder="Input Kredit" name="kredit[]" class="kredit" onblur="sum_kredit()" onkeypress="return numeralsOnly(event)"/>'
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
		
	function sum_debet() {
		var tot_debet = 0;
		$('.debet').each(function(index, value){
			if (this.value == "") {
				this.value = 0;
			}
			tot_debet = tot_debet + parseInt(this.value);
		});
		$("#block_debet").html(NilaiRupiah(tot_debet));
	}
	
	function sum_kredit() {
		var tot_kredit = 0;
		$('.kredit').each(function(index, value){
			if (this.value == "") {
				this.value = 0;
			}
			tot_kredit = tot_kredit + parseInt(this.value);
		});
		$("#block_kredit").html(NilaiRupiah(tot_kredit));
	}
	
	function delete_row(row) {
		$("#row"+row).remove();
	}
</script>