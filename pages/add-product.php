<?php

$id = isset($_GET['edit']) ? $_GET['edit'] : '';
$selectCategories = mysqli_query($koneksi, "SELECT * FROM categories");
$categories = mysqli_fetch_all($selectCategories, MYSQLI_ASSOC);
if(isset($_POST['save'])){
    $c_id = $_POST['category_id'];
    $p_name = $_POST['product_name'];
    $p_price = $_POST['product_price'];
    $p_description = $_POST['product_description'];
    $p_photo = $_FILES['product_photo'];

    $filepath = "assets/uploads/" .time() . "-" .$p_photo['name'];
    move_uploaded_file($p_photo['tmp_name'], $filepath);

    $insertProduct = mysqli_query($koneksi, "INSERT INTO products (category_id, product_name, product_price, product_description, product_photo )
     VALUE (' $c_id', '$p_name', '$p_price', '$p_description', '$filepath')");
    if($insertProduct){
        header("location:?page=product");
    }
   
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body><div class="card">
    <div class="card-header">
        <h3 class="card-tittle">Add Product</h3>
    </div>
    <div class="card-body">
        <form action="" method="post" enctype="multipart/form-data">
            <div class="w-50">
                <label class="form-label" for="">Category Name</label><br>
                <select class="form-select" name="category_id" required>
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
                <label class="form-label" for="">Produck Name</label>
                <input class="form-control" type="text" name="product_name" required >
                <label for="" class="form-label">Photo</label>
                <input class="form-control" type="file" name="product_photo">
                <label for="" class="form-label">Price</label>
                <input class="form-control" type="number" name="product_price" required>
                <label for="" class="form-label">Description</label>
                <textarea class="form-control" name="product_description" cols="30" rows="5"></textarea>
                <button type="submit" class="btn btn-primary mt-2" name="save">Add</button>
            </div>
           
        </form>

    </div>
</div>
    

</body>

</html>
