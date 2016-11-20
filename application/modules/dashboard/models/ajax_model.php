<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Ajax_model extends CI_Model
{
	function multidimensional_search($parents, $searched) {
	  if (empty($searched) || empty($parents)) {
		return false;
	  }
	 
	  foreach ($parents as $key => $value) {
		$exists = true;
		foreach ($searched as $skey => $svalue) {
		  $exists = ($exists && IsSet($parents[$key][$skey]) && $parents[$key][$skey] == $svalue);
		}
		if($exists){ return $key; }
	  }
	  return -1;
	  //return false;
	} 
	
	public function get_gudang_by_type($post, $idtipe_barang) {
		$data = array();
		//query barang
		$this->db->where('type',$post['type']);//nanti diganti keluar
		$this->db->where("b.idtipe_barang",$idtipe_barang,false);
		$this->db->select('date_format(date,"%Y-%m-%d") date,sum(jumlah) jumlah',false);
		$this->db->group_by('date');
		$this->db->join('barang b','a.idbarang=b.idbarang');
		$q = $this->db->get('gudang a');
		//echo $this->db->last_query();
		$res = $q->result_array();
		
		// Start date
		$date = $post['from'];
		// End date
		$end_date = $post['to'];
		while (strtotime($date) <= strtotime($end_date)) {
			$jumlah = 0;
			if ($res) {
				$key = $this->multidimensional_search($res, array('date'=>$date));
				if ($key != -1) {
					if ($date == $res[$key]['date']) {
						$jumlah = (int)$res[$key]['jumlah'];
					}
				}
			}
			
			$data[] = array(strtotime($date." UTC") * 1000,$jumlah);
			
			$date = date ("Y-m-d", strtotime("+1 day", strtotime($date)));
		}
		return $data;
	}
}
