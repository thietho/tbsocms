<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	<h3>Số lượng sản phẩm đang tồn kho tính đến ngày <?php echo $this->date->formatMySQLDate($this->date->getTodayNoTime())?></h3>
		<table class="data-table">
            <thead>
                <tr>
                	<th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    
                    
                </tr>
            </thead>
            
        </table>    	
        
        
    </div>
    
</div>
