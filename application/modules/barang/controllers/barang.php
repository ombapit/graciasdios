<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Barang extends CI_Controller {
	
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
		$this->load->model('barang_model');
		
		//global var
		$this->module_alias = "Product";
		$this->module = 'barang';
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
        $this->parser->parse("barang.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('nama_tipe,kode_barang,nama_barang,idref,berat,quantity,quantity_sby,idbarang')
			 ->edit_column('idref', '$1', 'barang', 'callback_ukuran(nama_tipe,idref)')
			 ->edit_column('idbarang', '$1', 'barang', 'callback_actions(idbarang)')
             ->from('barang')
			;
		$this->datatables->join('tipe_barang', 'barang.idtipe_barang = tipe_barang.idtipe_barang');
 
        echo $this->datatables->generate();
	}
	
	static public function callback_ukuran($val,$val2) {
		$ci =& get_instance();
		//get id from nama
		$tb = $ci->global_model->get_detail_data('tipe_barang',array('nama_tipe'=>$val));
		$data = $ci->global_model->get_detail_data($tb['related_table'],array('idref'=>$val2));
		return $data['nilai'];
	}
	
	static public function callback_actions($id){
		$module = 'barang';
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
			$where = array("idbarang"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('barang',$where);
			$data['idref_load_js'] = "change_type(".$data['detail']['idtipe_barang'].",".$data['detail']['idref'].")";
		} else {
			$data['cond'] = "Add";
		}
		
		//populate tpl
		$options = $this->global_model->list_lov('tipe_barang','nama_tipe','idtipe_barang','Y','nama_tipe');
		$data['tipe_barang'] = form_dropdown('idtipe_barang',$options,@$data['detail']['idtipe_barang'],'onchange="change_type(this.value)"');
		
		$data['stat_cond'] = "insert_commit";
		$data['module_alias'] = $this->module_alias;
		$data['module'] = $this->module;
		// Load the template from the views directory
        $this->parser->parse("barang_add.tpl", $data);
	}
	
	public function insert_commit()
	{
		$this->check_group();
		
		$data = $this->input->post();
		if ($this->input->post('idbarang') == "") { //insert cond
			//unset data
			unset($data['idbarang']);
			//call model
			$data = $this->global_model->insert('barang',$data);
		} else { //edit cond
			//call model
			$where = array("idbarang"=>$data['idbarang']);
			$data = $this->global_model->update('barang',$data,$where);
		}
		echo json_encode($data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-wrench";
		$data['bc'] = "Reference <span>> Manage Barang > Add Barang</span>";
		$data['module_alias'] = "Barang";
		$data['module_name'] = 'barang';
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(3);
		//call model
		$data = $this->global_model->delete('barang','idbarang',$id);
		echo json_encode($data);
	}
	
	public function change_type()
	{
		$id = $this->input->post('idtipe_barang');
		$idref = $this->input->post('idref');
		if ($idref == "undefined") {
			echo $this->barang_model->ajax_select('idref',$id);
		} else {
			echo $this->barang_model->ajax_select('idref',$id,$idref);
		}
	}
}