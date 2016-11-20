<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Global_model extends CI_Model
{
	function _get_csrf_nonce()
	{
		$this->load->helper('string');
		$key   = random_string('alnum', 8);
		$value = random_string('alnum', 20);
		$this->session->set_flashdata('csrfkey', $key);
		$this->session->set_flashdata('csrfvalue', $value);

		return array($key => $value);
	}

	function _valid_csrf_nonce()
	{
		if ($this->input->post($this->session->flashdata('csrfkey')) !== FALSE &&
			$this->input->post($this->session->flashdata('csrfkey')) == $this->session->flashdata('csrfvalue'))
		{
			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}
	
	public function get_detail_data($table,$where='')
	{
		if (!empty($where)) {
			$this->db->where($where);
		}
		$q = $this->db->get($table);
		
		return $q->row_array();
	}
	
	//insert single row
	public function insert($table,$data) {
		$q = $this->db->insert($table,$data);
		
		if($q){
			$data['error'] = false;
			$this->session->set_userdata('alert_msg','Data inserted Successfully');
		} else {
			$data['error'] = true;
			$data['msg'] = $this->db->_error_message();
			//$data['num'] = $this->db->_error_number();
		}
		return $data;
	}
	
	//update single row
	public function update($table,$data,$where) {
		$this->db->where($where);
		$q = $this->db->update($table,$data);
		
		if($q){
			$data['error'] = false;
			$this->session->set_userdata('alert_msg','Data updated Successfully');
		} else {
			$data['error'] = true;
			$data['msg'] = $this->db->_error_message();
			//$data['num'] = $this->db->_error_number();
		}
		return $data;
	}
	
	//delete single row
	public function delete($module,$field_name,$id)
	{
		$this->db->where($field_name,$id);
		$q = $this->db->delete($module);

		if($q){
			$data['success'] = true;
			$this->session->set_userdata('alert_msg','Data deleted Successfully');
		} else {
			$data['success'] = false;
			$data['msg'] = $this->db->_error_message();
			//$data['num'] = $this->db->_error_number();
		}
		return $data;
	}
	
	public function list_lov($table,$field_name,$field_value,$empty_value="Y",$order_by='',$where='') {
        if ($order_by != "") {
            $this->db->order_by($order_by);
        }
        if ($where != "") {
            $this->db->where($where);
        }
        
        //upper
        $field_value = strtoupper($field_value);
        $field_name = strtoupper($field_name);
        
        $this->db->select("$field_value a_val,$field_name b_val",false);
        $q = $this->db->get($table);
        $r = $q->result_array();
        
        $lov = array();
        if ($empty_value=="Y") {
            $lov[""] = "--Select--";
        }
        foreach($r as $key=>$data) {
            $lov[$data['a_val']] = $data['b_val'];
        }
        return $lov;
    }
}
