{include file="breadcrumb.tpl" icon="fa-home" bc="Dashboard <span>> My Dashboard</span>"}
<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">
		<article class="col-sm-12">
			<!-- new widget -->
			<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
					<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
					<h2> My Chart </h2>

					<ul class="nav nav-tabs pull-right in" id="myTab">
						<li class="active">
							<a data-toggle="tab" href="#s1"><i class="fa fa-dashboard"></i> <span class="hidden-mobile hidden-tablet">Penjualan</span></a>
						</li>
						<li>
							<a data-toggle="tab" href="#s2"><i class="fa fa-dashboard"></i> <span class="hidden-mobile hidden-tablet">Pembelian</span></a>
						</li>
					</ul>

				</header>

				<!-- widget div-->
				<div class="no-padding">
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						test
					</div>
					<!-- end widget edit box -->

					<div class="widget-body">
						<!-- content -->
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane active" id="s1">
								<div class="widget-body-toolbar" style="height: 70px;">
									<form name="form_search" id="form_search" onsubmit="return go_submit()">
									<div class="col-sm-12">
										<label>Select a date (range):</label>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<div class="input-group">
												<input class="form-control" id="from" type="text" placeholder="From" value="{$from}">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>

									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<div class="input-group">
												<input class="form-control" id="to" type="text" placeholder="To" value="{$to}">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>

									</div>
									<div class="col-sm-3">
										<button class="btn btn-primary" type="submit">Search</button>
									</div>
									</form>
								</div>
								<div class="widget-body-toolbar bg-color-white smart-form" id="rev-toggles">
										<div class="inline-group">
										<label for="gra-0" class="checkbox">
											<input type="checkbox" name="gra-0" id="gra-0" checked="checked">
											<i></i> Upright (Height) </label>
										<label for="gra-1" class="checkbox">
											<input type="checkbox" name="gra-1" id="gra-1" checked="checked">
											<i></i> Beam (Width) </label>
										<label for="gra-2" class="checkbox">
											<input type="checkbox" name="gra-2" id="gra-2" checked="checked">
											<i></i> Beam (Depth) </label>
										<label for="gra-3" class="checkbox">
											<input type="checkbox" name="gra-3" id="gra-3" checked="checked">
											<i></i> Ambalan </label>
										<label for="gra-4" class="checkbox">
											<input type="checkbox" name="gra-4" id="gra-4" checked="checked">
											<i></i> Footplate </label>

									</div>

									<!--<div class="btn-group hidden-phone pull-right">
										<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> More <span class="caret"> </span> </a>
										<ul class="dropdown-menu pull-right">
											<li>
												<a href="javascript:void(0);"><i class="fa fa-file-text-alt"></i> Export to PDF</a>
											</li>
											<li>
												<a href="javascript:void(0);"><i class="fa fa-question-sign"></i> Help</a>
											</li>
										</ul>
									</div>-->

								</div>

								<div class="padding-10">
									<div id="flotcontainer" class="chart-large has-legend-unique"></div>
								</div>
							</div>
							<!-- end s1 tab pane -->
							
							<div class="tab-pane" id="s2">
								<div class="widget-body-toolbar" style="height: 70px;">
									<form name="form_search" id="form_search2" onsubmit="return go_submit()">
									<div class="col-sm-12">
										<label>Select a date (range):</label>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<div class="input-group">
												<input class="form-control" id="from2" type="text" placeholder="From" value="{$from}">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>

									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<div class="input-group">
												<input class="form-control" id="to2" type="text" placeholder="To" value="{$to}">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>

									</div>
									<div class="col-sm-3">
										<button class="btn btn-primary" type="submit">Search</button>
									</div>
									</form>
								</div>
								<div class="widget-body-toolbar bg-color-white smart-form" id="rev-toggles2">
										<div class="inline-group">
										<label for="grb-0" class="checkbox">
											<input type="checkbox" name="grb-0" id="grb-0" checked="checked">
											<i></i> Upright (Height) </label>
										<label for="grb-1" class="checkbox">
											<input type="checkbox" name="grb-1" id="grb-1" checked="checked">
											<i></i> Beam (Width) </label>
										<label for="grb-2" class="checkbox">
											<input type="checkbox" name="grb-2" id="grb-2" checked="checked">
											<i></i> Beam (Depth) </label>
										<label for="grb-3" class="checkbox">
											<input type="checkbox" name="grb-3" id="grb-3" checked="checked">
											<i></i> Ambalan </label>
										<label for="grb-4" class="checkbox">
											<input type="checkbox" name="grb-4" id="grb-4" checked="checked">
											<i></i> Footplate </label>

									</div>

									<!--<div class="btn-group hidden-phone pull-right">
										<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> More <span class="caret"> </span> </a>
										<ul class="dropdown-menu pull-right">
											<li>
												<a href="javascript:void(0);"><i class="fa fa-file-text-alt"></i> Export to PDF</a>
											</li>
											<li>
												<a href="javascript:void(0);"><i class="fa fa-question-sign"></i> Help</a>
											</li>
										</ul>
									</div>-->

								</div>

								<div class="padding-10">
									<div id="flotcontainer2" class="chart-large has-legend-unique"></div>
								</div>
							</div>
							<!-- end s2 tab pane -->
						</div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>
	</div>

	<!-- end row -->
