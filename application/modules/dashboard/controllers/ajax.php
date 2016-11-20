<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Ajax extends CI_Controller {
	
	function __construct()
	{
		parent::__construct();
		if (!$this->ion_auth->logged_in())
		{
			//redirect them to the login page
			echo '<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Your login is expired click <a href="'.base_url().'">here</a> to relogin.</h4>';
			die;
		}
		$this->load->model('ajax_model');
	}
	
	public function index()
	{
		$data['module'] = "dashboard/ajax";
		$data['from'] = date('Y-m-01');
		$data['to'] = date('Y-m-t');
		
		// Load the template from the views directory
        $this->parser->parse("dashboard.tpl", $data);
	}
	
	public function upright()
	{
		$data = $this->ajax_model->get_gudang_by_type($_POST,1);
		echo json_encode($data);
	}
	
	public function width()
	{
		$data = $this->ajax_model->get_gudang_by_type($_POST,2);
		echo json_encode($data);
	}
	
	public function depth()
	{
		$data = $this->ajax_model->get_gudang_by_type($_POST,3);
		echo json_encode($data);
	}
	
	public function ambalan()
	{
		$data = $this->ajax_model->get_gudang_by_type($_POST,4);
		echo json_encode($data);
	}
	
	public function footplate()
	{
		$data = $this->ajax_model->get_gudang_by_type($_POST,5);
		echo json_encode($data);
	}
}