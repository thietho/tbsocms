<center>
    <h2>Báo giá</h2>
</center>
<table>
	<tr>
        <td align="right">
        	<p>
            	Ngày <?php echo $this->date->getDay($item['ngaybaogia'])?> tháng <?php echo $this->date->getMonth($item['ngaybaogia'])?> năm <?php echo $this->date->getYear($item['ngaybaogia'])?>
            </p>
            
        </td>
    </tr>
    <?php if($item['ghichu']!=""){ ?>
    <tr>
    	<td>
            <div class="cusinfo">
                <?php echo $item['ghichu']?>
            </div>
        </td>
	</tr>
    <?php } ?>
</table>