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
						<form class="smart-form" id="form1">
							<header>{$module_alias} form</header>
							
							<input type="hidden" name="idsupplier" id="idsupplier" value="{$detail['idsupplier']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-4">
										<label class="col-6">Tanggal Pembelian</label>{$detail['tanggal_pembelian']}
									</section>
								</div>
								<div class="row">
									<section class="col col-4">
										<label class="col-6">Supplier</label>{$detail['nama_supplier']}
									</section>
								</div>
							</fieldset>
							<fieldset>
								<label>Detail Pembelian</label>
								<div class="table-responsive">
									<hr/><br/>
									<table class="table table-bordered col-6">
										<thead>
											<tr>
												<th class="col-2">Kode Barang</th>
												<th class="col-3">Nama Barang</th>
												<th class="col-1">Jumlah</th>
											</tr>
										</thead>
										<tbody>
											{$transaction_detail}
										</tbody>
									</table>
								</div>
							</fieldset>
							<footer>
								<div class="row">
									<div class="col-md-12">
										<nav>
											<a id="cancel" href="{php}echo site_url();{/php}/{$module}" class="btn btn-default">
												Back to list
											</a>
										</nav>
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
<!-- SCRIPTS ON PAGE EVENT -->
<script type="text/javascript">
// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	$("a[href$='{$module}']").parent().addClass('active');
</script>