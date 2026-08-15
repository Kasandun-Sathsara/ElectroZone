let allProductsList = [];

window.addEventListener("load", async () => {
    loadProducts();

    try {
        const catRes = await fetch("../api/data/categories");
        if(catRes.ok) {
            const data = await catRes.json();
            const filterSelect = document.getElementById("categoryFilter");
            data.categories.forEach(c => {
                const option = document.createElement("option");
                option.value = c.id;
                option.innerHTML = c.name;
                filterSelect.appendChild(option);
            });
        }
    } catch(e) {
        console.error(e);
    }

    document.getElementById("searchInput").addEventListener("input", applyFilters);
    document.getElementById("categoryFilter").addEventListener("change", applyFilters);
    document.getElementById("sortFilter").addEventListener("change", applyFilters);
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
                allProductsList = data.products || [];
                applyFilters();
            } else {
                Notiflix.Notify.failure(data.message);
            }
        })
        .catch(err => {
            Notiflix.Loading.remove();
            console.error(err);
        });
}

function applyFilters() {
    const searchText = document.getElementById("searchInput").value.toLowerCase();
    const categoryVal = document.getElementById("categoryFilter").value;
    const sortVal = document.getElementById("sortFilter").value;

    let filtered = allProductsList.filter(p => {
        const matchesSearch = p.title.toLowerCase().includes(searchText) || 
                              p.brandName.toLowerCase().includes(searchText) || 
                              ("prod-"+p.productId).includes(searchText);
        const matchesCategory = (categoryVal === "all") || (p.categoryId.toString() === categoryVal);
        return matchesSearch && matchesCategory;
    });

    if(sortVal === "price_asc") {
        filtered.sort((a, b) => a.price - b.price);
    } else if(sortVal === "price_desc") {
        filtered.sort((a, b) => b.price - a.price);
    } else if(sortVal === "stock_low") {
        filtered.sort((a, b) => a.qty - b.qty);
    } else if(sortVal === "stock_high") {
        filtered.sort((a, b) => b.qty - a.qty);
    } else {

        filtered.sort((a, b) => b.productId - a.productId);
    }

    populateProductsTable(filtered);
}

