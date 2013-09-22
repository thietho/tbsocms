function PhieuNhapXuat()
{
	this.index = 0;
	this.addRow = function(id,mediaid,code,title,soluong,madonvi,giatien,giamgia,phantramgiamgia)
	{
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="nhapkhoid-'+ this.index +'" name="nhapkhoid['+ this.index +']" value="'+ id +'" /><input type="hidden" id="mediaid-'+ this.index +'" name="mediaid['+ this.index +']" value="'+ mediaid +'" /><input type="hidden" id="code-'+ this.index +'" name="code['+ this.index +']" value="'+ code +'" />'+ code +'</td>';
		row +='<td><input type="hidden" id="title-'+ this.index +'" name="title['+ this.index +']" value="'+ title +'" />'+ title +'</td>';
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number short soluong" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><select mediaid="'+mediaid+'" id="madonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+madonvi+'"></section></td>';
		row +='<td class="number"><input type="text" id="giatien-'+ this.index +'" name="giatien['+ this.index +']" value="'+giatien+'" class="text number short giatien" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="phantramgiamgia-'+ this.index +'" name="phantramgiamgia['+ this.index +']" value="'+phantramgiamgia+'" class="text number short phantramgiamgia" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="giamgia-'+ this.index +'" name="giamgia['+ this.index +']" value="'+giamgia+'" class="text number short giamgia" ref="'+ this.index +'"/></td>';
		
		row += '<td class="number thanhtien" id="thanhtien-'+ this.index +'">'+ formateNumber(soluong * giatien) +'</td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>'
		$('#nhapkhonguyenlieu').append(row);
		var str = '#madonvi-'+ this.index;
		$.getJSON("?route=core/media/getListDonVi&mediaid="+ mediaid,
			function(data){
				html = "";
				for(i in data)
				{
					//alert(data[i].madonvi)
					html += '<option value="'+data[i].madonvi+'">'+data[i].tendonvitinh+'</option>';
				}
				$(str).html(html);
				$(str).val(madonvi);
			});
		objdl.tinhtong(this.index);
		this.index++;
		$('.soluong').keyup(function(e) {
            var pos = $(this).attr('ref');
			objdl.tinhtong(pos);
        });
		$('.giatien').keyup(function(e) {
            var pos = $(this).attr('ref');
			objdl.tinhtong(pos);
        });
		$('.giamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var giamgia = Number(stringtoNumber($('#giamgia-'+pos).val()));
			var phantramgiamgia = giamgia/giatien *100;
			$('#phantramgiamgia-'+pos).val(formateNumber(phantramgiamgia))
			objdl.tinhtong(pos);
        });
		$('.phantramgiamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
			var giamgia = giatien * phantramgiamgia/100;
			$('#giamgia-'+pos).val(formateNumber(giamgia))
			objdl.tinhtong(pos);
        });
		numberReady();
	}
	this.removeRow = function(pos)
	{
		var nhapkhoid = $('#nhapkhoid-'+pos).val();
		$('#delnhapkho').val(nhapkhoid+ "," +$('#delnhapkho').val());
		$('#row'+pos).remove();
		this.tinhtong(pos);
	}
	this.tinhtong = function(pos)
	{
		var soluong = Number(stringtoNumber($('#soluong-'+pos).val()));
		var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
		var giamgia = Number(stringtoNumber($('#giamgia-'+pos).val()));
		var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
		var thanhtien = soluong*(giatien-giamgia);
		$('#thanhtien-'+pos).html(formateNumber(thanhtien));
		var sum = 0;
		$('.thanhtien').each(function(index, element) {
            sum += Number(stringtoNumber($(this).html()));
        });
		$('#tongcong').html(formateNumber(sum));
		$('#tongtien').val(sum);
		var thanhtoan = Number(stringtoNumber($('#thanhtoan').val()));
		$('#congno').val(sum - thanhtoan);
		$('#lbl-congno').html(formateNumber(sum - thanhtoan));
	}
}

var objdl = new PhieuNhapXuat();