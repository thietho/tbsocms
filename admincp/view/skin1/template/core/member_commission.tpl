<script src="<?php echo DIR_JS?>tabletoexcel.js" type="text/javascript"></script>
<script language="javascript">
function Commission(memberid)
{
	this.memberid = memberid
	this.add = function()
	{
		$.post("?route=core/member/commissionsave",$('#frmHoaHong').serialize(),function(){
			comm.getList();
		});	
	};
	this.view = function(memberid,tungay,denngay)
	{
		
	}
	this.getList = function()
	{
		$.getJSON("?route=core/member/getListCommission&memberid="+ this.memberid,function(data){
			var str = "<ul>";
			for(i in data)
			{
				//alert(i-1);
				var tungay = "";
				if(i>0)
					tungay = data[i-1].ngaytinhhoahong;
				var denngay =data[i].ngaytinhhoahong;
				str+= "<li>"
				str+= "Đợt "+ ( Number(i)+1) +": "+ data[i].ngaytinhhoahong;
				str+= '<input type="button" class="button viewhoahong" value="Xem" memberid="'+memberid+'" tungay="'+tungay+'" denngay="'+denngay+'"/>';
				str+= '<input type="button" class="button delhoahong" value="Xóa" hoahongid="'+ data[i].id +'"/>';
				str+= "</li>"
			}
			str += "</ul>";
			$('#commissionlist').html(str);
		});
	}
	this.del = function(id)
	{
		
	}
}
var comm = new Commission("<?php echo $member['id']?>");
$(document).ready(function(e) {
    comm.getList();
});
</script>
<div class="section">

	<div class="section-title"><?php echo $member['fullname']?></div>
    
    <div class="section-content">
    	<form id="frmHoaHong">
     
                <input type="hidden" id="memberid" name="memberid" value="<?php echo $member['id']?>"/>
                <input type="text" class="text date" id="ngaytinhhoahong" name="ngaytinhhoahong" />
                <script language="javascript">
                $(function() {
                    $("#ngaytinhhoahong").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                <input type="button" class="button" value="Thêm kỳ" onClick="comm.add()"/>
                
            
        </form>
        <div id="commissionlist">
        
        </div>
        <form id="frm_thongke">
        	<div id="ben-search">
            	
                <label>Từ ngày</label>
                <input type="text" class="text date" id="tungay" name="tungay" />
                <script language="javascript">
                $(function() {
                    $("#tungay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                <label>Đến ngày</label>
                <input type="text" class="text date" id="denngay" name="denngay" />
                <script language="javascript">
                $(function() {
                    $("#denngay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                
                <br />
                <input type="button" class="button" id="btnThongKe" name="btnThongKe" value="Xem"/>
                
            </div>
        	
            <div class="clearer">^&nbsp;</div>
            
            <div id="showresult">
                
            </div>
        	<input type="button" class="button" id="btnSaveToExcel" name="btnSaveToExcel" value="Lưu thành excel"/>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
$('#btnThongKe').click(function(e) {
	$('#showresult').html(loading);
    $.post("?route=core/member/thongke", 
		$("#frm_thongke").serialize(), 
		function(html)
		{
			$('#showresult').html(html);
		}
	);
});
$('#btnSaveToExcel').click(function(e) {
	tableToExcel('reportbanhang', 'Ho Lan Solutions');
});
</script>