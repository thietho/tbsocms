				<?php echo @$pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if(@$dialog!=true){ ?>
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <?php } ?>
                        <th width="10px">STT</th>
                        <th>Mã phiếu</th>
                        <th>Ngày bán</th>
                        <th>Xuất cho</th>
                        
                        <th>Tổng tiền bán</th>
                        <th>Thanh toán</th>
                        <th>Công nợ</th>
                        <th>Ghi chú</th>
                        
                        <th>Tình trạng</th>
                        <?php if(@$dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr class="item" id="<?php echo @$item['id']?>" maphieu="<?php echo @$item['maphieu']?>">
                    	<?php if(@$dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
                        <?php } ?>
                        <td><center><?php echo @$key+1 ?></center></td>
                        <td><a onclick="objdl.viewPX(<?php echo @$item['id']?>,'')"><?php echo @$item['maphieu']?></a></td>
                        <td><?php echo @$this->date->formatMySQLDate($item['ngaylap'])?></td>
                       	<td>
                        	<?php echo @$this->document->getCategory($item['loaiphieu'])?>:
                            <?php if(@$item['tenkhachhang'])
                                {
                                	echo $item['tenkhachhang'];
                                    echo ($item['dienthoai'] != '') ?' - '.$item['dienthoai']:'';
                                    echo ($item['diachi'] != '') ?' - '.$item['diachi']:'';
                                }
                                if($item['shopid'])
                                {
                                	echo @$this->document->getShop($item['shopid']);
                                }
                                if($item['nhacungcapid'])
                                {
                                	echo $item['tennhacungcap'];
                                }
                            ?>
                        </td>
                        <td class="number"><?php echo @$this->string->numberFormate($item['tongtien'])?></td>
                        <td class="number"><?php echo @$this->string->numberFormate($item['thanhtoan'])?></td>
                        <td class="number"><?php echo @$this->string->numberFormate($item['congno'])?></td>
                        <td><?php echo @$item['ghichu']?></td>
                        
                        <td><?php echo @$this->document->status_phieunhapxuat[$item['trangthai']]?></td>
                        <?php if(@$dialog!=true){ ?>
                        <td class="link-control">
                            <?php if(@$this->user->checkPermission("quanlykho/phieunhap/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo @$item['text_edit']?>" onclick="window.location='<?php echo @$item['link_edit']?>'"/>
                            <?php } ?>
                           	
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
                <?php echo @$pager?>

<?php if(@$dialog){ ?>
<script language="javascript">
	intSelectNguyenLieu()
</script>
<?php } ?>