</section>
<!-- end widget grid -->

<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	/*
	 * RUN PAGE GRAPHS
	 */
	
	// Load FLOAT dependencies (related to page)
	loadScript("{php}echo base_url();{/php}template/js/plugin/flot/jquery.flot.cust.js", loadFlotResize);
	
	function loadFlotResize() {
	    loadScript("{php}echo base_url();{/php}template/js/plugin/flot/jquery.flot.resize.js", loadFlotToolTip);
	}
	
	function loadFlotToolTip() {
	    loadScript("{php}echo base_url();{/php}template/js/plugin/flot/jquery.flot.tooltip.js", generatePageGraphs);
	}
	
	upright = '';
	width = '';
	depth = '';
	ambalan = '';
	footplate = '';
	function load_json(module,type,callback) {
		url = '{php}echo site_url();{/php}/{$module}/'+ module;
		$.ajax({
			type : "POST",
			url : url,
			data : "type="+ type + "&from=" + $("#from").val() + "&to=" + $("#to").val(),
			dataType : 'html',
			beforeSend : function() {
			},
			success : function(data) {
				window[module] = data;
				if (callback) {
					//execute function
					callback('rev-toggles','flotcontainer');
				}
			},
			error : function(xhr, ajaxOptions, thrownError) {
			}
		});
	}
	function load_json2(module,type,callback) {
		url = '{php}echo site_url();{/php}/{$module}/'+ module;
		$.ajax({
			type : "POST",
			url : url,
			data : "type="+ type + "&from=" + $("#from2").val() + "&to=" + $("#to2").val(),
			dataType : 'html',
			beforeSend : function() {
			},
			success : function(data) {
				window[module] = data;
				if (callback) {
					//execute function
					callback('rev-toggles2','flotcontainer2');
				}
			},
			error : function(xhr, ajaxOptions, thrownError) {
			}
		});
	}
	
	wait = false;
	function generatePageGraphs() {
	    $(function () {
			//run script penjualan&pembelian
			load_json('upright','keluar',loadWidth);
			function loadWidth() {
				load_json('width','keluar',loadDepth);
			}
			function loadDepth() {
				load_json('depth','keluar',loadAmbalan);
			}
			function loadAmbalan() {
				load_json('ambalan','keluar',loadFootplate);
			}
			function loadFootplate() {
				load_json('footplate','keluar',populate_graph);
			}
			function populate_graph(toggle,container) {
				upright = jQuery.parseJSON(upright);
				width = jQuery.parseJSON(width);
				depth = jQuery.parseJSON(depth);
				ambalan = jQuery.parseJSON(ambalan);
				footplate = jQuery.parseJSON(footplate);
				
				toggles = $("#"+toggle),height = $("#"+container);

				var data = [{
					label: "Height",
					data: upright,
					color: '#3276B1',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Width",
					data: width,
					color: '#FF0000',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Depth",
					data: depth,
					color: '#00FF40',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Ambalan",
					data: ambalan,
					color: '#FF8040',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Foot Plate",
					data: footplate,
					color: '#000000',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}]

				var options = {
					grid: {
						hoverable: true
					},
					tooltip: true,
					tooltipOpts: {
						content: 'Total Penjualan %x: %y buah',
						dateFormat: '%d %b %y',
						defaultTheme: false
					},
					xaxis: {
						mode: "time"
					},
					yaxis: {
						tickFormatter: function (val, axis) {
							return val;
						}
						//max: 5
					}

				};

				plot = null;
				toggles.find(':checkbox').on('change', function () {
					plotNow();
				});
				plotNow()
				
				function plotNow() {
					var d = [];
					toggles.find(':checkbox').each(function () {
						if ($(this).is(':checked')) {
							d.push(data[$(this).attr("name").substr(4, 1)]);
						}
					});
					if (d.length >= 0) {
						if (plot) {
							plot.setData(d);
							plot.draw();
						} else {
							plot = $.plot(height, d, options);
						}
					}
				}
				
				//next chart
				if (toggle == 'rev-toggles') {
					build_pembelian();
				}
			}
			
			function populate_graph2(toggle,container) {
				upright2 = jQuery.parseJSON(upright);
				width2 = jQuery.parseJSON(width);
				depth2 = jQuery.parseJSON(depth);
				ambalan2 = jQuery.parseJSON(ambalan);
				footplate2 = jQuery.parseJSON(footplate);
				
				toggles2 = $("#"+toggle),height2 = $("#"+container);

				var data = [{
					label: "Height",
					data: upright2,
					color: '#3276B1',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Width",
					data: width2,
					color: '#FF0000',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Depth",
					data: depth2,
					color: '#00FF40',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Ambalan",
					data: ambalan2,
					color: '#FF8040',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}, {
					label: "Foot Plate",
					data: footplate2,
					color: '#000000',
					lines: {
						show: true,
						lineWidth: 1
					},
					points: {
						show: true
					}
				}]

				var options2 = {
					grid: {
						hoverable: true
					},
					tooltip: true,
					tooltipOpts: {
						content: 'Total Pembelian %x: %y buah',
						dateFormat: '%d %b %y',
						defaultTheme: false
					},
					xaxis: {
						mode: "time"
					},
					yaxis: {
						tickFormatter: function (val, axis) {
							return val;
						}
						//max: 5
					}

				};

				plot2 = null;
				toggles2.find(':checkbox').on('change', function () {
					plotNow2();
				});
				plotNow2()
				
				function plotNow2() {
					var d = [];
					toggles2.find(':checkbox').each(function () {
						if ($(this).is(':checked')) {
							d.push(data[$(this).attr("name").substr(4, 1)]);
						}
					});
					if (d.length >= 0) {
						if (plot2) {
							plot2.setData(d);
							plot2.draw();
						} else {
							plot2 = $.plot(height2, d, options2);
						}
					}
				}
				
				//next chart
				if (toggle == 'rev-toggles') {
					build_pembelian();
				}
			}
			
			//function pembelian
			function build_pembelian() {
				load_json('upright','masuk',loadWidth);
				function loadWidth() {
					load_json('width','masuk',loadDepth);
				}
				function loadDepth() {
					load_json('depth','masuk',loadAmbalan);
				}
				function loadAmbalan() {
					load_json('ambalan','masuk',loadFootplate);
				}
				function loadFootplate() {
					load_json2('footplate','masuk',populate_graph2);
				}
			}
			
			// Date Range Picker
			$("#from").datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				prevText: '<i class="fa fa-chevron-left"></i>',
				nextText: '<i class="fa fa-chevron-right"></i>',
				onClose: function (selectedDate) {
					$("#to").datepicker("option", "minDate", selectedDate);
				}
			});
			$("#to").datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				prevText: '<i class="fa fa-chevron-left"></i>',
				nextText: '<i class="fa fa-chevron-right"></i>'
			});
			
			$("#from2").datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				prevText: '<i class="fa fa-chevron-left"></i>',
				nextText: '<i class="fa fa-chevron-right"></i>',
				onClose: function (selectedDate) {
					$("#to").datepicker("option", "minDate", selectedDate);
				}
			});
			$("#to2").datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				prevText: '<i class="fa fa-chevron-left"></i>',
				nextText: '<i class="fa fa-chevron-right"></i>'
			});
	    });
	}
	
	function go_submit() {
		generatePageGraphs();
	}
</script>