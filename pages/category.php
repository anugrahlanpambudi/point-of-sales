<?php

$q_categories = mysqli_query($koneksi, 'SELECT * FROM categories');
$categories = mysqli_fetch_all($q_categories, MYSQLI_ASSOC);

if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $q_delete = mysqli_query($koneksi, "DELETE FROM categories WHERE id=$id");

    header('location:?page=category');
}

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category</title>
</head>

<body>
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-tittle">Data Categories</h3>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-end m-2">
                        <a href="?page=tambah-category" class="btn btn-primary">Add Categories</a>
                    </div>
                    <table class="table table-bordered">
                        <tr>
                            <th>No</th>
                            <th>Category Name</th>
                            <th>Actions</th>
                        </tr>
                        
                        <?php 
                        foreach($categories as $key => $category){
                            ?>
                        <tr>
                            <td> <?php echo $key + 1; ?></td>
                            <td> <?php echo $category['category_name']; ?></td>
                            <td>
                                <a href="?page=tambah-category&edit=<?php echo $category['id']; ?>" class="btn btn-success"><i class="bi bi-pencil"></i> Edit</a>
                                <form class="d-inline" action="?page=category&delete=<?php echo $category['id']; ?>" method="post"
                                    onclick="return confirm('Are you sure for delete this?')">
                                    <button type="submit" class="btn btn-danger"><i class="bi bi-trash"></i> Delete</button>
                                </form>
                            </td>
                        </tr>
                        <?php 
                        }
                        ?>

                    </table>

                </div>
            </div>
        </div>
    </div>

</body>

</html>
