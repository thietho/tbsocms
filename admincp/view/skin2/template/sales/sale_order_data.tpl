<table class="data-table" cellpadding="0" cellspacing="0">
    <thead>
        <tr class="tr-head">
            
            <th width="10px">STT</th>
            <th>Mã phiếu</th>
            <th>Ngày bán</th>
            <th>Khách hàng</th>
            
            <th>Tổng tiền bán</th>
            
            
            <th>Ghi chú</th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_order as $key => $item){ ?>
        <tr>
        	<td><center><?php echo @$key+1 ?></center></td>
            <td>
            	<a onclick="objdl.viewPX(<?php echo @$item['id']?>,'')"><?php echo @$item['maphieu']?></a>
                <?php if(@$this->user->getUserTypeId() =='admin'){ ?>
                <input type="button" class="button" value="Edit" onClick="saleOrder.editOrder(<?php echo @$item['id']?>);$('#listordercomplete').dialog( 'close' );">
                <?php }?>
            </td>
            <td><?php echo @$this->date->formatMySQLDate($item['ngaylap'])?></td>
            <td>
            	<?php if(@$item['tenkhachhang'])
                    {
                        echo $item['tenkhachhang'];
                        echo ($item['dienthoai'] != '') ?' - '.$item['dienthoai']:'';
                        echo ($item['diachi'] != '') ?' - '.$item['diachi']:'';
                    }
                ?>
            </td>
            <td class="number"><?php echo @$this->string->numberFormate($item['tongtien'])?></td>
            <td><?php echo @$item['ghichu']?></td>
        </tr>
        <?php } ?>
    </tbody>

</table>