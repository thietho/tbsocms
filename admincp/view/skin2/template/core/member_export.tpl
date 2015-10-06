			
            <table id="memberexport" class="table-data">
            	<thead>
                	<tr>
                        <th>STT</th>
                        
                        
                        <th>Tên khách hàng</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Email</th>
                                                      
                        
                    </tr>
                </thead>
                <tbody>
                    
                    
        
        
        <?php
            foreach($users as $key => $user)
            {
        ?>
                    <tr>
                        <td><center><?php echo @$key + 1 ?></center></td>
                        
                        
                        <td><?php echo @$user['fullname']?></td>
                        <td><?php echo @$user['phone']?></td>
                        <td><?php echo @$user['address']?></td>
                        <td><?php echo @$user['email']?></td>
                        
                        
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
			</table>
            