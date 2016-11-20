<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Saldo_awal extends CI_Controller {
	
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
		$this->module_alias = "Saldo awal";
		$this->module = 'accounting/saldo_awal';
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
		
		//load filter period
		$options = $this->global_model->list_lov('ak_periode','nama_periode','nama_periode','Y','nama_periode');
		$key = array_keys($options);
		$data['filter_periode'] = form_dropdown('idperiode',$options,$key[1],'class="search_init filter_periode"');
		
		// Load the template from the views directory
        $this->parser->parse("saldo_awal.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('b.nama_periode,c.kode,c.nama,a.debet,a.kredit,a.idsaldo_awal')
			->edit_column('a.debet', '$1', 'saldo_awal', 'number_format(a.debet, 2, ",", ".")')
			->edit_column('a.kredit', '$1', 'saldo_awal', 'number_format(a.kredit, 2, ",", ".")')
			->edit_column('a.idsaldo_awal', '$1', 'saldo_awal', 'callback_actions(a.idsaldo_awal)')
            ->from('ak_saldo_awal a')
			->join('ak_periode b','a.idperiode=b.idperiode')
			->join('ak_account c','a.idaccount=c.idaccount')
			;
        echo $this->datatables->generate();
	}
	
	static public function callback_actions($id){
		$module = 'accounting/saldo_awal';
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
			$where = array("idsaldo_awal"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('ak_saldo_awal',$where);
		} else {
			$data['cond'] = "Add";
		}
		
		//populate tpl
		$options = $this->global_model->list_lov('ak_periode','nama_periode','idperiode','Y','nama_periode');
		$data['idperiode'] = form_dropdown('idperiode',$options,@$data['detail']['idperiode'],'class="select2"');
		
		$options = $this->global_model->list_lov('ak_account','concat(kode," - ",nama)','idaccount','Y','nama');
		$data['idaccount'] = form_dropdown('idaccount',$options,@$data['detail']['idaccount'],'class="select2"');
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		// Load the template from the views directory
        $this->parser->parse("saldo_awal_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		if ($this->input->post('idsaldo_awal') == "") { //insert cond
			//unset data
			unset($data['idsaldo_awal']);
			//set data
			$data['created_date'] = date("Y-m-d H:i:s");
			$data['created_by'] = $this->ion_auth->user()->row()->id;
			//call model
			$data = $this->global_model->insert('ak_saldo_awal',$data);
		} else { //edit cond
			//call model
			$where = array("idsaldo_awal"=>$data['idsaldo_awal']);
			$data = $this->global_model->update('ak_saldo_awal',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-money";
		$data['bc'] = "Accounting <span>> Settings > Manage Saldo_awal > Add Saldo_awal</span>";
		$data['module_alias'] = "Saldo awal";
		$data['module_name'] = 'accounting/saldo_awal';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(4);
		//call model
		$data = $this->global_model->delete('ak_saldo_awal','idsaldo_awal',$id);
		echo json_encode($data);
	}
}