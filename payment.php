<?php
include '../config/koneksi.php';

$data = json_decode(file_get_contents('php://input'), true);
$cart = $data['cart'];
$subtotal = $data['subtotal'];
$tax = $data['tax'];
$total = $data['total'];

// Insert ke tabel orders
mysqli_query($koneksi, "INSERT INTO orders (subtotal, tax, total, created_at) VALUES ('$subtotal','$tax','$total', NOW())");
$order_id = mysqli_insert_id($koneksi);

// Insert tiap item ke order_items
foreach($cart as $item){
    $pid = $item['id'];
    $qty = $item['quantity'];
    $price = $item['product_price'];
    mysqli_query($koneksi, "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES ('$order_id','$pid','$qty','$price')");
}

echo json_encode(['status'=>'success','order_id'=>$order_id]);
?>
