<?php
require_once 'koneksi.php';

$query = mysqli_query(
    $koneksi,
    "SELECT r.name AS role_name, u.* FROM users AS u LEFT JOIN 
    roles AS r ON r.id = u.role_id WHERE u.deleted_at IS NOT NULL ORDER BY u.id DESC",
);

$users = mysqli_fetch_all($query, MYSQLI_ASSOC);

if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $delete = mysqli_query($koneksi, "DELETE FROM users WHERE id= '$id'");
    header('location:user.php?hapus=berhasil');
}

if(isset($_GET['restore'])){
    $id = $_GET['restore'];
    $restore = mysqli_query($koneksi, "UPDATE users SET deleted_at=null WHERE id=$id");
    header("location:user-restore.php");
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Restore</title>
</head>

<body>
    <h1 style="text-align: center">Data User</h1>
    <div align="left">
        <a href="tambah-user.php">Back</a> 
    </div>
    <br>
    <table class="table" border="1" width="100%">
        <thead>
            <tr>
                <th>No</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($users as $key => $value): ?>
            <tr>
                <td><?php echo $key += 1; ?></td>
                <td><?php echo $value['name']; ?></td>
                <td><?php echo $value['email']; ?></td>
                <td><?php echo $value['role_name']; ?></td>
                <td>
                    <a href="user-restore.php?restore=<?php echo $value['id']?>"onclick="return confirm ('Are you sure you want to restore this data?')">Restore Data</a> |
                    <a onclick="return confirm ('Are you sure you want to delete this data?')"
                        href="user-restore.php?delete=<?php echo $value['id'] ?>">
                        Delete
                    </a>

                </td>
            </tr>
            <?php endforeach?>
        </tbody>
    </table>

</body>

</html>
