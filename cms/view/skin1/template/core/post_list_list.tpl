			<?php echo $pager?>
			<table class="data-table" width="100%">
            
            	<thead>
                	<th width="10%"><?php echo $column_position?></th>
                    <th width="20%"><?php echo $column_title?></th>
                    <th width="40%"><?php echo $column_summary?></th>
                    <th width="20%"><?php echo $column_image?></th>
                    <th width="10%"><?php echo $column_control?></th>
                </thead>
                
                <tbody>
                    <?php foreach($medias as $key => $media) {?>
                	<tr>
                    	<td>
                        	<input type="checkbox" value="<?php echo $media['mediaid']?>" name="delete[<?php echo $media['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $media['mediaid']?>]" value="<?php echo $key+1?>" size="3"/>
                        </td>
                        <td><b><?php echo $media['title']?></b>&nbsp;</td>
                        <td><?php echo html_entity_decode($media['summary'])?>&nbsp;</td>
                        <td><?php echo $media['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($permissionEdit){?>
                        	<a class="button" href="<?php echo $media['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $button_edit?></a>
                            <?php }?>
                        </td>
                    </tr>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
