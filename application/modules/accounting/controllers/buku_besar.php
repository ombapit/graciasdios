<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Buku_besar extends CI_Controller {
	
	function __construct()
	{
		parent::__construct();
		if (!$this->ion_auth->logged_in())
		{
			//redirect them to the login page
			echo '<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Your login is expired click <a href="'.base_url().'">here</a> to relogin.</h4>';
			die;
		}
		
		$this->load->library('Datatables');
		$this->load->model('accounting_model');
		
		//global var
		$this->module_alias = "Buku besar";
		$this->module = 'accounting/buku_besar';
	}
	
	public function check_group() {
		$group = array(1);
		if (!$this->ion_auth->in_group($group)) {
			echo '<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> You must be a part of group admin to process this action.</h4>';
			die;
		}
	}
	
	public function index()
	{
		//privilege
		$this->check_group();
		
		//check session alert
		$alert = $this->session->userdata('alert_msg');
		$this->session->unset_userdata('alert_msg');
		$alert != "" ? $disp = '' : $disp = 'display: none;';
		$data['alert_block'] = '
			<div class="alert alert-block alert-success" style="'.$disp.'" id="alert_table">
				<a href="#" data-dismiss="alert" class="close">×</a>
				<h4 class="alert-heading"><i class="fa fa-check-square-o"></i> Alert!</h4>
				<p class="alert_msg">'.$alert.'</p>
			</div>
		';
		
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		
		//load data
		$list_tahun = date('Y');
		$opt1[''] = '--Select--';
		for($i=$list_tahun-10;$i<=$list_tahun;$i++) {
			$opt1[$i] = $i;
		}
		$data['tahun'] = form_dropdown('tahun',$opt1,null,'class="select2"');
		
		$opt2 = array (
					''=>'--Select--',
					'01'=>'Januari',
					'02'=>'Februari',
					'03'=>'Maret',
					'04'=>'April',
					'05'=>'Mei',
					'06'=>'Juni',
					'07'=>'Juli',
					'08'=>'Agustus',
					'09'=>'September',
					'10'=>'Oktober',
					'11'=>'November',
					'12'=>'Desember',
				);
		$data['bulan'] = form_dropdown('bulan',$opt2,null,'class="select2"');
		
		$opt3 = $this->global_model->list_lov('ak_account','nama','idaccount','Y','nama');
		$data['idaccount'] = form_dropdown('idaccount',$opt3,null,'class="select2"');
		
		// Load the template from the views directory
        $this->parser->parse("buku_besar.tpl", $data);
	}
	
	public function get_list()
	{
		$this->check_group();
		
		if ($_POST['tahun'] == "" || $_POST['bulan'] == "" || $_POST['idaccount'] == "") {
			echo '<tr><td colspan="9">Please select Tahun / Bulan / Kode Akun</td></tr>';
			die;
		}
		
		$data['saldo_awal'] = $this->accounting_model->saldo_awal_by_acc($_POST);
		$this->parser->parse("ajax/buku_besar_list.tpl", $data);
	}
}