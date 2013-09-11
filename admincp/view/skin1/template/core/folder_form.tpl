<form id="frm_folder">
	<input type="hidden" name="folderid" value="<?php echo $item['folderid']?>"/>
    <input type="hidden" name="folderparent" value="<?php echo $item['folderparent']?>"/>
    <p>
        <label>Tên thư mục</label>
        <input type="text" class="text" id="foldername" name="foldername" value="<?php echo $item['foldername']?>"/>
    </p>
</form>