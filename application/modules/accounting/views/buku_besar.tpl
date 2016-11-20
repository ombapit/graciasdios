{include file="breadcrumb.tpl" icon="fa-money" bc="Accounting <span>Settings > Manage {$module_alias}</span>"}
<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1" data-widget-editbutton="false">
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
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>List Detail</h2>

				</header>
				
				{$alert_block}

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						<div class="widget-body-toolbar">
							<div class="row">
								<form method="post" id="form1" action="{php}echo site_url();{/php}/accounting/buku_besar/get_list">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left">
									<div class="col col-lg-2">Tahun : {$tahun}</div>
									<div class="col col-lg-2">Bulan : {$bulan}</div>
									<div class="col col-lg-2">Kode Akun : {$idaccount}</div>
									<button class="btn btn-primary" type="submit">
										<i class="fa fa-search"></i> <span class="hidden-mobile">Cari</span>
									</button>
									<a href="{php}echo site_url();{/php}{$module}/add" class="btn btn-primary">
										<i class="fa fa-print"></i> <span class="hidden-mobile">Cetak</span>
									</a>
								</div>
								</form>
							</div>
						</div>
						<table class="table table-striped table-bordered smart-form">
							<thead>
								<tr>
									<th>Tanggal</th>
									<th>No.Bukti Transaksi</th>
									<th>Kode Jurnal</th>
									<th>Keterangan</th>
									<th>Kode Akun</th>
									<th>Nama Akun</th>
									<th>Debet</th>
									<th>Kredit</th>
									<th>Saldo</th>
								</tr>
							</thead>
							<tbody id="block_list">
								<tr>
									<td colspan="9">Please select Tahun / Bulan / Kode Akun</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->
		</article>
		<!-- WIDGET END -->

	</div>

	<!-- end row -->

	<!-- end row -->
	<input type="hidden" id="hiddenElement" value="true"/>
</section>
<!-- end widget grid -->

<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	// Load form valisation dependency 
	loadScript(base_url + "template/js/plugin/jquery-form/jquery-form.min.js", runFormValidation);
	
	
	// Registration validation script
	function runFormValidation() {
		var $form1 = $("#form1").validate({
			// Ajax form submition
			submitHandler : function(form) {
				var once = $("#hiddenElement").val();
				if (once == "true") {
					$(form).ajaxSubmit({
						beforeSubmit: function() {
							//$("#hiddenElement").val("false");
							//$("button[type=submit]").attr("disabled","disabled");
							//$("#block_list").html('<i class="fa fa-gear fa-1x fa-spin"></i> Loading data, Please wait..');
						},
						dataType: 'html',
						success : function(msg) {
							$("#block_list").html(msg);
							$("#hiddenElement").val("true");
							$("button[type=submit]").removeAttr("disabled");
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
</script>