<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Suppliers extends CI_Controller {
	
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
		$this->load->model('suppliers_model');
		
		//global var
		$this->module_alias = "Suppliers";
		$this->module = 'suppliers';
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
        $this->parser->parse("suppliers.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('nama_supplier,alamat,nama_tipe,telp,fax,idsupplier')
			->edit_column('idsupplier', '$1', 'suppliers', 'callback_actions(idsupplier)')
            ->from('suppliers')
			->join('suppliers_type', 'suppliers.idsupplier_type = suppliers_type.idsupplier_type');
 
        echo $this->datatables->generate();
	}
	
	static public function callback_actions($id){
		$module = 'suppliers';
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
			$where = array("idsupplier"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('suppliers',$where);
		} else {
			$data['cond'] = "Add";
		}
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		
		//populate tpl
		$options = $this->global_model->list_lov('suppliers_type','nama_tipe','idsupplier_type','Y','nama_tipe');
		$data['idsupplier_type'] = form_dropdown('idsupplier_type',$options,@$data['detail']['idsupplier_type'],'class="select2"');
		
		// Load the template from the views directory
        $this->parser->parse("suppliers_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		if ($this->input->post('idsupplier') == "") { //insert cond
			//unset data
			unset($data['idsupplier']);
			//call model
			$data = $this->global_model->insert('suppliers',$data);
		} else { //edit cond
			//call model
			$where = array("idsupplier"=>$data['idsupplier']);
			$data = $this->global_model->update('suppliers',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-wrench";
		$data['bc'] = "Reference <span>> Manage Suppliers > Add Suppliers</span>";
		$data['module_alias'] = "Suppliers";
		$data['module_name'] = 'suppliers';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(3);
		//call model
		$data = $this->global_model->delete('suppliers','idsupplier',$id);
		echo json_encode($data);
	}
}