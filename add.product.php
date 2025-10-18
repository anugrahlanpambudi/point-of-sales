<?php
require_once 'koneksi.php';

$selectCategories = mysqli_query($koneksi, 'SELECT * FROM categories');
$categories = mysqli_fetch_all($selectCategories,MYSQL_ASSOC);

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body>
    <H1>Add Product</H1>
    <form action="" method="post" enctype="multipart/form-data">
        <label for="">Category Name</label><br>
        <select name="category_id" required>
            <option value="">--Choose Category--</option>

            <?php 
            foreach($categories as $c){
            ?>
                <option value="<?php echo $c['id']?>"><?php echo $c['category_name']?></option>

            <?php 
            }
            ?>
            <option value=""></option>
        </select>

    </form>

</body>

</html>
