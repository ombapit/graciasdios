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
							
							<input type="hidden" name="idperiode" id="idperiode" value="{$detail['idperiode']}"/>
							<fieldset>
								<div class="row">
									<section class="col col-4">
										Nama Periode
										<label class="input">
											<input type="text" placeholder="Nama Periode" name="nama_periode" value="{$detail['nama_periode']}">
										</label>
									</section>
								</div>
								<div class="row">
									<section class="col col-3">
										<label>Start Period</label>
										<div class="input-group">
											<input type="text" placeholder="Select a date" class="form-control" name="start" id="start" value="{$detail['start']}"/>
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</section>
									<section class="col col-3">
										<label>End Period</label>
										<div class="input-group">
											<input type="text" placeholder="Select a date" class="form-control" name="end" id="end" value="{$detail['end']}"/>
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
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
				nama_periode : {
					required : true
				},
				start : {
					required : true
				},
				end : {
					required : true
				}
			},

			// Messages for form validation
			messages : {
				nama_periode : {
					required : 'Please enter your Period Name'
				},
				start : {
					required : 'Please enter your Start period'
				},
				end : {
					required : 'Please enter your End period'
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
	
	$().ready(function() {
		// Date Range Picker
		$("#start").datepicker({
			dateFormat: "dd-mm-yy",
			changeMonth: true,
			prevText: '<i class="fa fa-chevron-left"></i>',
			nextText: '<i class="fa fa-chevron-right"></i>',
			onClose: function (selectedDate) {
				$("#end").datepicker("option", "minDate", selectedDate);
			}
		});
		$("#end").datepicker({
			dateFormat: "dd-mm-yy",
			changeMonth: true,
			prevText: '<i class="fa fa-chevron-left"></i>',
			nextText: '<i class="fa fa-chevron-right"></i>'
		});
	});
</script>