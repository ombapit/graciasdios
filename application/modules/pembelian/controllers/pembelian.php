<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pembelian extends CI_Controller {
	
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
		$this->load->model('pembelian_model');
		
		//global var
		$this->module_alias = "Pembelian";
		$this->module = 'pembelian';
	}
	
	public function check_group() {
		$group = array(1,18);
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
        $this->parser->parse("pembelian.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('ref_code,
								   suppliers.nama_supplier as supplier,
								   tanggal_pembelian,
								   users.username as created_by,idtransaksi_pembelian')
			->edit_column('idtransaksi_pembelian', '$1', 'pembelian', 'callback_actions(idtransaksi_pembelian)')
            ->from('transaksi_pembelian')
			;
		$this->datatables->join('suppliers', 'transaksi_pembelian.idsupplier = suppliers.idsupplier', 'left');
		$this->datatables->join('users', 'transaksi_pembelian.created_by = users.id', 'left');
        echo $this->datatables->generate();
	}
	
	public function callback_actions($id){
		$module = 'pembelian';
		return '<nav class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
					<a class="btn btn-success btn-sm" href="'.base_url().$module.'/view/'.$id.'">
						<i class="fa fa-search-plus"></i> <span class="hidden-mobile">View Detail</span>
					</a>
				</nav>
				';
	}
	
	public function view()
	{
		$this->check_group();
		
		$data[''] = "";
		$id = $this->uri->segment(3);

		
		$data['cond'] = "View";
		$where = array("idtransaksi_pembelian"=>$id);
		$data['detail'] = $this->pembelian_model->get_transaction_data($id);
		$data['transaction_detail'] = $this->pembelian_model->get_transaction_data_detail($id);
		
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		
		// Load the template from the views directory
        $this->parser->parse("pembelian_view.tpl", $data);
	}

	public function add()
	{
		$this->check_group();
		
		$data[''] = "";
		$id = $this->uri->segment(3);

		if ($id != "") {
			$data['cond'] = "Edit";
			$where = array("idsupplier"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('pembelian',$where);
		} else {
			$data['cond'] = "Add";
		}
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		
		//populate tpl
		$options = $this->global_model->list_lov('suppliers','nama_supplier','idsupplier','Y','nama_supplier');
		$data['idsupplier'] = form_dropdown('idsupplier',$options,@$data['detail']['idsupplier'],'class="select2"');
		
		//populate tpl
		$options = $this->global_model->list_lov('barang','kode_barang','idbarang','Y','kode_barang');
		$data['idbarang'] = form_dropdown('idbarang[]',$options,null,'class="select2"');
		$data['idbarang_ref'] = form_dropdown('idbarang_ref',$options,null);
		
		// Load the template from the views directory
        $this->parser->parse("pembelian_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		$this->load->library('form_validation');
		
		$this->form_validation->set_rules('idbarang[]', 'Kode Barang', 'required|xss_clean');
		$this->form_validation->set_rules('jumlah[]', 'Jumlah Jakarta', 'numeric|xss_clean');
		$this->form_validation->set_rules('jumlah_sby[]', 'Jumlah Surabaya', 'numeric|xss_clean');
			
		if ($this->form_validation->run() == false) {
			$json['error'] =true;
			$errors = $this->form_validation->error_array();
			$i = 0;
			foreach ($errors as $key=>$val) {
				$json['field'][$i]['name'] = $key;
				$json['field'][$i]['message'] = $val;
				$i++;
			}
		} else {
			//call model
			$json = $this->pembelian_model->insert_pembelian($data);
		}
		echo json_encode($json);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-wrench";
		$data['bc'] = "Reference <span>> Manage Pembelian > Add Pembelian</span>";
		$data['module_alias'] = "Pembelian";
		$data['module_name'] = 'pembelian';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(3);
		//call model
		$data = $this->global_model->delete('pembelian','idsupplier',$id);
		echo json_encode($data);
	}
}