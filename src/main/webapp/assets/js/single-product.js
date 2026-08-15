const parms = new URLSearchParams(window.location.search);
const productId = parms.get("productId");

window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });

        await loadSingleProduct();
        await loadSimilarProducts();
    } finally {
        Notiflix.Loading.remove();
    }

});

async function loadSingleProduct() {
    try {
        const response = await fetch(`api/single-products/product?productId=${productId}`);
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                const product = data.singleProduct;
                
                const mainImageContainer = document.querySelector('.product-gallery-main');
                const thumbContainer = document.querySelector('.d-flex.gap-3.justify-content-center');
                
                if (mainImageContainer && thumbContainer && product.images && product.images.length > 0) {
                    mainImageContainer.innerHTML = `<span class="badge bg-primary position-absolute top-0 start-0 m-3 fs-8 px-2 py-1">NEW</span>
                                                    <img src="${product.images[0]}" alt="${product.title}" id="mainImage" class="img-fluid" style="max-height:400px; object-fit:contain;">`;
                    
                    thumbContainer.innerHTML = "";
                    product.images.forEach((img, idx) => {
                        thumbContainer.innerHTML += `
                            <div class="gallery-thumbnail ${idx === 0 ? 'active' : ''}" onclick="changeMainImage(this, '${img}')" style="cursor:pointer; width:80px; height:80px; border-radius:8px; overflow:hidden; border:2px solid transparent;">
                                <img src="${img}" alt="Thumbnail ${idx+1}" style="width:100%; height:100%; object-fit:contain;">
                            </div>
                        `;
                    });
                }
                
                const setText = (id, text) => { if(document.getElementById(id)) document.getElementById(id).innerHTML = text; };
                
                setText("product-title", product.title);
                setText("published-on", product.createdAt);
                setText("product-price", new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(product.price));
                setText("brand-name", product.brandName);
                setText("model-name", product.modelName);
                setText("product-quality", product.qualityValue);
                setText("product-storage", product.storageValue);
                setText("product-description", product.description);

                const colorBorder = document.getElementById("color-border");
                const colorBg = document.getElementById("color-background");
                if (colorBorder && colorBg) {
                    colorBorder.style.borderColor = "black";
                    colorBg.style.backgroundColor = product.colorValue;
                }

                const stockWrapper = document.getElementById("stock-status-wrapper");
                const addToCartBtn = document.getElementById("add-to-cart-main");
                const buyNowBtn = document.getElementById("buy-now-btn");
                const qtyContainer = document.getElementById("qty-selector-container");
                const wishlistBtn = document.getElementById("single-wishlist-btn");
                const wishlistText = document.getElementById("wishlist-btn-text");

                if (wishlistBtn) {
                    wishlistBtn.onclick = () => addToWishlist(product.stockId);
                }

                if (product.qty <= 0) {

                    if (stockWrapper) {
                        stockWrapper.className = "text-danger fw-bold fs-7";
                        stockWrapper.innerHTML = `<span class="badge bg-danger px-3 py-2 fs-7 fw-bold"><i class="bi bi-x-circle-fill me-1"></i> Out of Stock</span>`;
                    }
                    if (qtyContainer) {
                        qtyContainer.style.display = "none";
                    }
                    if (addToCartBtn) {
                        addToCartBtn.disabled = true;
                        addToCartBtn.classList.add("disabled", "btn-secondary");
                        addToCartBtn.classList.remove("btn-primary");
                        addToCartBtn.style.pointerEvents = "none";
                        addToCartBtn.style.cursor = "not-allowed";
                        addToCartBtn.innerHTML = `<i class="bi bi-slash-circle fs-5"></i> Out of Stock`;
                    }
                    if (buyNowBtn) {
                        buyNowBtn.style.display = "none";
                    }
                    if (wishlistBtn) {
                        wishlistBtn.className = "btn btn-danger btn-lg flex-grow-1 shadow-sm d-flex align-items-center justify-content-center gap-2";
                        if (wishlistText) {
                            wishlistText.classList.remove("d-none");
                        }
                    }
                } else {

                    if (stockWrapper) {
                        stockWrapper.className = "text-success fw-bold fs-7";
                        stockWrapper.innerHTML = `<i class="bi bi-check-circle-fill me-1"></i> In Stock (${product.qty})`;
                    }
                    if (qtyContainer) {
                        qtyContainer.style.display = "flex";
                    }
                    if (addToCartBtn) {
                        addToCartBtn.disabled = false;
                        addToCartBtn.classList.remove("disabled", "btn-secondary");
                        addToCartBtn.classList.add("btn-primary");
                        addToCartBtn.style.pointerEvents = "auto";
                        addToCartBtn.style.cursor = "pointer";
                        addToCartBtn.innerHTML = `<i class="bi bi-cart-plus fs-5"></i> <span id="add-to-cart-text">Add to Cart</span>`;
                        addToCartBtn.onclick = async (evt) => {
                            evt.preventDefault();
                            const qtyInput = document.getElementById("add-to-cart-qty");
                            await addToCart(product.stockId, qtyInput ? parseInt(qtyInput.value) || 1 : 1);
                        };
                    }
                    if (buyNowBtn) {
                        buyNowBtn.style.display = "block";
                        buyNowBtn.onclick = async () => {
                            const qtyInput = document.getElementById("add-to-cart-qty");
                            await addToCart(product.stockId, qtyInput ? parseInt(qtyInput.value) || 1 : 1);
                            window.location.href = "cart.jsp";
                        };
                    }
                }
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        } else {
            Notiflix.Notify.failure("Single Product data loading failed!", { position: 'center-top' });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    }
}

