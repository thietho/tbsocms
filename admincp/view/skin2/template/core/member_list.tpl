<div class="section">

	<div class="section-title">Quản lý khách hàng</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listmember" name="listmember">
        
        	<div class="button right">
               	
                <?php if(@$this->user->checkPermission("core/member/insert")==true){ ?>
                <input type="button" class="button" value="Thêm" onclick="showMemberForm('','searchForm()')" />
                <?php } ?>
                <?php if(@$this->user->checkPermission("core/member/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteUser()"/>  
                <?php } ?>
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
            <div id="ben-search">
            	<p>
                    <label>Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="text"/>
                    
                    <label>Tên khách hàng</label>
                    <input type="text" id="fullname" name="fullname" class="text"/>
                    <label>Số diện thoai</label>
                    <input type="text" id="phone" name="phone" class="text"/>
                    <br />
                    <label>Địa chỉ</label>
                    <input type="text" id="address" name="address" class="text"/>
                    <label>Email</label>
                    <input type="text" id="email" name="email" class="text"/>
                
                	<label>Assign</label>
					<input type="hidden" id="assignid" name="assignid" value="<?php echo @$user['assignid']?>"/>
                    <input type="text" id="assignname" name="assignname" value="" class="text"/>
                
                    <label>Tình trạng</label>
                    <select id="status" name="status">
                        <option value=""></option>
                        <?php foreach(@$this->document->userstatus as $key => $val){ ?>
                        <option value="<?php echo @$key?>"><?php echo @$val?></option>
                        <?php } ?>
                    </select>
                
                </p>
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
                <input type="button" class="button" name="btnExport" value="In danh sách" onclick="exportExcel()"/>
            </div>
            <div class="sitemap treeindex" id="memberlist">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    viewAll();
	$(function() {
		var cache = {};
		
		$("#listmember #assignname").autocomplete({
			minLength: 2,
			select: function( event, ui ) {
				//console.log(ui.item.id);
				//objdl.getProbyMediaId(ui.item.id);
				//alert(ui.item.data.fullname);
				$('#listmember #assignid').val(ui.item.id);
				$('#listmember #assignname').val(ui.item.data.fullname);
				searchForm();
			},
			source: function( request, response ) {
			var term = request.term;
			if ( term in cache ) {
				response( cache[ term ] );
				return;
			}
			$.getJSON( "?route=core/member/getMember", request, function( data, status, xhr ) {
				cache[ term ] = data;
				response( data );
				});
			}
		});
		
	});
});
$('#listmember .text').keyup(function(e) {
    //if(e.keyCode == 13)
		searchForm();
	
});
$('#listmember select').change(function(e) {
    searchForm();
});

function activeUser(userid)
{
	$.ajax({
			url: "?route=core/member/active&id="+userid,
			cache: false,
			success: function(html){
			alert(html)
			loadData("?route=core/member/getList")
		  }
	});
}

function deleteUser()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=core/member/delete", 
				$("#listmember").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}
function loadData(url)
{
	$('#memberlist').html(loading);
	$('#memberlist').load(url);
}
function viewAll()
{
	var url = "?route=core/member/getList";


	if("<?php echo @$_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	loadData(url);
}
function exportExcel()
{
	var url = createParam();
	/*$('#exportdata').load("?route=core/member/exportTable"+url,function(){
		tableToExcel('memberexport', 'Ho Lan Solutions');
	});*/
	openDialog("?route=core/member/exportTable"+url,800,500);
	/*$.get("?route=core/member/export"+url,function(data){
			window.location = "download.php?url="+ encodeURI(data);
		});		*/
}
function createParam()
{
	var url = "";
	if($("#listmember #username").val() != "")
		url += "&username=" + encodeURI($("#listmember #username").val());
	if($("#listmember #fullname").val() != "")
		url += "&fullname="+ encodeURI($("#listmember #fullname").val());
	if($("#listmember #phone").val() != "")
		url += "&phone="+ encodeURI($("#listmember #phone").val());
	if($("#listmember #address").val() != "")
		url += "&address="+ encodeURI($("#listmember #address").val());
	if($("#email").val() != "")
		url += "&email="+ encodeURI($("#email").val());
	if($("#listmember #status").val() != "")
		url += "&status="+ $("#listmember #status").val();
	if($("#listmember #assignid").val() != "")
		url += "&assignid="+ $("#listmember #assignid").val();
	return url;
}
function searchForm()
{
	
	var url = createParam();
	if("<?php echo @$_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=core/member/getList"+url);
}

$("#username").val("<?php echo @$_GET['username']?>");
$("#fullname").val("<?php echo @$_GET['fullname']?>");
$("#phone").val("<?php echo @$_GET['phone']?>");
$("#address").val("<?php echo @$_GET['address']?>");
$("#email").val("<?php echo @$_GET['email']?>");
$("#status").val("<?php echo @$_GET['status']?>");

function viewCongNo(id)
{
	$("#popup").attr('title','Công nợ');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: $(document).width()-100,
					height: window.innerHeight,
					modal: true,
					buttons: {
						'Đóng': function() {
							$( this ).dialog( "close" );
							
						},
						
						'In': function(){
							openDialog("?route=core/member/getCongNo&khachhangid="+id+"&dialog=print",800,500)
							
						},
					}
				});
			
	$("#popup").dialog("open");	
	$("#popup-content").html(loading);			
	$("#popup-content").load("?route=core/member/getCongNo&khachhangid="+id+"&dialog=true",function(){
		
	});
}

function moveto(url,eid)
{
	$('#'+eid).load(url);
}
</script>