			<h2><?php echo $breadcrumb?></h2>
			<?php echo $pager?>
			<table class="data-table" width="100%">
            
            	<thead>
                	<th width="10%"><?php echo $column_position?></th>
                    
                    <th>Code</th>
                    <th>Quy cách</th>
                    <th>Giá</th>
                    <th>Giá khuyến mãi</th>
                    <th width="200px">Tồn kho</th>
   
                    <th>Tên sản phẩm</th>
                    
                    <th>Hình</th>
                    <th></th>
                </thead>
                
                <tbody>
                    <?php foreach($medias as $key => $media) {?>
                	<tr>
                    	<td>
                        	<input type="checkbox" value="<?php echo $media['mediaid']?>" name="delete[<?php echo $media['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $media['mediaid']?>]" value="<?php echo $key+1?>" size="3"/>
                        </td>
                        
                        <td><b><?php echo $media['code']?></b>&nbsp;</td>
                        <td><b><?php echo $media['sizes']?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($media['price'])?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($media['pricepromotion'])?></b>&nbsp;</td>
                        <td class="number">
                        	<?php echo $media['tonkho']['main']['tonkho']?>
                            <?php foreach($media['tonkho']['prices'] as $price){ ?>
                            <br />
                            <?php echo $price['title']?>: <?php echo $price['tonkho']?>
                            <?php } ?>
                        </td>
                       
                        <td><b><?php echo $media['title']?></b>&nbsp;</td>
                        
                        <td><?php echo $media['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	<a class="button" href="<?php echo $media['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $button_edit?></a>
                            <?php } ?>
                        </td>
                    </tr>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
