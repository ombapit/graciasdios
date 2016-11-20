<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Jurnal_umum extends CI_Controller {
	
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
		$this->module_alias = "Jurnal umum";
		$this->module = 'accounting/jurnal_umum';
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
        $this->parser->parse("jurnal_umum.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('a.tanggal_jurnal,a.no_bukti,b.kode as kode_jurnal,a.keterangan,d.kode as kode_akun,d.nama as nama_akun,c.debet,c.kredit,a.idjurnal')
			->edit_column('c.debet', '$1', 'jurnal_umum', 'number_format(c.debet, 2, ",", ".")')
			->edit_column('c.kredit', '$1', 'jurnal_umum', 'number_format(c.kredit, 2, ",", ".")')
			->edit_column('a.idjurnal', '$1', 'jurnal_umum', 'callback_actions(a.idjurnal)')
            ->from('ak_jurnal_umum a')
			->join('ak_tipe_jurnal b','a.idtipe_jurnal=b.idtipe_jurnal')
			->join('ak_jurnal_umum_detail c','a.idjurnal=c.idjurnal')
			->join('ak_account d','c.idaccount=d.idaccount')
			;
        echo $this->datatables->generate();
	}
	
	static public function callback_actions($id){
		$module = 'accounting/jurnal_umum';
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
			$where = array("idjurnal"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('ak_jurnal_umum',$where);
		} else {
			$data['cond'] = "Add";
		}
		
		//populate tpl
		$options = $this->global_model->list_lov('ak_periode','nama_periode','idperiode','Y','nama_periode');
		$data['idperiode'] = form_dropdown('idperiode',$options,@$data['detail']['idperiode'],'class="select2"');
		
		$options = $this->global_model->list_lov('ak_tipe_jurnal','concat(kode," - ",nama)','idtipe_jurnal','Y','kode,nama');
		$data['idtipe_jurnal'] = form_dropdown('idtipe_jurnal',$options,@$data['detail']['idtipe_jurnal'],'class="select2"');
		
		$options = $this->global_model->list_lov('ak_account','concat(kode," - ",nama)','idaccount','Y','nama');
		$data['idaccount'] = form_dropdown('idaccount[]',$options,@$data['detail']['idaccount'],'class="select2"');
		$data['idaccount_ref'] = form_dropdown('idaccount_ref',$options,null);
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		// Load the template from the views directory
        $this->parser->parse("jurnal_umum_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		$this->load->library('form_validation');
		
		$this->form_validation->set_rules('idaccount[]', 'Account Name', 'required|xss_clean');
		if ($this->form_validation->run() == false) {
			$json['error'] =true;
			$errors = $this->form_validation->error_array();
			$i = 0;
			foreach ($errors as $key=>$val) {
				$json['field'][$i]['name'] = $key;
				$json['field'][$i]['message'] = $val;
				$i++;
			}
			echo json_encode($json);
			die;
		}
		
		if ($this->input->post('idjurnal') == "") { //insert cond
			//unset data
			unset($data['idjurnal']);
			//call model
			$data = $this->accounting_model->insert_ju($data);
		} else { //edit cond
			//call model
			$where = array("idjurnal"=>$data['idjurnal']);
			$data = $this->global_model->update('ak_jurnal_umum',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-money";
		$data['bc'] = "Accounting <span>> Settings > Manage Jurnal_umum > Add Jurnal_umum</span>";
		$data['module_alias'] = "Jurnal umum";
		$data['module_name'] = 'accounting/jurnal_umum';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(4);
		//call model
		$data = $this->global_model->delete('ak_jurnal_umum','idjurnal',$id);
		echo json_encode($data);
	}
}