window.increaseQty = function() {
    const qtyInput = document.getElementById("add-to-cart-qty");
    if(qtyInput) {
        let val = parseInt(qtyInput.value) || 1;
        qtyInput.value = val + 1;
    }
};

window.decreaseQty = function() {
    const qtyInput = document.getElementById("add-to-cart-qty");
    if(qtyInput) {
        let val = parseInt(qtyInput.value) || 1;
        if(val > 1) qtyInput.value = val - 1;
    }
};

window.changeMainImage = function(element, src) {
    document.querySelectorAll('.gallery-thumbnail').forEach(el => el.classList.remove('active'));
    element.classList.add('active');
    const mainImg = document.getElementById('mainImage');
    if (mainImg) mainImg.src = src;
};

async function loadSimilarProducts() {
    try {
        const response = await fetch(`api/single-products/similar-products?productId=${productId}`);
        if (response.ok) {
            const data = await response.json();
            console.log(data);
            if (data.status) {
                renderingSimilarProducts(data.similarProducts);
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Product data loading failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure("Product data loading failed!", {
            position: 'center-top'
        });

    }
}

function renderingSimilarProducts(productList) {
    const similarProductMain = document.getElementById("similar-product-main");
    if(!similarProductMain) return;
    similarProductMain.innerHTML = "";
    productList.forEach((product) => {
        similarProductMain.innerHTML += `
                <div class="col-sm-6 col-lg-3 mb-4">
                    <div class="product-card h-100 bg-white shadow-sm border-0">
                        <div class="product-img-wrapper bg-light" style="cursor:pointer;" onclick="window.location='single-product.jsp?productId=${product.stockId}'">
                            <img src="${product.images[0]}" alt="${product.title}" class="img-fluid" style="max-height: 100%; object-fit: contain;">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <span class="text-muted fs-8 fw-medium mb-1">${product.brandName}</span>
                            <h5 class="fs-6 fw-bold mb-3 text-dark" style="cursor:pointer;" onclick="window.location='single-product.jsp?productId=${product.stockId}'">${product.title}</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(product.price)}</div>
                                </div>
                                <button class="btn btn-link p-0 text-primary" onclick="addToCart(${product.stockId},1)"><i class="bi bi-cart-plus fs-4"></i></button>
                            </div>
                        </div>
                    </div>
                </div>`;
    });
}
