<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Stock_model extends CI_Model
{
	public function ajax_select($select_name,$id,$idref='') {
		//get related table
		$q = $this->db->get_where('tipe_barang',array('idtipe_barang'=>$id));
		$row_q = $q->row_array();
		
		//fetch row table
		if (!empty($row_q)) {
			$options = $this->global_model->list_lov($row_q['related_table'],'nilai','idref','Y','nilai');
		} else {
			$options = array(""=>"--Select--");
		}
		echo form_dropdown('idref',$options,$idref);
	}
}
