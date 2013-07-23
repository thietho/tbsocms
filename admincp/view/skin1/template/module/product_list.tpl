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
                        	<a class="button" href="<?php echo $media['link_edit']?>" title="<?php echo $media['text_edit']?>"><?php echo $media['text_edit']?></a>
                            <?php } ?>
                            <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                  			<a class="button" href="<?php echo $media['link_addchild']?>" title="<?php echo $media['text_addchild']?>"><?php echo $media['text_addchild']?></a>          
                            <?php }?>
                        </td>
                    </tr>
                    	<?php if(count($media['child'])){ ?>
                        	<?php foreach($media['child'] as $k => $child){ ?>
                    <tr class="media-child">
                    	<td>
                        	<input type="checkbox" value="<?php echo $child['mediaid']?>" name="delete[<?php echo $child['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $child['mediaid']?>]" value="<?php echo $k +1?>" size="3"/>
                        </td>
                        
                        <td><b><?php echo $child['code']?></b>&nbsp;</td>
                        <td><b><?php echo $child['sizes']?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($child['price'])?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($child['pricepromotion'])?></b>&nbsp;</td>
                        <td class="number">
                        	
                        </td>
                       
                        <td><b><?php echo $child['title']?></b>&nbsp;</td>
                        
                        <td><?php echo $child['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	<a class="button" href="<?php echo $child['link_edit']?>" title="<?php echo $child['text_edit']?>"><?php echo $media['text_edit']?></a>
                            <?php } ?>
                           
                        </td>
                    </tr> 
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
