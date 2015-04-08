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
	this.view = function(tungay,denngay)
	{
		$('#showresult').html(loading);
		$.post("?route=core/member/thongke", 
			{
				memberid:this.memberid,
				tungay:tungay,
				denngay:denngay
			}, 
			function(html)
			{
				$('#showresult').html(html);
			}
		);
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
				str+= '<input type="button" class="button viewhoahong" value="Xem" tungay="'+tungay+'" denngay="'+denngay+'"/>';
				str+= '<input type="button" class="button delhoahong" value="Xóa" hoahongid="'+ data[i].id +' tungay="'+tungay+'" denngay="'+denngay+'""/>';
				str+= "</li>"
			}
			str += "</ul>";
			$('#commissionlist').html(str);
			$(".delhoahong").click(function(e) {
				var ans = confirm("Bạn có muốn xóa đợt tính hoa hồng ngày "+ $(this).attr("denngay"));
				if(ans)
				{
					comm.del($(this).attr('hoahongid'));
				}
			});
			$('.viewhoahong').click(function(e) {
                comm.view($(this).attr('tungay'),$(this).attr('denngay'))
            });
		});
	}
	this.del = function(id)
	{
		$.get('?route=core/member/delCommission&id='+id,function(html)
		{
			alert(html);
			comm.getList();
		});
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
        
        <div id="showresult">
                
        </div>
        <input type="button" class="button" id="btnSaveToExcel" name="btnSaveToExcel" value="Lưu thành excel"/>
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