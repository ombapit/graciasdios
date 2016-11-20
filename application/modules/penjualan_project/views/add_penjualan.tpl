{include file="breadcrumb.tpl" icon="fa-money" bc="Transaksi <span>> Penjualan > {$cond} Penjualan Project</span>"}<!-- widget grid --><section id="widget-grid" class="">	<!-- START ROW -->	<div class="row">		<!-- NEW COL START -->		<article class="col-sm-12 col-md-12 col-lg-12">			<!-- Widget ID (each widget will need unique ID)-->			<div class="jarviswidget" id="wid-id-8" data-widget-editbutton="false" data-widget-custombutton="false">				<!-- widget options:					usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">										data-widget-colorbutton="false"						data-widget-editbutton="false"					data-widget-togglebutton="false"					data-widget-deletebutton="false"					data-widget-fullscreenbutton="false"					data-widget-custombutton="false"					data-widget-collapsed="true" 					data-widget-sortable="false"									-->				<header>					<span class="widget-icon"> <i class="fa fa-edit"></i> </span>					<h2>Transaksi Penjualan Retail</h2>													</header>				<!-- widget div-->				<div>										<!-- widget edit box -->					<div class="jarviswidget-editbox">						<!-- This area used as dropdown edit box -->											</div>					<!-- end widget edit box -->										<!-- widget content -->					<div class="widget-body">						<form class="smart-form" id="form_penjualan" method="post" action="{php}echo base_url();{/php}penjualan_project/{$stat_cond}" novalidate="novalidate">							<input type="hidden" name="idtransaksi_penjualan" id="idtransaksi_penjualan" value="{$detail['idtransaksi_penjualan']}"/>							<fieldset>								<div class="row">									<section class="col col-3">										Date										<label class="input">											<i class="icon-append fa fa-calendar"></i>											<input type="text" placeholder="Transaction Date" name="tanggal_penjualan" id="tanggal_penjualan" value="{$detail['tanggal_penjualan']}">										</label>									</section>									<section class="col col-3">										Customers										<label class="select">											<select name="idcustomer" id="idcustomer" class="select2">												{$detail['list_option_customer']}											</select>										</label>									</section>									<section class="col col-3">										PO Customer										<label class="input">											<i class="icon-append fa fa-envelope"></i>											<input type="text" placeholder="PO Customer" name="po_customer" id="po_customer" value="{$detail['po_customer']}" >										</label>									</section>								</div>							</fieldset>							<fieldset>								<div class="row">									<section class="col col-3">										Type										<label class="select">											<select id="ref_type" class="select2" onchange="readRef(this.value)">												<option value="1">Height</option>												<option value="2">Width</option>												<option value="3">Depth</option>												<option value="4">Ambalan</option>												<option value="5">Footplate</option>												<option value="6">Accessories</option>											</select>										</label>									</section>									<section class="col col-3">										Spesifikasi										<label class="select">											<select id="idref_specs" class="select2">												{$detail['list_specs']}											</select>										</label>									</section>									<section class="col col-3">										Jumlah										<label class="input">											<input type="text" placeholder="Unit Pcs" id="jumlah" value="" onkeypress="return numeralsOnly(event)">										</label>									</section>									<section class="col col-3">										Stock Location										<label class="select">											<select id="location" class="select2">												<option value="">Jakarta</option>												<option value="_sby">Surabaya</option>											</select>										</label>									</section>								</div>								<div class="row">									<section class="col col-3">											<a href="javascript:void(0);" onclick="addToList();" id="addListBtn" class="btn btn-primary"> &nbsp;&nbsp;<i class="fa fa-shopping-cart"></i> Add To List &nbsp;&nbsp;</a>									</section>								</div>							</fieldset>							<fieldset>																<div class="table-responsive">									<table class="table table-bordered table-striped">										<thead>											<tr>												<th>Type</th>												<th>Specs</th>												<th>Jumlah</th>												<th>Take From</th>												<th>Action</th>											</tr>										</thead>										<tbody id="appendData">											{$detail['list_edit']}										</tbody>									</table>																	</div>							</fieldset>																					<footer>								<div class="row">									<div class="col-md-12">										<nav>											<a id="cancel" href="{php}echo base_url();{/php}penjualan_project" class="btn btn-default">												Cancel											</a>										</nav>										<button type="submit" class="btn btn-primary">											<i class="fa fa-save"></i>											Submit										</button>									</div>								</div>							</footer>						</form>											</div>					<!-- end widget content -->									</div>				<!-- end widget div -->							</div>			<!-- end widget -->			</article>		<!-- END COL -->			</div>	<!-- END ROW --></section><!-- end widget grid --><input type="hidden" id="hiddenElement" value="true"/><input type="hidden" id="index" value="{$detail['index']}"/><!-- SCRIPTS ON PAGE EVENT --><script type="text/javascript">	var index = parseInt($("#index").val());// DO NOT REMOVE : GLOBAL FUNCTIONS!	pageSetUp();		//$("a[href$='user_management/users']").parent().addClass('active');	// PAGE RELATED SCRIPTS	// Load form valisation dependency 	loadScript(base_url + "template/js/plugin/jquery-form/jquery-form.min.js", runFormValidation);		$(document).ready(function(){		var ref_id =  $("#ref_type").val();		readRef(ref_id);	});		function addToList(){		var jumlah = $("#jumlah").val();		var location = $("#location").val();		var location_text = $("#location option:selected").text();		var type = $("#ref_type").val();		var type_text = $("#ref_type option:selected").text();		var idref_specs = $("#idref_specs").val();		var idref_text = $("#idref_specs option:selected").text();				if(!jumlah){			alert("Jumlah harus diisi");			$("#jumlah").focus();			return false;		}		//alert(idref_specs);		if(!idref_specs){			alert("Spesifikasi harus diisi");			$("#idref_specs").focus();			return false;		}		$("em").remove(".invalid");		$("#addListBtn").attr("disabled","disabled");		$.ajax({				type: "POST",				url: "penjualan_project/checkInputStock",				data: "location="+location+"&jumlah="+jumlah+"&type="+type+"&idref_specs="+idref_specs,				dataType: 'json',				success: function(msg){						if (msg.error == true) {						write_error_html(msg.field);					}					else{						var text="<tr id='list_"+index+"'>"+							"<td><input type='hidden' name='type[]' value='"+type+"' />"+type_text+"</td>"+							"<td><input type='hidden' name='idref_specs[]' value='"+idref_specs+"' />"+idref_text+"</td>"+							"<td><input type='hidden' name='jumlah[]' value='"+jumlah+"' />"+jumlah+"</td>"+							"<td><input type='hidden' name='stock[]' value='"+location+"' />"+location_text+"</td>"+							'<td><a href="javascript:void(0);" onclick="removeList('+index+');" class="btn btn-danger"> &nbsp;&nbsp;<i class="fa fa-trash-o"></i> Remove &nbsp;&nbsp;</a></td>'+						 "</tr>";						$("#appendData").append(text);						index++;					}					$("#addListBtn").removeAttr("disabled");				}		});	}		function removeList(index){		$("#list_"+index).remove();	}		function numeralsOnly(evt) {		    evt = (evt) ? evt : event;		    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 		        ((evt.which) ? evt.which : 0));		    if(charCode==46){				return true;			}			if(charCode==45){				return true;			}			if (charCode > 31 && (charCode < 48 || charCode > 57)) {		        return false;		    }		    return true;	}		function readRef(val){		$.ajax({				type: "POST",				url: "penjualan_project/readRef",				data: "idref="+val,				dataType: 'html',				success: function(msg){					var newOption = msg;					$("#idref_specs").html(newOption);					$("#idref_specs").trigger("chosen:updated");					var text = $("#idref_specs option:selected").text();					//alert(text);					$("#s2id_idref_specs .select2-chosen").html(text);				}		});	}			// Registration validation script	function runFormValidation() {		var $form1 = $("#form_penjualan").validate({			// Rules for form validation			rules : {				tanggal_penjualan : {					required : true				},				idcustomer : {					required : true				},				jumlah : {					required : true				}			},			// Messages for form validation			messages : {				tanggal_penjualan : {					required : 'Tanggal penjualan wajib diisi'				},				idcustomer : {					required : 'Nama pelanggan wajib diisi'				},				jumlah : {					required : 'Jumlah meja harus diisi dan di masukan dalam list'				}			},									// Ajax form submition			submitHandler : function(form) {				var once = $("#hiddenElement").val();				if (once == "true") {					$(form).ajaxSubmit({						beforeSubmit: function() {							$("#hiddenElement").val("false");							$("#cancel").attr("disabled","disabled");							$("button[type=submit]").attr("disabled","disabled");							$("button[type=submit]").append('<i class="fa fa-gear fa-1x fa-spin"></i>');						},						dataType: 'json',						success : function(msg) {							if (msg.msg == "noauth") {								window.location = base_url;							}							else if (msg.error == true) {								write_error_html(msg.field);																//button manipulating								$("#hiddenElement").val("true");								$(".fa-spin").remove();								$("#cancel").removeAttr("disabled");								$("button[type=submit]").removeAttr("disabled");							} else {								window.location.hash = site_url + 'penjualan_project/';							}						}					});				}			},			// Do not change code below			errorPlacement : function(error, element) {				error.insertAfter(element.parent());			}		});				$('#tanggal_penjualan').datepicker({			dateFormat : 'dd-mm-yy',			prevText : '<i class="fa fa-chevron-left"></i>',			nextText : '<i class="fa fa-chevron-right"></i>',		});	}</script>