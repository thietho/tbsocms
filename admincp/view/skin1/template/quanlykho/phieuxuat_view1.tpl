<center>
    <h2>Phiếu bán hàng</h2>
    
</center>
<table>
	<tr>
    	<td>
            <div class="cusinfo">
                <label>Khách hàng:</label> <?php echo $item['tenkhachhang']?> - <label>ĐT:</label> <?php echo $item['dienthoai']?>
            </div>
            <div class="cusinfo">
                <label>Địa chỉ:</label> <?php echo $item['diachi']?>
                
                <!--<?php echo $this->document->getCustomer($item['khachhangid'],'address')?>-->
            </div>
        </td>
        <td align="right">
        	<p>
            	Ngày <?php echo $this->date->getDay($item['ngaylap'])?> tháng <?php echo $this->date->getMonth($item['ngaylap'])?> năm <?php echo $this->date->getYear($item['ngaylap'])?>
            </p>
            <p>
                <label>Số:</label> <?php echo $item['maphieu']?>
            </p>
        </td>
    </tr>
</table>

<table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            
            <th>Sản phẩm</th>
			<th>Nhãn hiệu</th>            
            <th width="30">SL</th>
            <!--<th>Đơn vị</th>-->
            <th>Giá</th>
            <th>Giảm(%)</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	
        <?php foreach($data_nhapkho as $key =>$val){ ?>
            
        <tr <?php if($val['thanhtien']==0) echo 'style="font-weight:bold"'?>>
            <td><center><?php echo $key+1?></center></td>
            
            <td>
            	
                <?php echo $this->document->productName($val['mediaid'])?>
            </td>
            <td><font style="text-transform:uppercase"><?php echo $this->document->getCategory($this->document->getMedia($val['mediaid'],'brand'))?></font></td>
            <td><center><?php echo $this->string->numberFormate($val['soluong'])?></center></td>
            <!--<td><?php echo $this->document->getDonViTinh($val['madonvi'])?></td>-->
            <td class="number">
            	<?php if($val['giatien'] == 0){ ?>
                <?php echo $this->string->numberFormate($this->document->getMedia($val['mediaid'],'price'))?>
                <?php }else{ ?>
            	<?php echo $this->string->numberFormate($val['giatien'])?>
                <?php } ?>
            	
            </td>
            <td class="number">-<?php echo $this->string->numberFormate($val['phantramgiamgia'])?>%</td>
            <td class="number"><?php if($val['thanhtien']) echo $this->string->numberFormate($val['thanhtien']); else echo "Tặng"?></td>
            
        </tr>
        <?php } ?>
        <?php if($item['thuphi'] != 0){ ?>
        <tr>
            
           	<td><center><?php echo $key+2?></center></td>
            <td><?php echo $item['lydothu']?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="number"><?php echo $this->string->numberFormate($item['thuphi'])?></td>
        </tr>
        <?php } ?>
        <tr>
            
           	
            <td class="number" colspan="6"><strong>Tổng tiền</strong></td>
            <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        </tr>
        
    </tbody>
</table>
<table style="margin:15px 0">
	<tr>
    	
        <th width="20%">Người lập phiếu</th>
        <th width="20%">Khách hàng</th>
        <th width="20%">Thủ quỷ</th>
    </tr>
    <tr>
    	
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
    </tr>
</table>