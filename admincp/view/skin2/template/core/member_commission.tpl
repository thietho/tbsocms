
<script language="javascript">
function Commission(memberid)
{
	this.memberid = memberid
	
	this.save = function()
	{
		
		$.post("?route=core/member/commissionsave",$('#frmHoaHong').serialize(),function(){
			comm.getList();
			$('#frmHoaHong #id').val("");
			$('#frmHoaHong #ngaytinhhoahong').val("");
			$('#frmHoaHong #cachtinh').val("");
			comm.showBotton();
		});	
	};
	this.viewSale = function(tungay,denngay)
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
	this.viewSalesProduct = function(tungay,denngay)
	{
		$('#showresult').html(loading);
		$.post("?route=core/member/thongkeSalesProduct", 
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
				str+= " cách tính: "+ data[i].cachtinhtext;
				str+= '<input type="button" class="button viewhoahong" value="Xem" tungay="'+tungay+'" denngay="'+denngay+'" cachtinh="'+ data[i].cachtinh +'"/>';
				str+= '<input type="button" class="button edithoahong" value="Sửa" hoahongid="'+ data[i].id +' tungay="'+tungay+'" denngay="'+denngay+'" cachtinh="'+ data[i].cachtinh +'"/>';
				str+= '<input type="button" class="button delhoahong" value="Xóa" hoahongid="'+ data[i].id +' tungay="'+tungay+'" denngay="'+denngay+'"/>';
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
				switch($(this).attr('cachtinh'))
				{
					case "sales":
						comm.viewSale($(this).attr('tungay'),$(this).attr('denngay'));
						break;
					case "salesproduct":
						comm.viewSalesProduct($(this).attr('tungay'),$(this).attr('denngay'));
						break;
				}
                
            });
			$('.edithoahong').click(function(e) {
                $('#frmHoaHong #id').val($(this).attr('hoahongid'));
				$('#frmHoaHong #ngaytinhhoahong').val($(this).attr('denngay'));
				$('#frmHoaHong #cachtinh').val($(this).attr('cachtinh'));
				comm.showBotton();
            });
			comm.showBotton();
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
	this.showBotton = function()
	{
		if($('#frmHoaHong #id').val()=="")
		{
			$('#btnAdd').show();
			$('#btnEdit').hide();
		}
		else
		{
			$('#btnAdd').hide();
			$('#btnEdit').show();
		}
	}
}
var comm = new Commission("<?php echo @$member['id']?>");

$(document).ready(function(e) {
    comm.getList();
	
});
</script>
<div class="section">

	<div class="section-title"><?php echo @$member['fullname']?></div>
    
    <div class="section-content">
    	<form id="frmHoaHong">
     			<input type="hidden" id="id" name="id" value=""/>
                <input type="hidden" id="memberid" name="memberid" value="<?php echo @$member['id']?>"/>
                <label>Ngày tinh hoa hồng</label>
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
                <label>Cách tính</label>
                <select id="cachtinh" name="cachtinh">
                	<?php foreach($commissionway as $val){ ?>
                    <option value="<?php echo @$val['categoryid']?>"><?php echo @$val['categoryname']?></option>
                    <?php } ?>
                </select>
                <input type="button" id="btnAdd" class="button" value="Thêm kỳ" onClick="comm.save()"/>
                <input type="button" id="btnEdit" class="button" value="Lưu" onClick="comm.save()"/>
                
            
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