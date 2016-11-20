<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Customers extends CI_Controller {
	
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
		$this->load->model('customers_model');
		
		//global var
		$this->module_alias = "Customers";
		$this->module = 'customers';
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
		// Load the template from the views directory
        $this->parser->parse("customers.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('nama_customer,tipe_customer,alamat,telp,fax,idcustomer')
			->edit_column('tipe_customer', '$1', 'customers', 'tipe_customer(tipe_customer)')
			->edit_column('idcustomer', '$1', 'customers', 'callback_actions(idcustomer)')
            ->from('customers');
 
        echo $this->datatables->generate();
	}
	
	static public function tipe_customer($field) {
		return ucfirst($field);
	}
	static public function callback_actions($id){
		$module = 'customers';
		return '<nav class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
					<a class="btn btn-success btn-sm" href="'.base_url().$module.'/add/'.$id.'">
						<i class="fa fa-edit"></i> <span class="hidden-mobile">Edit Row</span>
					</a>
				</nav>
				<a class="btn btn-danger btn-sm" name="delete" href="javascript:void(0)" onclick="return confirm_delete(\''.$module.'\','.$id.')">
					<i class="fa fa-trash-o"></i> <span class="hidden-mobile">Delete Row</span>
				</a>
				';
	}
	
	public function add()
	{
		$this->check_group();
		
		$data[''] = "";
		$id = $this->uri->segment(3);

		if ($id != "") {
			$data['cond'] = "Edit";
			$where = array("idcustomer"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('customers',$where);
			$disabled = ' disabled="disabled"';
			
			//show contact person/jenis kelamin
			if ($data['detail']['tipe_customer'] == "pt") {
				$data['blok_contact_person'] = 'display: ""';
				$data['blok_jenis_kelamin'] = 'display: none;';
			} else if ($data['detail']['tipe_customer'] == "perseorangan") {
				$data['blok_contact_person'] = 'display: none;';
				$data['blok_jenis_kelamin'] = 'display: ""';
			}
		} else {
			$data['cond'] = "Add";
			$disabled = '';
			
			//show contact person/jenis kelamin
			$data['blok_contact_person'] = 'display: none;';
			$data['blok_jenis_kelamin'] = 'display: none;';
		}
		//jenis kelamin
		$options = array(""=>"--Select--","L"=>"Laki-laki","P"=>"Perempuan");
		$data['jenis_kelamin'] = form_dropdown('jenis_kelamin',$options,@$data['detail']['jenis_kelamin'],'class="select2"');
		
		//tipe customer
		$options = array(""=>"--Select--","pt"=>"PT","perseorangan"=>"Perseorangan");
		$data['tipe_customer'] = form_dropdown('tipe_customer',$options,@$data['detail']['tipe_customer'],'class="select2" onchange="change_type(this.value)" '.$disabled.'');
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		// Load the template from the views directory
        $this->parser->parse("customers_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		if ($this->input->post('idcustomer') == "") { //insert cond
			//unset data
			unset($data['idcustomer']);
			//call model
			$data = $this->global_model->insert('customers',$data);
		} else { //edit cond
			//call model
			$where = array("idcustomer"=>$data['idcustomer']);
			$data = $this->global_model->update('customers',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-wrench";
		$data['bc'] = "Reference <span>> Manage Customers > Add Customers</span>";
		$data['module_alias'] = "Customers";
		$data['module_name'] = 'customers';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(3);
		//call model
		$data = $this->global_model->delete('customers','idcustomer',$id);
		echo json_encode($data);
	}
}