function populateProductsTable(products) {
    const tbody = document.getElementById("admin-products-tbody");
    tbody.innerHTML = "";
    
    if(!products || products.length === 0) {
        tbody.innerHTML = "<tr><td colspan='7' class='text-center'>No products found</td></tr>";
        return;
    }
    
    products.forEach(p => {
        let rawImg = (p.images && p.images.length > 0) ? p.images[0] : "";
        let img = "https://placehold.co/100x100?text=No+Image";
        
        if (rawImg && typeof rawImg === 'string' && rawImg.trim() !== '') {
            rawImg = rawImg.trim();
            if (rawImg.startsWith("http://") || rawImg.startsWith("https://")) {
                img = rawImg;
            } else {
                if (rawImg.startsWith("/")) rawImg = rawImg.substring(1);
                img = "../" + rawImg;
            }
        }

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
                        <div class="admin-product-img-wrapper" style="background-color: #f1f5f9;">
                            <img src="${img}" alt="${p.title}" onerror="this.onerror=null; this.src='https://placehold.co/100x100?text=No+Image';">
                        </div>
                        <div class="product-info">
                            <p class="product-name text-truncate" style="max-width: 200px;" title="${p.title}">${p.title}</p>
                            <p class="product-sku">SKU: PROD-${p.productId}</p>
                        </div>
                    </div>
                </td>
                <td>
                    <p class="mb-0 text-dark fw-medium">${p.categoryName || '-'}</p>
                    <p class="mb-0 text-muted" style="font-size: 0.8rem;">${p.brandName || '-'} | ${p.modelName || '-'}</p>
                    <p class="mb-0 text-muted" style="font-size: 0.75rem;">${p.storageValue || '-'}, ${p.colorValue || '-'}</p>
                </td>
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
    const p = allProductsList.find(x => x.productId === id);
    if (!p) return;

    if (!document.getElementById('editProductBrand').hasChildNodes() || document.getElementById('editProductBrand').options.length <= 1) {
        loadOptionsForProductModal().then(async () => {
            await populateEditModal(p);
        });
    } else {
        populateEditModal(p);
    }
}

async function populateEditModal(p) {
    document.getElementById("editProductId").value = p.productId;
    document.getElementById("editProductTitle").value = p.title;
    document.getElementById("editProductDescription").value = p.description;
    document.getElementById("editProductCategory").value = p.categoryId;
    document.getElementById("editProductBrand").value = p.brandId;
    
    await loadModelsForBrandEdit();
    
    document.getElementById("editProductModel").value = p.modelId;
    document.getElementById("editProductStorage").value = p.storageId;
    document.getElementById("editProductColor").value = p.colorId;
    document.getElementById("editProductPrice").value = p.price;
    document.getElementById("editProductQty").value = p.qty;

    var editModal = new bootstrap.Modal(document.getElementById('editProductModal'));
    editModal.show();
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
                        allProductsList = allProductsList.filter(p => p.productId !== id && p.productId != id);
                        applyFilters();
                        loadProducts(); 
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

document.addEventListener('DOMContentLoaded', () => {
    const addProductModal = document.getElementById('addProductModal');
    if(addProductModal) {
        addProductModal.addEventListener('show.bs.modal', function (event) {
            if(!document.getElementById('productBrand').hasChildNodes() || document.getElementById('productBrand').options.length <= 1) {
                loadOptionsForProductModal();
            }
        });
    }
});

async function loadOptionsForProductModal() {
    try {
        const catRes = await fetch("../api/data/categories");
        if(catRes.ok) {
            const data = await catRes.json();
            renderDropdowns(document.getElementById("productCategory"), data.categories, 'name');
            renderDropdowns(document.getElementById("editProductCategory"), data.categories, 'name');
        }

        const brandRes = await fetch("../api/data/brands");
        if(brandRes.ok) {
            const data = await brandRes.json();
            renderDropdowns(document.getElementById("productBrand"), data.brands, 'name');
            renderDropdowns(document.getElementById("editProductBrand"), data.brands, 'name');
        }

        const specRes = await fetch("../api/data/specifications");
        if(specRes.ok) {
            const data = await specRes.json();
            renderDropdowns(document.getElementById("productStorage"), data.storages, 'value');
            renderDropdowns(document.getElementById("editProductStorage"), data.storages, 'value');
            renderDropdowns(document.getElementById("productColor"), data.colors, 'value');
            renderDropdowns(document.getElementById("editProductColor"), data.colors, 'value');
        }
    } catch(e) {
        console.error(e);
    }
}

function renderDropdowns(selector, list, suffix) {
    selector.innerHTML = `<option value="" disabled selected>Select</option>`;
    list.forEach((item) => {
        const option = document.createElement("option");
        option.value = item.id;
        option.innerHTML = item[suffix];
        selector.appendChild(option);
    });
}

async function loadModelsForBrand() {
    const brandId = document.getElementById("productBrand").value;
    const modelSelect = document.getElementById("productModel");
    modelSelect.innerHTML = '<option value="0" disabled selected>Select Model</option>';
    if(brandId == 0) return;

    try {
        const res = await fetch(`../api/data/${brandId}/models`);
        if(res.ok) {
            const data = await res.json();
            if (data.status && data.models) {
                renderDropdowns(modelSelect, data.models, 'name');
            }
        }
    } catch(e) {
        console.error(e);
    }
}

async function loadModelsForBrandEdit() {
    const brandId = document.getElementById("editProductBrand").value;
    const modelSelect = document.getElementById("editProductModel");
    modelSelect.innerHTML = '<option value="0" disabled selected>Select Model</option>';
    if(brandId == 0) return;

    try {
        const res = await fetch(`../api/data/${brandId}/models`);
        if(res.ok) {
            const data = await res.json();
            if (data.status && data.models) {
                renderDropdowns(modelSelect, data.models, 'name');
            }
        }
    } catch(e) {
        console.error(e);
    }
}

async function addAdminProduct() {
    const form = document.getElementById("addProductForm");
    if(!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    const title = document.getElementById("productTitle").value;
    const categoryId = document.getElementById("productCategory").value;
    const brandId = document.getElementById("productBrand").value;
    const modelId = document.getElementById("productModel").value;
    const storageId = document.getElementById("productStorage").value;
    const colorId = document.getElementById("productColor").value;
    const price = document.getElementById("productPrice").value;
    const qty = document.getElementById("productQty").value;
    const description = document.getElementById("productDescription").value;
    const imagesInput = document.getElementById("productImages");

    if (imagesInput.files.length > 4) {
        Notiflix.Notify.failure("You can only upload up to 4 images.");
        return;
    }

    const productDataObj = {
        title: title,
        categoryId: parseInt(categoryId),
        brandId: parseInt(brandId),
        modelId: parseInt(modelId),
        storageId: parseInt(storageId),
        colorId: parseInt(colorId),
        qualityId: 0,
        price: parseFloat(price),
        qty: parseInt(qty),
        description: description
    };

    const formData = new FormData();
    formData.append("product", JSON.stringify(productDataObj));
    for (let i = 0; i < imagesInput.files.length; i++) {
        formData.append("images[]", imagesInput.files[i]);
    }

    Notiflix.Loading.pulse("Saving product...");

    try {
        const response = await fetch("../api/admin/products/save-product", {
            method: "POST",
            body: formData
        });
        const data = await response.json();
        Notiflix.Loading.remove();
        if(data.status) {
            Notiflix.Notify.success(data.message);
            var modal = bootstrap.Modal.getInstance(document.getElementById('addProductModal'));
            modal.hide();
            form.reset();
            loadProducts(); 
        } else {
            Notiflix.Notify.failure(data.message);
        }
    } catch(e) {
        Notiflix.Loading.remove();
        Notiflix.Notify.failure("An error occurred");
        console.error(e);
    }
}

async function updateAdminProduct() {
    const form = document.getElementById("editProductForm");
    if(!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    const productId = document.getElementById("editProductId").value;
    const title = document.getElementById("editProductTitle").value;
    const categoryId = document.getElementById("editProductCategory").value;
    const brandId = document.getElementById("editProductBrand").value;
    const modelId = document.getElementById("editProductModel").value;
    const storageId = document.getElementById("editProductStorage").value;
    const colorId = document.getElementById("editProductColor").value;
    const price = document.getElementById("editProductPrice").value;
    const qty = document.getElementById("editProductQty").value;
    const description = document.getElementById("editProductDescription").value;
    const imagesInput = document.getElementById("editProductImages");

    if (imagesInput.files.length > 4) {
        Notiflix.Notify.failure("You can only upload up to 4 new images.");
        return;
    }

    const productDataObj = {
        productId: parseInt(productId),
        title: title,
        categoryId: parseInt(categoryId),
        brandId: parseInt(brandId),
        modelId: parseInt(modelId),
        storageId: parseInt(storageId),
        colorId: parseInt(colorId),
        qualityId: 0,
        price: parseFloat(price),
        qty: parseInt(qty),
        description: description
    };

    const formData = new FormData();
    formData.append("product", JSON.stringify(productDataObj));
    for (let i = 0; i < imagesInput.files.length; i++) {
        formData.append("images[]", imagesInput.files[i]);
    }

    Notiflix.Loading.pulse("Updating product...");

    try {
        const response = await fetch("../api/admin/products/update-product", {
            method: "POST",
            body: formData
        });
        const data = await response.json();
        Notiflix.Loading.remove();
        if(data.status) {
            Notiflix.Notify.success(data.message);
            var modal = bootstrap.Modal.getInstance(document.getElementById('editProductModal'));
            modal.hide();
            form.reset();
            loadProducts(); 
        } else {
            Notiflix.Notify.failure(data.message);
        }
    } catch(e) {
        Notiflix.Loading.remove();
        Notiflix.Notify.failure("An error occurred");
        console.error(e);
    }
}

function addNewBrand() {
    Notiflix.Confirm.prompt(
        'Add New Brand',
        'Enter brand name:',
        '',
        'Save',
        'Cancel',
        async function okCb(clientAnswer) {
            if(!clientAnswer || clientAnswer.trim() === '') return;
            try {
                Notiflix.Loading.pulse('Saving...');
                const formData = new FormData();
                formData.append("name", clientAnswer.trim());
                
                const res = await fetch("../api/admin/products/add-brand", {
                    method: "POST",
                    body: formData
                });
                const data = await res.json();
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    await loadOptionsForProductModal();
                    if(data.id) {
                        document.getElementById("productBrand").value = data.id;
                        await loadModelsForBrand(); 
                    }
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            } catch(e) {
                Notiflix.Loading.remove();
                console.error(e);
            }
        },
        function cancelCb(clientAnswer) {}
    );
}

function addNewModel() {
    const brandId = document.getElementById("productBrand").value;
    if(!brandId || brandId == "0") {
        Notiflix.Notify.warning("Please select a Brand first to add a model.");
        return;
    }
    Notiflix.Confirm.prompt(
        'Add New Model',
        'Enter model name:',
        '',
        'Save',
        'Cancel',
        async function okCb(clientAnswer) {
            if(!clientAnswer || clientAnswer.trim() === '') return;
            try {
                Notiflix.Loading.pulse('Saving...');
                const formData = new FormData();
                formData.append("name", clientAnswer.trim());
                formData.append("brandId", brandId);
                
                const res = await fetch("../api/admin/products/add-model", {
                    method: "POST",
                    body: formData
                });
                const data = await res.json();
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    await loadModelsForBrand();
                    if(data.id) document.getElementById("productModel").value = data.id;
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            } catch(e) {
                Notiflix.Loading.remove();
                console.error(e);
            }
        },
        function cancelCb(clientAnswer) {}
    );
}

function addNewStorage() {
    Notiflix.Confirm.prompt(
        'Add New Storage',
        'Enter storage value (e.g. 128GB):',
        '',
        'Save',
        'Cancel',
        async function okCb(clientAnswer) {
            if(!clientAnswer || clientAnswer.trim() === '') return;
            try {
                Notiflix.Loading.pulse('Saving...');
                const formData = new FormData();
                formData.append("value", clientAnswer.trim());
                
                const res = await fetch("../api/admin/products/add-storage", {
                    method: "POST",
                    body: formData
                });
                const data = await res.json();
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    await loadOptionsForProductModal();
                    if(data.id) document.getElementById("productStorage").value = data.id;
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            } catch(e) {
                Notiflix.Loading.remove();
                console.error(e);
            }
        },
        function cancelCb(clientAnswer) {}
    );
}

function addNewColor() {
    Notiflix.Confirm.prompt(
        'Add New Color',
        'Enter color name:',
        '',
        'Save',
        'Cancel',
        async function okCb(clientAnswer) {
            if(!clientAnswer || clientAnswer.trim() === '') return;
            try {
                Notiflix.Loading.pulse('Saving...');
                const formData = new FormData();
                formData.append("value", clientAnswer.trim());
                
                const res = await fetch("../api/admin/products/add-color", {
                    method: "POST",
                    body: formData
                });
                const data = await res.json();
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    await loadOptionsForProductModal();
                    if(data.id) document.getElementById("productColor").value = data.id;
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            } catch(e) {
                Notiflix.Loading.remove();
                console.error(e);
            }
        },
        function cancelCb(clientAnswer) {}
    );
}

function addNewCategory() {
    Notiflix.Confirm.prompt(
        'Add New Category',
        'Enter category name:',
        '',
        'Save',
        'Cancel',
        async function okCb(clientAnswer) {
            if(!clientAnswer || clientAnswer.trim() === '') return;
            try {
                Notiflix.Loading.pulse('Saving...');
                const formData = new FormData();
                formData.append("name", clientAnswer.trim());
                
                const res = await fetch("../api/admin/products/add-category", {
                    method: "POST",
                    body: formData
                });
                const data = await res.json();
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    await loadOptionsForProductModal();
                    if(data.id) document.getElementById("productCategory").value = data.id;
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            } catch(e) {
                Notiflix.Loading.remove();
                console.error(e);
            }
        },
        function cancelCb(clientAnswer) {}
    );
}
