<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Users extends CI_Controller {
	
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
		$this->load->model('user_management_model');
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
		// Load the template from the views directory
        $this->parser->parse("users.tpl", $data);
	}
	
	public function table_list()
	{
		$this->datatables->select('username,group_name,email,company,phone,id')
			->edit_column('id', '$1', 'users', 'callback_actions(id)')
            ->from('(SELECT a.*,
					(select group_name from v_user_groups aa
						where aa.user_id=a.id
					) group_name
					FROM `users` a
					) as datatable_table');
 
        echo $this->datatables->generate();
	}
	
	static public function callback_actions($id){
		return '<nav class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
					<a class="btn btn-success btn-sm" href="'.base_url().'user_management/users/add/'.$id.'">
						<i class="fa fa-edit"></i> <span class="hidden-mobile">Edit Row</span>
					</a>
				</nav>
				<a class="btn btn-danger btn-sm" name="delete" href="javascript:void(0)" onclick="return confirm_delete(\'user_management/users\','.$id.')">
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
			$data['stat_cond'] = "edit_user";
			$data['change_pwd'] = '(if changing password) ';
			$where = array("id"=>$id);
			$data['detail'] = $this->global_model->get_detail_data('users',$where);
			$data['csrf'] = form_hidden($this->global_model->_get_csrf_nonce());
		} else {
			$data['cond'] = "Add";
			$data['stat_cond'] = "create_user";
			//block username
			$data['block_username'] = '<div class="row">
				<section class="col col-6">
					Username
					<label class="input"> 
						<i class="icon-append fa fa-user"></i>
						<input type="text" placeholder="Username" name="username" id="username">
						<b class="tooltip tooltip-bottom-right">Needed to enter the Application</b> </label>
				</section>
			</div>';
		}
		//member group
		$data['member_groups'] = $this->user_management_model->member_groups($id);
		
		// Load the template from the views directory
        $this->parser->parse("users_add.tpl", $data);
	}
	
	public function add_success()
	{
		$data['icon'] = "fa-user";
		$data['bc'] = "User Management <span>> Manage Users > Add User</span>";
		$data['module_alias'] = "User";
		$data['module_name'] = "user_management/users";
		// Load the template from the views directory
        $this->parser->parse("add_success.tpl", $data);
	}
	
	public function delete()
	{
		$this->check_group();
		
		$id = $this->uri->segment(4);
		//call model
		$data = $this->user_management_model->delete('users',$id);
		echo json_encode($data);
	}
}