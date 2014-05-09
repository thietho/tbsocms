			<?php echo $pager?>
			
    <?php foreach($medias as $key => $media) {?>
    <div class="listitem " id="<?php echo $media['mediaid']?>" price="<?php echo $this->string->numberFormate($media['price'])?>" >
        <input type="hidden" class="listid" name="mediaid[]" value="<?php echo $media['mediaid']?>">
        <table class="data-table">
            
            <tr class="item">
                <td width="100px">
                	<img src="<?php echo $media['imagepreview']?>" /><br />
                    
                    
                    <!--
                    -->
                </td>
                <td>
                	<?php echo $this->document->productName($media)?><br />
                    Giảm: <?php echo $this->string->numberFormate($media['discountpercent'])?>%<br />
                    Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                    Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?><br />
                    <?php if($media['tonkho']) echo "Tồn: ".$media['tonkho']?>
                    <?php if(count($media['child'])==0){ ?>
                            
                    <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $media['mediaid']?>')"/>
                    
                    <?php } ?>
                    <?php if(count($media['child'])){ ?>
                    <table>
                    <?php foreach($media['child'] as $k => $child){ ?>
                    	<tr>
                        	<td>
                            	<?php echo $child['sizes']?>: <?php echo $this->string->numberFormate($child['price'])?><br />
                                <?php if($child['tonkho']) echo "Tồn: ".$child['tonkho']?>
                            </td>
                            <td>
                            	Barcode: <?php echo $child['barcode']?><br />
                   	 			Ref: <?php echo $child['ref']?>
                            </td>
                    		<td>
                            	<input type="button" class="button" value="Sửa" onclick="showProductForm('<?php echo $child['mediaid']?>','<?php echo $media['mediaid']?>','pro.searchForm()');"/>
                            	<input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $child['mediaid']?>')"/>
                            </td>
                        
                        
                        </tr>
                    <?php } ?>
                    </table>
                    <?php } ?>
                </td>
                <td width="150px">
                	Barcode: <?php echo $media['barcode']?><br />
                    Ref: <?php echo $media['ref']?>
                </td>
                <td width="150px">
                	Nhãn hiệu: <?php echo $this->document->getCategory($media['brand'])?><br />
                    Trạng thái:<?php echo $this->document->status_media[$media['status']]?><br />
                    <?php echo $media['sitemapname']?>
                </td>
            </tr>
        </table>
    </div>
                    
                       
                    
                	
                    	
                    <?php } ?>                	
                	
            <div class="clearer">^&nbsp;</div>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
 <!--<div class="popupmenu">
                            <?php if($this->user->checkPermission("module/product/update")==true){ ?>
                                
                            
                            <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="showProductForm('<?php echo $media['mediaid']?>','pro.searchForm()')"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                            
                            <input type="button" class="button" value="<?php echo $media['text_addchild']?>" onclick="window.location='<?php echo $media['link_addchild']?>'"/>
                            <input type="button" class="button enterGroup" value="Đưa vào nhóm" onclick="pro.enterGroup('<?php echo $media['mediaid']?>')"/>
                            <input type="button" class="button selectGroup" value="Chọn" onclick="pro.selectGroup('<?php echo $media['mediaid']?>')"/>
                            <?php }?>
                            <input type="button" class="button" value="Lịch sử" onclick="pro.history('<?php echo $media['mediaid']?>')"/>
                            <?php if(count($media['child'])==0){ ?>
                            
                            <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $media['mediaid']?>')"/>
                            
                            <?php } ?>
                        </div>-->
<script language="javascript">
$(function(){
    $.contextMenu({
        selector: '.listitem', 
        callback: function(key, options) {
            var m = "clicked: " + key;
            window.console && console.log(m);
			
			switch(key)
			{
				case "edit":
					showProductForm($(this).attr('id'),'','pro.searchForm()');
					break;
				case "addSizes":
					showProductForm('',$(this).attr('id'),'pro.searchForm()');
					break;
				case "viewHistory":
					pro.history($(this).attr('id'));
					break;
				case "del":
					pro.delete($(this).attr('id'));
					break;
			}
        },
        items: {
			<?php if($this->user->checkPermission("module/product/update")==true){ ?>
            "edit": {name: "Sửa"},
			<?php } ?>
			<?php if($this->user->checkPermission("module/product/insert")==true){ ?>
            "addSizes": {name: "Thêm qui cách"},
            <?php } ?>
			"viewHistory": {name: "Lịch sử"},
			<?php if($this->user->checkPermission("module/product/deleted")==true){ ?>
			"del": {name: "Xóa"},
			<?php } ?>
        }
    });
    
    $('.listitem').on('click', function(e){
        console.log('clicked', this);
    })
});
</script>