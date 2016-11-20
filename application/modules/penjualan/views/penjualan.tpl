{include file="breadcrumb.tpl" icon="fa-group" bc="Transaction <span>> Penjualan Retail</span>"}
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
					<h2>Sales List</h2>
				</header>
				
				{$alert_block}
				
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						<div class="widget-body-toolbar" align="right" style="padding-right:80px">
							<nav>
								<a href="{base_url()}penjualan/add" class="btn btn-success" style="padding:2px 5px 2px 5px">
									<i class="fa fa-plus"></i> <span class="hidden-mobile">Add New Row</span>
								</a>
							</nav>
						</div>
					
						<table id="datatable_fixed_column" class="table table-striped table-bordered smart-form">
							<thead>
								<tr>
									<th>Ref TRX</th>
									<th>PO Customer</th> 
									<th>Customer</th>
									<th>Jumlah</th>
									<th>Tanggal</th>
									<th>Status</th>
									<th>Created By</th>
									<th style="width: 190px">Actions</th>
								</tr>
								<!--<tr class="second">
									<td>
										<label class="input">
											<input type="text" name="ref_code" value="Trx Code" class="search_init">
										</label>
									</td>
									<td>
										<label class="input">
											<input type="text" name="customer" value="Customer Name" class="search_init">
										</label>	
									</td>
									<td>
										<label class="input">
											<input type="text" name="jumlah" value="Jumlah" class="search_init">
										</label>	
									</td>
									<td>
										<label class="input">
											<input type="text" name="tanggal_penjualan" value="Tanggal" class="search_init">
										</label>	
									</td>
									<td>
										<label class="input">
											<input type="text" name="status" value="Status" class="search_init">
										</label>	
									</td>
									<td>
										<label class="input">
											<input type="text" name="created_by" value="Created By" class="search_init">
										</label>	
									</td>
									<td>
										&nbsp;
									</td>
								</tr>-->
								
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">View Transaction</h4>
			</div>
			<div class="modal-body">
			</div>
		</div>
	</div>
</div>
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
		
		var oTable = $('#datatable_fixed_column').dataTable({
            "bProcessing": true,
            "bServerSide": true,
            "sAjaxSource": base_url + 'penjualan/table_list',
			"sPaginationType": "bootstrap",
            "iDisplayStart ": 20,
            "oLanguage": {
                "sProcessing": "<img src='" + base_url + "template/img/ajax-loader.gif'>"
            },
            "fnInitComplete": function () {
                //oTable.fnAdjustColumnSizing();
            },
            'fnServerData': function (sSource, aoData, fnCallback) {
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
        });
		
		$('#datatable_fixed_column_filter input')
		.unbind('keypress keyup')
		.bind('keypress keyup', function(e){
		  if (e.keyCode != 13) return;
		  oTable.fnFilter($(this).val());
		});
	}
</script>