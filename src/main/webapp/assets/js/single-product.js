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
                product.images.forEach((image, index) => {
                    let mainImg = document.getElementById(`image${index + 1}`);
                    let thumbImg = document.getElementById(`thumb-image${index + 1}`);
                    if (mainImg && thumbImg) {
                        mainImg.src = image;
                        thumbImg.src = image;
                    }
                });
                document.getElementById("product-title").innerHTML = product.title;
                document.getElementById("published-on").innerHTML = product.createdAt;
                document.getElementById("product-price").innerHTML = new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2
                }).format(product.price);
                document.getElementById("brand-name").innerHTML = product.brandName;
                document.getElementById("model-name").innerHTML = product.modelName;
                document.getElementById("product-quality").innerHTML = product.qualityValue;
                document.getElementById("product-stock").innerHTML = product.qty;

                // color variation
                document.getElementById("color-border").style.borderColor = "black";
                document.getElementById("color-background").style.backgroundColor = product.colorValue;

                // product storage
                document.getElementById("product-storage").innerHTML = product.storageValue;
                // description
                document.getElementById("product-description").innerHTML = product.description;

                const addToCartBtn = document.getElementById("add-to-cart-main"); // anchor tag -> prevent href
                addToCartBtn.addEventListener("click", async (evt) => {
                    const qtyInput = document.getElementById("add-to-cart-qty");
                    await addToCart(product.stockId, qtyInput.value);
                    evt.preventDefault();
                });
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Single Product data loading failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    }
}

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
                            <img src="${product.images[0]}" alt="${product.title}" class="img-fluid" style="mix-blend-mode: multiply;">
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
