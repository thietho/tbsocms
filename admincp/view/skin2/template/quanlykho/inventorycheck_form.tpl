<div class="section">

	<div class="section-title"><?php echo @$this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_inventorycheck" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="inven.save()"/>
                <input type="button" value="Trở về" class="button" onClick="window.location = '?route=quanlykho/inventorycheck';"/>
     	        <input type="hidden" name="id" value="<?php echo @$item['id']?>">
                <input type="hidden" name="nhanvienid" value="<?php echo @$item['nhanvienid']?>">
                
                
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
                        
                        <input type="text" class="text"  id="datecheck" name="datecheck" value="<?php echo @$this->date->formatMySQLDate($item['datecheck'])?>"/>
                        <script language="javascript">
                            $(function() {
                                $("#datecheck").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="note" name="note"><?php echo @$item['note']?></textarea>
                        
                    </p>
                </div>
                <div id="fragment-sanpham">
                	<table>
                    	<thead>
                            <tr>
                                
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Đơn vị tính</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="listproduct">
                        	
                        </tbody>
                        <tfoot>
                        	<tr>
                            	<td colspan="8">
                                	<input type="text" id="txt_ref" class="text" size="100"/>
                                    
                                </td>
                            </tr>
                    	</tfoot>
                	</table>
                    <input type="hidden" id="delinventoryid" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                </div>
            </div>
            
		</form>
    </div>
</div>

<script language="javascript">
$(document).ready(function(e) {
	$('#inventorycheck').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	$("#listproduct").sortable();
	if($('#datecheck').val()=='')
		$('#datecheck').val(intToDate(Date.now()));
});
$('#btnAddRow').click(function(e) {
	browseProduct('inven.addFunction()');
});
$(function() {
	var cache = {};
	$( "#txt_ref" ).autocomplete({
		minLength: 2,
		select: function( event, ui ) {
			//console.log(ui.item.id);
			inven.getProbyMediaId(ui.item.id);
			/*var obj = ui.item.data
			var giagiam = 0;
			if(obj.pricepromotion > 0)
			{
				giagiam = obj.price - obj.pricepromotion;
			}
			objdl.addRow('',obj.mediaid,obj.code,obj.productName,1,obj.unit,obj.price,giagiam,obj.discountpercent);
			setTimeout("$('#txt_ref').val('')",1000);*/
		},
		source: function( request, response ) {
		var term = request.term;
		if ( term in cache ) {
			response( cache[ term ] );
			return;
		}
		$.getJSON( "?route=core/media/getProduct", request, function( data, status, xhr ) {
			cache[ term ] = data;
			response( data );
			});
		}
	});
});
function Inventory()
{
	this.index = 0;
	this.save = function()
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" });
		$.post("?route=quanlykho/inventorycheck/save",$('#frm_inventorycheck').serialize(),function(data){
			var obj = $.parseJSON(data);
			if(obj.error == '')
			{
				
				inven.delDetail($('#delinventoryid').val());
				//inven.saveDetail(obj,'');
				inven.saveDetail(obj,'window.location = "?route=quanlykho/inventorycheck";');
			}
			else
			{
				$('#error').html(obj.error).show('slow');	
				$.unblockUI();
			}
			
		});	
	}
	this.addRow = function(id,mediaid,title,quantity,unit)
	{
		var row = '<tr class="itemdetail" id="row'+ this.index +'" index="'+ this.index +'">';
		row += '<td><input type="hidden" id="id-'+ this.index +'" value="'+ id +'"><input type="hidden" id="mediaid-'+ this.index +'" value="'+ mediaid +'">'+title+'</td>';
		row += '<td class="number"><input type="text" class="text number short soluong" id="quantity-'+ this.index +'" value="'+quantity+'"></td>';
		row += '<td class="number"><select mediaid="'+mediaid+'" class="madonvi" id="unit-'+ this.index +'" value="'+unit+'" ref="'+ this.index +'"></select></td>';
		row +='<td><input type="button" class="button" value="X" onclick="inven.removeRow('+ this.index +')"/></td>';
		row += '</tr>';
		$('#listproduct').append(row);
		var str = '#unit-'+ this.index;
		this.index++;
		$.getJSON("?route=core/media/getListDonVi&mediaid="+ mediaid,
			function(data){
				html = "";
				for(i in data)
				{
					//alert(data[i].madonvi)
					html += '<option value="'+data[i].madonvi+'">'+data[i].tendonvitinh+'</option>';
				}
				$(str).html(html);
				$(str).val(unit);
			});
		numberReady();
	}
	this.removeRow = function(pos)
	{
		var delid = $('#id-'+pos).val();
		$('#delinventoryid').val(delid + "," +$('#delinventoryid').val());
		$('#row'+pos).remove();
		
	}
	this.getProbyMediaId = function(str)
	{
		
		arr = str.split("-");
		$.getJSON("?route=core/media/getMedia&col=mediaid&val="+encodeURI(arr[0]),function(data)
		{			
			
			inven.addRow(0,data.medias[0].mediaid,data.medias[0].title,1,data.medias[0].unit);
			
			$('#txt_ref').val('');
		});
	}
	this.delDetail = function(listid)
	{
		$.post("?route=quanlykho/inventorycheck/delDetail",
			{
				delinventoryid:listid	
			});
	}
	this.saveItem = function(obj,p,callback)
	{
		
		if(p < this.listrows.length)
		{
			pos = this.listrows[p];
			//$.blockUI({ message: "<h1>Please wait..."+pos+"</h1>" }); 
			var percent = Math.round( (p + 1) / Number(this.listrows.length)*100 );
			$('.blockMsg').html("<h1>Please wait..."+ percent +"%</h1>");
			$.post("?route=quanlykho/inventorycheck/saveDetail",
			{
				id:$('#id-'+ pos).val(),
				inventoryid:obj.id,
				mediaid:$('#mediaid-'+pos).val(),
				quantity:$('#quantity-'+pos).val(),
				unit:$('#unit-'+pos).val(),
				position:p
			},
			function(data)
			{
				
				inven.saveItem(obj,p+1,callback);
				
				
			});
		}
		else
		{
			$.unblockUI();
			if(callback !='')
				setTimeout(callback,0);
		}
		
	}
	this.listrows = new Array();
	this.saveDetail = function(obj,callback)
	{
		var arr = new Array();
		
		$('.itemdetail').each(function(index, element) {
            arr.push($(this).attr('index'));
        });
		this.listrows = arr;
		this.saveItem(obj,0,callback);
	}
	this.addFunction = function()
	{
		$('.selectProduct').click(function(e) {
			var obj = new Object();
			obj.id = 0;
			obj.mediaid = $(this).attr('ref');
			obj.imagepath = $(this).attr('image');
			obj.title = $(this).attr('title');
			obj.code = $(this).attr('code');
			obj.unit = $(this).attr('unit');
			//console.log(obj.mediaid);
			obj.price = $(this).attr('price');
			
			obj.pricepromotion = $(this).attr('pricepromotion');
			obj.discountpercent = $(this).attr('discountpercent');
			obj.productname = $(this).attr('productname');
			obj.brandname = $(this).attr('brandname');
			
			var giagiam = 0;
			if(obj.pricepromotion > 0)
			{
				giagiam = obj.price - obj.pricepromotion;
			}
			
			inven.addRow(0,obj.mediaid,obj.title,1,obj.unit);
			
			
			$("#popupbrowseproduct").dialog("close");
		});
	}
}
var inven = new Inventory();
</script>
<?php foreach($data_detail as $detail){ ?>
<script language="javascript">
inven.addRow("<?php echo @$detail['id']?>","<?php echo @$detail['mediaid']?>","<?php echo @$this->document->productName($detail['mediaid'])?>","<?php echo @$detail['quantity']?>","<?php echo @$detail['unit']?>");
</script>
<?php } ?>