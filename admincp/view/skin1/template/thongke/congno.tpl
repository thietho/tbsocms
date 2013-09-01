<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    <div class="section-content">
        <table class="data-table" cellpadding="0" cellspacing="0">
            <tbody>
                <tr class="tr-head">
                    
                    
                    
                    <th>Tên khách hàng</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Email</th>
                    <th>Công nợ</th>
                    
                </tr>
                
    
    
    <?php
        foreach($users as $user)
        {
    ?>
                <tr class="item">
                    
                    
                    
                    <td><?php echo $user['fullname']?></td>
                    <td><?php echo $user['phone']?></td>
                    <td><?php echo $user['address']?></td>
                    <td><?php echo $user['email']?></td>
                    <td class="number"><a onclick="viewCongNo(<?php echo $user['id']?>)"><?php echo $this->string->numberFormate($user['congno'])?></a></td>
                    
                </tr>
    <?php
        }
    ?>
                    
            	<tr>
                	<td align="right" colspan="4">Tổng công nợ</td>
                    <td class="number"><?php echo $this->string->numberFormate($tongcongno)?></td>
                </tr>                             
            </tbody>
        </table>
    </div>			
<script language="javascript">
function viewCongNo(id)
{
	$("#popup").attr('title','Công nợ');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						'Đóng': function() {
							$( this ).dialog( "close" );
							
						},
						'Thanh toán công nợ':function(){
							
						},
						'In': function(){
							openDialog("?route=core/member/getCongNo&khachhangid="+id+"&dialog=print",800,500)
							
						},
					}
				});
			
				
	$("#popup-content").load("?route=core/member/getCongNo&khachhangid="+id+"&dialog=true",function(){
		$("#popup").dialog("open");	
	});
}
</script>           