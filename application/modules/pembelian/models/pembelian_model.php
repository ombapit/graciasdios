<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pembelian_model extends CI_Model
{
	public function get_transaction_data($id) {
		$this->db->where("idtransaksi_pembelian",$id,false);
		$this->db->select('a.*,DATE_FORMAT(tanggal_pembelian,"%d-%m-%Y") tanggal_pembelian,b.nama_supplier',false);
		$this->db->join('suppliers b','a.idsupplier=b.idsupplier','left');
		$q = $this->db->get('transaksi_pembelian a');
		return $q->row_array();
	}
	
	public function get_transaction_data_detail($id) {
		$this->db->where("idtransaksi_pembelian",$id,false);
		$this->db->select('b.kode_barang,b.nama_barang,a.jumlah,a.jumlah_sby');
		$this->db->join('barang b','a.idbarang=b.idbarang');
		$q = $this->db->get('transaksi_pembelian_detail a');
		$res_q = $q->result_array();
		$html = "";
		foreach ($res_q as $row) {
			$html .='
				<tr>
					<td>
						'.$row['kode_barang'].'
					</td>
					<td>
						'.$row['nama_barang'].'
					</td>
					<td>
						<section>
							Jakarta: '.$row['jumlah'].'
							Surabaya: '.$row['jumlah_sby'].'
						</section>
					</td>
				</tr>';
		}
		return $html;
	}
	
	public function insert_pembelian($data) {
		$user_id = $this->ion_auth->user()->row()->id;
		
		//reformat tanggal pembelian
		list($d,$m,$y) = explode("/",$data['tanggal_pembelian']);
		$tanggal_pembelian = $y."-".$m."-".$d;
		
		//generate idtransaksi_pembelian
		$next = $this->db->query("SHOW TABLE STATUS LIKE 'transaksi_pembelian'");
		$next = $next->row(0);
		$idtransaksi_pembelian = $next->Auto_increment;
		
		//start the transaction
		$this->db->trans_begin();
		$err_msg = "";
		//insert ke tabel transaksi_pembelian
		$parent_data['idtransaksi_pembelian'] = $idtransaksi_pembelian;
		$parent_data['idsupplier'] = $data['idsupplier'];
		$parent_data['ref_code'] = $this->gen_ref_code_pembelian($idtransaksi_pembelian);
		$parent_data['tanggal_pembelian'] = $tanggal_pembelian;
		$parent_data['created_date'] = date("Y-m-d H:i:s");
		$parent_data['created_by'] = $user_id;
		
		$q = $this->db->insert('transaksi_pembelian',$parent_data);
		if (!$q) { $err_msg = $this->db->_error_message(); goto end;}
		
		//insert ke tabel detail
		$detail_data['idtransaksi_pembelian'] = $idtransaksi_pembelian;
		
		foreach ($data['idbarang'] as $key=>$idbarang) {
			$detail_data['idbarang'] = $idbarang;
			$detail_data['jumlah'] = $data['jumlah'][$key];
			$detail_data['jumlah_sby'] = $data['jumlah_sby'][$key];
			
			$q = $this->db->insert('transaksi_pembelian_detail',$detail_data);
			if (!$q) { $err_msg = $err_msg."-".$this->db->_error_message(); goto end;}
			
			//update barang (buat di demo,gak bisa create trigger)
			$this->db->query('update barang set quantity = quantity +'.$detail_data['jumlah'].',quantity_sby = quantity_sby +'.$detail_data['jumlah_sby'].' where idbarang='.$detail_data['idbarang']);
			
			//masukkan ke gudang
			$gudang_data['ref_code'] = $parent_data['ref_code'];
			$gudang_data['idbarang'] = $detail_data['idbarang'];
			$gudang_data['jumlah'] = $detail_data['jumlah'];
			$gudang_data['jumlah_sby'] = $detail_data['jumlah_sby'];
			$gudang_data['type'] = 'masuk';
			$gudang_data['date'] = $parent_data['created_date'];
			$gudang_data['created_by'] = $parent_data['created_by'];
			
			$q = $this->db->insert('gudang',$gudang_data);
			if (!$q) { $err_msg = $err_msg."-".$this->db->_error_message(); break;}
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
	
	private function gen_ref_code_pembelian($idtransaksi_pembelian) {
		return "PMB".date("dmY").str_pad($idtransaksi_pembelian, 4, '0', STR_PAD_LEFT);
	}
}
