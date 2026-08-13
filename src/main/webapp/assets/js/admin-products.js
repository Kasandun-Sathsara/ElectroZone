window.addEventListener("load", () => {
    loadProducts();
});

function loadProducts() {
    Notiflix.Loading.pulse("Loading Products...");
    fetch("../api/admin/products/all")
        .then(response => {
            if(response.status === 401 || response.status === 403) {
                window.location.href = "../index.jsp";
                throw new Error("Unauthorized");
            }
            return response.json();
        })
        .then(data => {
            Notiflix.Loading.remove();
            if (data.status) {
                populateProductsTable(data.products);
            } else {
                Notiflix.Notify.failure(data.message);
            }
        })
        .catch(err => {
            Notiflix.Loading.remove();
            console.error(err);
        });
}

function populateProductsTable(products) {
    const tbody = document.getElementById("admin-products-tbody");
    tbody.innerHTML = "";
    
    if(!products || products.length === 0) {
        tbody.innerHTML = "<tr><td colspan='7' class='text-center'>No products found</td></tr>";
        return;
    }
    
    products.forEach(p => {
        let img = (p.images && p.images.length > 0) ? "../" + p.images[0] : "https://placehold.co/100x100/e2e8f0/475569?text=Product";
        let stockClass = p.qty > 10 ? "normal" : (p.qty > 0 ? "low" : "out");
        let stockText = p.qty > 10 ? p.qty + " in stock" : (p.qty > 0 ? "Low Stock ("+p.qty+")" : "Out of Stock");
        let price = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(p.price);
        
        let statusPillClass = p.qty > 0 ? "pill-active" : "pill-inactive";
        let statusText = p.qty > 0 ? "Active" : "Inactive";
        
        tbody.innerHTML += `
            <tr>
                <td class="checkbox-cell">
                    <input class="form-check-input" type="checkbox" value="${p.productId}">
                </td>
                <td>
                    <div class="product-cell">
                        <div class="product-img-wrapper" style="background-color: #f1f5f9;">
                            <img src="${img}" alt="Product" style="object-fit: contain; width: 100%; height: 100%;">
                        </div>
                        <div class="product-info">
                            <p class="product-name text-truncate" style="max-width: 200px;" title="${p.title}">${p.title}</p>
                            <p class="product-sku">SKU: PROD-${p.productId}</p>
                        </div>
                    </div>
                </td>
                <td>${p.brandName} - ${p.modelName}</td>
                <td class="fw-bold text-dark">${price}</td>
                <td>
                    <div class="stock-wrapper">
                        <p class="stock-text ${stockClass}">${stockText}</p>
                        <div class="stock-bar-container">
                            <div class="stock-bar ${stockClass}" style="width: ${Math.min(100, p.qty * 5)}%;"></div>
                        </div>
                    </div>
                </td>
                <td><span class="status-pill ${statusPillClass}">${statusText}</span></td>
                <td>
                    <div class="action-icons">
                        <button class="action-icon-btn" onclick="editProduct(${p.productId})"><i class="bi bi-pencil-fill"></i></button>
                        <button class="action-icon-btn delete" onclick="deleteProduct(${p.productId})"><i class="bi bi-trash-fill"></i></button>
                    </div>
                </td>
            </tr>
        `;
    });
}

function editProduct(id) {
    Notiflix.Notify.info("Edit product " + id + " clicked (Feature pending)");
}

function deleteProduct(id) {
    Notiflix.Confirm.show(
        'Delete Product',
        'Are you sure you want to delete this product?',
        'Yes',
        'No',
        function okCb() {
            Notiflix.Loading.pulse("Deleting...");
            fetch("../api/admin/products/" + id, { method: "DELETE" })
                .then(response => {
                    if(response.status === 401 || response.status === 403) {
                        window.location.href = "../index.jsp";
                        throw new Error("Unauthorized");
                    }
                    return response.json();
                })
                .then(data => {
                    Notiflix.Loading.remove();
                    if(data.status) {
                        Notiflix.Notify.success(data.message);
                        loadProducts(); // reload
                    } else {
                        Notiflix.Notify.failure(data.message);
                    }
                })
                .catch(err => {
                    Notiflix.Loading.remove();
                    console.error(err);
                });
        },
        function cancelCb() {
        },
    );
}
