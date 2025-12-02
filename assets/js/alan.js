document.getElementById("product-title").innerHTML = "Data Product";

let currentCategory = "all";
let cart = [];

function filterCategory(category, event){
    currentCategory = category;

    let buttons = document.querySelectorAll('.category-btn');
    buttons.forEach((btn) => {
        btn.classList.remove("active", "btn-primary");
        btn.classList.add("btn-outline-primary");
    });

    event.classList.add("active", "btn-primary");
    event.classList.remove("btn-outline-primary");

    renderProducts();
}

function renderProducts(searchProduct = ""){
    const productGrid = document.getElementById("productGrid");
    productGrid.innerHTML = "";

    const filtered = products.filter((p) => {
        const matchCategory = currentCategory === "all" || p.category_name === currentCategory;
        const matchSearch = p.product_name.toLowerCase().includes(searchProduct);
        return matchCategory && matchSearch;
    });

    filtered.forEach((product) => {
        const col = document.createElement("div");
        col.className = "col-md-4 col-sm-6";
        col.innerHTML = `
        <div class="card product-card" onclick="addToCart(${product.id})">
            <div class="product-img">
                <img src="../${product.product_photo}" alt="" width="100%">
            </div>
            <div class="card-body">
                <span class="badge bg-secondary badge-category">${product.category_name}</span>
                <h6 class="card-title mt-2 mb-2">${product.product_name}</h6>
                <p class="card-text text-primary fw-bold">Rp. ${Number(product.product_price).toLocaleString()}</p>
            </div>
        </div>`;
        productGrid.appendChild(col);
    });
}

function addToCart(id){
    const productData = products.find((p) => p.id == id);
    if (!productData) return;

    const existing = cart.find((item) => item.id == id);
    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({ ...productData, quantity: 1 });
    }

    renderCart();
}

function renderCart(){
    const cartContainer = document.querySelector("#cartItems");
    cartContainer.innerHTML = "";

    if (cart.length === 0) {
        cartContainer.innerHTML = `
            <div class="text-center text-muted mt-5">
                <i class="bi bi-cart mb-3"></i>
                <p>Cart Empty</p>
            </div>`;
        updateCartTotals();
        return;
    }

    cart.forEach((item, index) => {
        const div = document.createElement("div");
        div.className = "cart-item d-flex justify-content-between align-items-center mb-2";
        div.innerHTML = `
            <div>
                <strong>${item.product_name}</strong><br>
                <small>Qty: ${item.quantity}</small>
            </div>
            <div>
                <span>Rp. ${(item.product_price * item.quantity).toLocaleString()}</span>
                <button class="btn btn-sm btn-secondary ms-1 decreaseBtn" data-index="${index}">
                    <i class="bi bi-dash"></i>
                </button>
                <button class="btn btn-sm btn-success ms-1 increaseBtn" data-index="${index}">
                    <i class="bi bi-plus"></i>
                </button>
            </div>`;
        cartContainer.appendChild(div);
    });

    // tombol kurangi quantity
    document.querySelectorAll(".decreaseBtn").forEach(btn => {
        btn.addEventListener("click", function(){
            const idx = this.dataset.index;
            if (cart[idx].quantity > 1){
                cart[idx].quantity -= 1;
            } else {
                cart.splice(idx, 1);
            }
            renderCart();
        });
    });

    // tombol tambah quantity
    document.querySelectorAll(".increaseBtn").forEach(btn => {
        btn.addEventListener("click", function(){
            const idx = this.dataset.index;
            cart[idx].quantity += 1;
            renderCart();
        });
    });

    updateCartTotals();
}

function updateCartTotals(){
    let subtotal = 0;
    cart.forEach(item => subtotal += item.product_price * item.quantity);
    let tax = subtotal * 0.1; // tax 10%
    let total = subtotal + tax;

    document.getElementById("subtotal").textContent = "Rp. " + subtotal.toLocaleString();//pake textcontent karna menggunakan span
    document.getElementById("tax").textContent = "Rp. " + tax.toLocaleString();
    document.getElementById("total").textContent = "Rp. " + total.toLocaleString();
    document.getElementById("subtotal_value").value = subtotal;
    document.getElementById("tax_value").value = tax;
    document.getElementById("total_value").value = total;
}

async function proccessPayment() {
    if (cart.length === 0){
        alert("cart still empty");
        return;
    }
    const order_code = document.querySelector(".orderNumber").textContent.trim();
    const subtotal = document.querySelector("#subtotal_value"). value.trim();
    const tax = document.querySelector("#tax_value"). value.trim();
    const grandTotal = document.querySelector("#total_value"). value.trim();
    try {
        const res = await fetch("add-pos.php?payment", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ cart, order_code, subtotal, tax, grandTotal }),
        });
        const data = await res.json();
        
        if (data.status == "success"){
            alert("Transaction Successfully");
            window.location.href = "print.php";
        }else{
            alert("Transaction failed", data.message);
        }
        
    } catch (error) {
        alert("transaction fail")
        console.error(error);
    }
}


// Event listener search product
document.getElementById('searchProduct').addEventListener('input', function(e) {
    const searchProduct = e.target.value.toLowerCase();
    renderProducts(searchProduct);
});

// Event listener clear cart
document.getElementById("clearCartBtn").addEventListener("click", () => {
    cart = [];
    renderCart();
});

renderProducts();
renderCart();
