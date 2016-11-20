<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Stock extends CI_Controller {
	
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
		$this->load->model('stock_model');
		
		//global var
		$this->module_alias = "Stock";
		$this->module = 'stock';
	}
	
	public function check_group() {
		$group = array(1,17);
		if (!$this->ion_auth->in_group($group)) {
			echo '<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> You don\'t have access to process this action.</h4>';
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
		// Load the template from the views directory
        $this->parser->parse("stock.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('nama_tipe,kode_barang,nama_barang,idref,berat,quantity,quantity_sby')
			 ->edit_column('idref', '$1', 'stock', 'callback_ukuran(nama_tipe,idref)')
             ->from('barang')
			;
		$this->datatables->join('tipe_barang', 'barang.idtipe_barang = tipe_barang.idtipe_barang');
 
        echo $this->datatables->generate();
	}
	
	public function callback_ukuran($val,$val2) {
		$ci =& get_instance();
		//get id from nama
		$tb = $ci->global_model->get_detail_data('tipe_barang',array('nama_tipe'=>$val));
		$data = $ci->global_model->get_detail_data($tb['related_table'],array('idref'=>$val2));
		return $data['nilai'];
	}
}