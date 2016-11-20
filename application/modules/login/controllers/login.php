<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {

	public function index()
	{
		if ($this->ion_auth->logged_in())
		{
			//redirect them to the login page
			redirect('cpanel', 'refresh');
		}
		
		// Some example data
        $data['title'] = APP_NAME."Login Page";
		
		$data['message'] = '';
		if ($this->session->flashdata('message') != "") {
			$data['message'] = '<div class="alert alert-danger fade in"><button data-dismiss="alert" class="close">×</button>
				'.$this->session->flashdata('message').'</div>';
		}
		$data['identity'] = form_input(array('name' => 'identity',
			'id' => 'identity',
			'type' => 'text',
			'value' => $this->form_validation->set_value('identity'),
		));
		$data['password'] = form_input(array('name' => 'password',
			'id' => 'password',
			'type' => 'password',
		));
		
        // Load the template from the views directory
        $this->parser->parse("login.tpl", $data);
	}
}