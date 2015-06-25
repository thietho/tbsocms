<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_inventorycheck" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
                <input type="button" value="Trở về" class="button" onClick="window.location = '?route=quanlykho/inventorycheck';"/>
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" name="nhanvienid" value="<?php echo $item['nhanvienid']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="inventorycheck">
            	<ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin kiềm kho</span></a></li>
                    <li class="tabs"><a href="#fragment-sanpham"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                	<p>
                        <label>Ngày kiểm</label><br />
                        <?php echo $this->date->formatMySQLDate($item['datecheck'])?>
                        
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <?php echo $item['note']?>
                        
                        
                    </p>
                </div>
                <div id="fragment-sanpham">
                	<table>
                    	<thead>
                            <tr>
                                <th>STT</th>
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Đơn vị tính</th>
                                
                            </tr>
                        </thead>
                        <tbody id="listproduct">
                        	<?php foreach($data_detail as $key => $detail){ ?>
                            <tr>
                            	<td><?php echo $key +1 ?></td>
                                <td><?php echo $this->document->productName($detail['mediaid'])?></td>
                                <td><?php echo $this->string->numberFormate($detail['quantity'])?></td>
                                <td><?php echo $this->document->getDonViTinh($detail['unit'])?></td>
                            </tr>
                            <?php } ?>
                        </tbody>
                        
                	</table>
                    
                </div>
            </div>
            
		</form>
    </div>
</div>
<script language="javascript">
$(document).ready(function(e) {
	$('#inventorycheck').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
</script>