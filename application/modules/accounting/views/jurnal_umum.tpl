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
								<div class="col-xs-3 col-sm-2 col-md-2 col-lg-2 text-left">
									<nav>
										<a href="{php}echo site_url();{/php}/{$module}/add" class="btn btn-success">
											<i class="fa fa-plus"></i> <span class="hidden-mobile">Add New Row</span>
										</a>
									</nav>
								</div>
							</div>
						</div>
						<table id="datatable_fixed_column" class="table table-striped table-bordered smart-form">
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
									<th style="width: 190px;">Actions</th>
								</tr>
								<tr class="second">
									<td>
										<label class="input">
											<input type="text" name="tanggal_jurnal" placeholder="Filter Tanggal" class="search_init">
										</label>
									</td>
									<td>
										<input type="hidden" name="tanggal_jurnal" placeholder="Filter Tanggal" class="search_init">
									</td>
									<td>
										<input type="hidden" name="tanggal_jurnal" placeholder="Filter Tanggal" class="search_init">
									</td>
									<td>
										<input type="hidden" name="tanggal_jurnal" placeholder="Filter Tanggal" class="search_init">
									</td>
									<td>
										<label class="input">
											<input type="text" name="kode_akun" placeholder="Filter Kode Akun" class="search_init">
										</label>
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
							<tfoot>
								<tr>
									<th colspan="6" style="text-align: right;">Total</th>
									<th id="debet_block"></th>
									<th id="kredit_block"></th>
									<th>&nbsp;</th>
								</tr>
							</tfoot>
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

</section>
<!-- end widget grid -->

<script type="text/javascript">

	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	// PAGE RELATED SCRIPTS

	/* remove previous elems */
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}

	loadDataTableScripts();
	function loadDataTableScripts() {

		loadScript(base_url + "template/js/plugin/datatables/jquery.dataTables-cust.min.js", dt_7);

		function dt_7() {
			loadScript(base_url + "template/js/plugin/datatables/DT_bootstrap.js", runDataTables);
		}

	}

	function runDataTables() {
		/* Add the events etc before DataTables hides a column */
		$("#datatable_fixed_column thead input").keyup(function() {
			oTable.fnFilter(this.value, oTable.oApi._fnVisibleToColumnIndex(oTable.fnSettings(), $("thead input").index(this)));
		});

		$("#datatable_fixed_column thead input").each(function(i) {
			this.initVal = this.value;
		});
		$("#datatable_fixed_column thead input").focus(function() {
			if (this.className == "search_init") {
				this.className = "";
				this.value = "";
			}
		});
		$("#datatable_fixed_column thead input").blur(function(i) {
			if (this.value == "") {
				this.className = "search_init";
				this.value = this.initVal;
			}
		});
		
		//set debet+kredit
		var debet = 0;
		var kredit = 0;				
		var oTable = $('#datatable_fixed_column').dataTable({
            "bProcessing": true,
            "bServerSide": true,
            "sAjaxSource": site_url + '{$module}/table_list',
			"sPaginationType": "bootstrap",
            "iDisplayStart ": 20,
			"aLengthMenu": [1000],
            "oLanguage": {
                "sProcessing": "<img src='" + base_url + "template/img/ajax-loader.gif'>"
            },
            "fnInitComplete": function () {
                //oTable.fnAdjustColumnSizing();
            },
            'fnServerData': function (sSource, aoData, fnCallback) {
				//set debet+kredit
				debet = 0;
				kredit = 0;		
				$("#debet_block").html("Rp. " + NilaiRupiah(0) + ",00");
				$("#kredit_block").html("Rp. " + NilaiRupiah(0) + ",00");
				
                $.ajax
                ({
                    'dataType': 'json',
                    'type': 'POST',
                    'url': sSource,
                    'data': aoData,
                    'success': fnCallback
                });
            },
			"bSortCellsTop" : true,
			"fnCreatedRow": function( nRow, aData, iDataIndex ) {
				deb_row = explode(",",aData[6]);
				deb_row = str_replace(".","",deb_row[0]);
				debet = parseInt(deb_row) + debet;
				
				kred_row = explode(",",aData[7]);
				kred_row = str_replace(".","",kred_row[0]);
				kredit = parseInt(kred_row) + kredit;
			},
			"fnDrawCallback": function( oSettings ) {
				$("#debet_block").html("Rp. " + NilaiRupiah(debet) + ",00");
				$("#kredit_block").html("Rp. " + NilaiRupiah(kredit) + ",00");
			}
        });
		$("#datatable_fixed_column_filter").css("display","none");
		
		$('.filter_periode').each(function() {
			var $this = $(this);
			var width = $this.attr('data-select-width') || '100%';
			$this.select2({
				allowClear : true,
				width : width
			})
		});
		
		//oTable.fnFilter( $("select[name=idperiode]").val(), 0 );
	}

</script>