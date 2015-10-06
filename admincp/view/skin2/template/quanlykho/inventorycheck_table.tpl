				<?php echo @$pager?>
<form id="frm_listinventory">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if(@$dialog!=true){ ?>
                        <th width="1%">
                        <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                        </th>
                        <?php } ?>
                        <th width="1%">STT</th>
                        <th>Ngày kiểm</th>
                        <th>Ghi chú</th>
                        
                        <th>Control</th>            
                                      
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                    	<?php if(@$dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
                        <?php } ?>
                        <td align="center"><?php echo @$key+1 ?></td>
                        <td><?php echo @$this->date->formatMySQLDate($item['datecheck'])?></td>
                        <td><?php echo @$item['note']?></td>
                       	
                        <?php if(@$dialog==false){ ?>
                        <td class="link-control">
                            <?php if(@$this->user->checkPermission("sales/shop/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo @$item['text_edit']?>" onclick="window.location='<?php echo @$item['link_edit']?>'"/>
                            <?php } ?>
                            
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
</form>
                <?php echo @$pager?>