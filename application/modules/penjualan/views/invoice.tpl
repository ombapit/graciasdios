<link href="{php}echo base_url();{/php}template/css/invoice.css" rel="stylesheet">

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget well jarviswidget-color-darken" id="wid-id-0" data-widget-sortable="false" data-widget-deletebutton="false" data-widget-editbutton="false" data-widget-colorbutton="false">
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
					<span class="widget-icon"> <i class="fa fa-barcode"></i> </span>
					<h2>Item #44761 </h2>

				</header>

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

								

								<div class="col-sm-12 text-align-right">

									<div class="btn-group">
										<a href="#penjualan/view/{$penjualan['idtransaksi_penjualan']}" class="btn btn-sm btn-primary"> <i class="fa fa-edit"></i> Back To List </a>
									</div>

								</div>

							</div>

						</div>

						<div class="padding-10">
							<div class="pull-right"><strong>Kode dan Nomor Seri Faktur Pajak: 010.000-14.93359740</strong></div>
							<br>
							
							<div class="pull-left">
								

								<address>
									<strong>Pengusaha Kena Pajak : </strong>
									<br>
									<strong>PT Gracias Dios</strong>
									<br>
									GD. Duta Group Jl. Lebak Bulus Raya Blok L-15 RT 011 RW 007, Lebak Bulus, Cilandak
									<br>
									Jakarta Selatan, DKI Jakarta Raya
									<br>
									NPWP : 31.335.276.7-016.000
								</address>
							</div>
							<div class="pull-right">
								<h1 class="font-400">invoice</h1>
							</div>
							<div class="clearfix"></div>
							<br>
							<br>
							<div class="row">
								<div class="col-sm-9">
									<strong>Pembeli Barang Kena Pajak : </strong>
									<address>
										<strong>{$customer['nama_customer']}</strong>
										<br>
										{$customer['alamat']}
										<br>
										Bogor, Indonesia
										<br>
										<abbr title="Phone">P:</abbr> {$customer['telp']}
									</address>
								</div>
								<div class="col-sm-3">
									<div>
										<div>
											<strong>INVOICE NO :</strong>
											<span class="pull-right">  </span>
										</div>

									</div>
									<div>
										<div class="font-md">
											<strong>INVOICE DATE :</strong>
											<span class="pull-right"> <i class="fa fa-calendar"></i> {$penjualan['tanggal_penjualan']} </span>
										</div>

									</div>
									<br>
									<div class="well well-sm  bg-color-darken txt-color-white no-border">
										<div class="fa-lg">
											Total Due :
											<span class="pull-right"> Rp. 1.980.000 </span>
										</div>

									</div>
									<br>
									<br>
								</div>
							</div>
							<table class="table table-hover">
								<thead>
									<tr>
										<th class="text-center">QTY</th>
										<th>ITEM</th>
										<th>DESCRIPTION</th>
										<th>PRICE</th>
										<th>SUBTOTAL</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-center"><strong>1</strong></td>
										<td><a href="javascript:void(0);">Print and Web Logo Design</a></td>
										<td>Perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam xplicabo.</td>
										<td>$1,300.00</td>

										<td>$1,300.00</td>
									</tr>
									<tr>
										<td class="text-center"><strong>1</strong></td>
										<td><a href="javascript:void(0);">SEO Management</a></td>
										<td>Sit voluptatem accusantium doloremque laudantium inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</td>
										<td>$1,400.00</td>
										<td>$1,400.00</td>
									</tr>
									<tr>
										<td class="text-center"><strong>1</strong></td>
										<td><a href="javascript:void(0);">Backend Support and Upgrade</a></td>
										<td>Inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</td>
										<td>$1,700.00</td>
										<td>$1,700.00</td>
									</tr>
									<tr>
										<td colspan="4">Total</td>
										<td><strong>$4,400.00</strong></td>
									</tr>
									<tr>
										<td colspan="4">HST/GST</td>
										<td><strong>13%</strong></td>
									</tr>
								</tbody>
							</table>

							<div class="invoice-footer">

								<div class="row">

									<div class="col-sm-7">
										<div class="payment-methods">
											<h5>Payment Methods</h5>
											<img src="img/invoice/paypal.png" width="64" height="64" alt="paypal">
											<img src="img/invoice/americanexpress.png" width="64" height="64" alt="american express">
											<img src="img/invoice/mastercard.png" width="64" height="64" alt="mastercard">
											<img src="img/invoice/visa.png" width="64" height="64" alt="visa">
										</div>
									</div>
									<div class="col-sm-5">
										<div class="invoice-sum-total pull-right">
											<h3><strong>Total: <span class="text-success">$4,972 USD</span></strong></h3>
										</div>
									</div>

								</div>
								
								<div class="row">
									<div class="col-sm-12">
										<p class="note">**To avoid any excess penalty charges, please make payments within 30 days of the due date. There will be a 2% interest charge per month on all late invoices.</p>
									</div>
								</div>

							</div>
						</div>

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

</section>
<!-- end widget grid -->

<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();

	// PAGE RELATED SCRIPTS

</script>
