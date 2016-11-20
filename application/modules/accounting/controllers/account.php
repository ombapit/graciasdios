<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Account extends CI_Controller {
	
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
		$this->module_alias = "Account";
		$this->module = 'accounting/account';
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
        $this->parser->parse("account.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('c.nama as group_name,b.nama as subgroup_name,d.nama as mata_uang,a.kode,a.nama as nama_account,a.idaccount')
			->edit_column('a.idaccount', '$1', 'account', 'callback_actions(a.idaccount)')
            ->from('ak_account a')
			->join('ak_subgroup b','a.idsubgroup=b.idsubgroup')
			->join('ak_group c','b.idgroup=c.idgroup')
			->join('ak_mata_uang d','a.idmata_uang=d.idmata_uang')
			;
        echo $this->datatables->generate();
	}
	
	static public function callback_actions($id){
		$module = 'accounting/account';
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
		$id = $this->uri->segment(4);
		
		if ($id != "") {
			$data['cond'] = "Edit";
			$data['detail'] = $this->accounting_model->get_account_detail($id);
			$data['idsubgroup_load_js'] = "get_child(".$data['detail']['idgroup'].",".$data['detail']['idsubgroup'].")";
		} else {
			$data['cond'] = "Add";
		}
		
		//populate tpl
		$options = $this->global_model->list_lov('ak_group','nama','idgroup','Y','nama');
		$data['idgroup'] = form_dropdown('idgroup',$options,@$data['detail']['idgroup'],'class="select2" onchange="get_child(this.value)"');
		
		$options = $this->global_model->list_lov('ak_mata_uang','nama','idmata_uang','Y','nama');
		$data['idmata_uang'] = form_dropdown('idmata_uang',$options,@$data['detail']['idmata_uang'],'class="select2"');
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		// Load the template from the views directory
        $this->parser->parse("account_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		
		//unset
		unset($data['idgroup']);
		if ($this->input->post('idaccount') == "") { //insert cond
			//unset data
			unset($data['idaccount']);
			//call model
			$data = $this->global_model->insert('ak_account',$data);
		} else { //edit cond
			//call model
			$where = array("idaccount"=>$data['idaccount']);
			$data = $this->global_model->update('ak_account',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-money";
		$data['bc'] = "Accounting <span>> Settings > Manage Account > Add Account</span>";
		$data['module_alias'] = "Account";
		$data['module_name'] = 'accounting/account';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(4);
		//call model
		$data = $this->global_model->delete('ak_account','idaccount',$id);
		echo json_encode($data);
	}
	
	public function get_child()
	{
		$id = $this->input->post('idgroup');
		$idsubgroup = $this->input->post('idsubgroup');
		if ($idsubgroup == "undefined") {
			echo $this->accounting_model->ajax_select('idsubgroup',$id);
		} else {
			echo $this->accounting_model->ajax_select('idsubgroup',$id,$idsubgroup);
		}
	}
}