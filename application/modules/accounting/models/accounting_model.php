<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Accounting_model extends CI_Model
{
	public function ajax_select($select_name,$id,$child_id='') {
		//get related table
		$q = $this->db->get_where('ak_subgroup',array('idgroup'=>$id));
		$row_q = $q->row_array();
		
		//fetch row table
		if (!empty($row_q)) {
			$where = array("idgroup"=>$id);
			$options = $this->global_model->list_lov('ak_subgroup','nama','idsubgroup','Y','nama',$where);
		} else {
			$options = array(""=>"--Select--");
		}
		echo form_dropdown('idsubgroup',$options,$child_id,'class="sel'.$id.'"');
	}
	
	public function get_account_detail($id) {
		$this->db->where('a.idaccount',$id,false);
		$this->db->join('ak_subgroup b','a.idsubgroup=b.idsubgroup');
		$this->db->join('ak_group c','b.idgroup=c.idgroup');
		$this->db->select('a.*,c.idgroup');
		$q = $this->db->get('ak_account a');
		return $q->row_array();
	}
	
	//belum kepake
	public function sum_field($field,$periode) {
		$this->db->select('sum('.$field.') as total');
		$this->db->where('b.nama_periode',$periode);
		$this->db->join('ak_periode b','a.idperiode=b.idperiode',false);
		$q = $this->db->get('ak_saldo_awal a');
		$q = $q->row_array();
		return $q['total'];
	}
	
	//jurnal umum
	public function insert_ju($data) {
		$user_id = $this->ion_auth->user()->row()->id;
		
		//reformat tanggal pembelian
		list($d,$m,$y) = explode("/",$data['tanggal_jurnal']);
		$tanggal_jurnal = $y."-".$m."-".$d;
		
		//generate idjurnal
		$next = $this->db->query("SHOW TABLE STATUS LIKE 'ak_jurnal_umum'");
		$next = $next->row(0);
		$idjurnal = $next->Auto_increment;
		
		//start the transaction
		$this->db->trans_begin();
		$err_msg = "";
		//insert ke tabel transaksi_pembelian
		$parent_data['idjurnal'] = $idjurnal;
		$parent_data['idperiode'] = $data['idperiode'];
		$parent_data['idtipe_jurnal'] = $data['idtipe_jurnal'];
		$parent_data['tanggal_jurnal'] = $tanggal_jurnal;
		$parent_data['no_bukti'] = $data['no_bukti'];
		$parent_data['keterangan'] = $data['keterangan'];
		$parent_data['created_date'] = date("Y-m-d H:i:s");
		$parent_data['created_by'] = $user_id;
		
		$q = $this->db->insert('ak_jurnal_umum',$parent_data);
		if (!$q) { $err_msg = $this->db->_error_message(); goto end;}
		
		//detail ju
		foreach ($data['idaccount'] as $key=>$idaccount) {
			//generate idjurnal_detail
			$next = $this->db->query("SHOW TABLE STATUS LIKE 'ak_jurnal_umum_detail'");
			$next = $next->row(0);
			$idjurnal_detail = $next->Auto_increment;
			
			$child_data['idjurnal_detail'] = $idjurnal_detail;
			$child_data['idjurnal'] = $idjurnal;
			$child_data['idaccount'] = $idaccount;
			$child_data['debet'] = $data['debet'][$key];
			$child_data['kredit'] = $data['kredit'][$key];
			
			$q = $this->db->insert('ak_jurnal_umum_detail',$child_data);
			if (!$q) { $err_msg = $err_msg."-".$this->db->_error_message(); goto end;}
		}
		
		end:
		//end transaction
		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			$data['error'] = true;
			$data['field'][]['message'] = $err_msg;
		} else {
			$this->db->trans_commit();
			$data['error'] = false;
		}
		return $data;
	}
	
	//get saldo awal for ju
	public function saldo_awal_by_acc($data)
	{
		$html = '<tr>';
		$html .= '<td colspan="6" style="text-align: center">Saldo Awal</td>';
		//get saldo awal
		$tanggal = $data['tahun']."-".$data['bulan']."-01";
		
		//query saldo awal
		$this->db->select('sum(debet) debet, sum(kredit) kredit');
		//$this->db->where('MONTH(b.start)',$data['bulan'],false);
		$this->db->where("'".$tanggal."'".' between start and end','',false);
		$this->db->where('a.idaccount',$data['idaccount'],false);
		$this->db->join('ak_periode b','a.idperiode=b.idperiode');
		$q = $this->db->get('ak_saldo_awal a');
		$res_q = $q->row_array();//echo $this->db->last_query();
		
		$html .= '<td style="text-align: center">'.number_format($res_q['debet'], 2, ",", ".").'</td>';
		$html .= '<td style="text-align: center">'.number_format($res_q['kredit'], 2, ",", ".").'</td>';
		$saldo = $res_q['kredit'] - $res_q['debet'];
		$html .= '<td style="text-align: center">'.number_format(abs($saldo), 2, ",", ".").'</td>';
		$html .= '</tr>';
		
		//query buku besar dari jurnal umum
		$this->db->select('a.tanggal_jurnal,a.no_bukti,b.kode as kode_jurnal,a.keterangan,d.kode as kode_akun,d.nama as nama_akun,c.debet,c.kredit,a.idjurnal');
		$this->db->join('ak_tipe_jurnal b','a.idtipe_jurnal=b.idtipe_jurnal');
		$this->db->join('ak_jurnal_umum_detail c','a.idjurnal=c.idjurnal');
		$this->db->join('ak_account d','c.idaccount=d.idaccount');
		$this->db->where('d.idaccount',$data['idaccount'],false);
		$q = $this->db->get('ak_jurnal_umum a');//echo $this->db->last_query();
		$res_q = $q->result_array();
		
		foreach ($res_q as $ju) {
			$html .= '<tr>';
			$html .= '<td>'.$ju['tanggal_jurnal'].'</td>'.'<td>'.$ju['no_bukti'].'</td>';
			$html .= '<td>'.$ju['kode_jurnal'].'</td>'.'<td>'.$ju['keterangan'].'</td>';
			$html .= '<td>'.$ju['kode_akun'].'</td>'.'<td>'.$ju['nama_akun'].'</td>';
			$html .= '<td style="text-align: center">'.number_format($ju['debet'], 2, ",", ".").'</td>'.'<td style="text-align: center">'.number_format($ju['kredit'], 2, ",", ".").'</td>';
			$saldo = ($saldo + $ju['kredit']) - $ju['debet'];
			$html .= '<td style="text-align: center">'.number_format(abs($saldo), 2, ",", ".").'</td>';
			$html .= '</tr>';
		}
		return $html;
	}
}
