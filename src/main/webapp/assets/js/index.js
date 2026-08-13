window.addEventListener("load", async () => {
    Notiflix.Loading.pulse("Wait...", {
        clickToClose: false,
        svgColor: '#0284c7'
    });
    try {
        await loadDeals();
        // await loadAllBrands(); // if you want to implement dynamic categories later
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadDeals() {
    try {
        const response = await fetch("api/data/deals");
        if (response.ok) {
            const data = await response.json();
            renderingDeals(data.deals);
        } else {
            Notiflix.Notify.failure("Failed to load best sellers!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    }
}

function renderingDeals(productList) {
    const container = document.getElementById("best-sellers-container");
    container.innerHTML = "";
    if(!productList || productList.length === 0) {
        container.innerHTML = `<div class="col-12 text-center text-muted"><p>No products available right now.</p></div>`;
        return;
    }
    productList.forEach((product) => {
        let imageSrc = product.images && product.images.length > 0 ? product.images[0] : 'assets/img/default-product.png';
        container.innerHTML += `
            <div class="col-sm-6 col-lg-3">
                <div class="product-card h-100 bg-white shadow-sm border border-light">
                    <div class="product-img-wrapper" style="position: relative; overflow: hidden; height: 200px; display: flex; align-items: center; justify-content: center; padding: 10px;">
                        <span class="product-badge bg-primary text-white position-absolute top-0 start-0 m-2 px-2 py-1 rounded" style="font-size: 0.75rem; z-index: 10;">DEAL</span>
                        <button class="like-btn position-absolute top-0 end-0 m-2 border-0 bg-transparent" onclick="addToWishlist(${product.stockId})" style="z-index: 10;"><i class="bi bi-heart-fill text-muted"></i></button>
                        <a href="single-product.jsp?productId=${product.stockId}" class="w-100 h-100 d-flex align-items-center justify-content-center">
                            <img src="${imageSrc}" alt="${product.title}" class="img-fluid" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                        </a>
                    </div>
                    <div class="p-3 d-flex flex-column" style="height: calc(100% - 200px);">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                            <span class="fw-bold fs-8">4.5</span>
                        </div>
                        <h5 class="fs-6 fw-bold mb-3 text-dark lh-base" style="height: 48px; overflow: hidden;">
                            <a href="single-product.jsp?productId=${product.stockId}" class="text-dark text-decoration-none">${product.title}</a>
                        </h5>
                        <div class="d-flex justify-content-between align-items-end mt-auto">
                            <div>
                                <div class="fw-bold fs-5 text-dark">LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(product.price)}</div>
                            </div>
                            <button class="btn btn-outline-primary rounded-circle" onclick="addToCart(${product.stockId},1);" style="width: 40px; height: 40px; padding: 0; display: flex; align-items: center; justify-content: center;">
                                <i class="bi bi-cart-plus fs-5"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}
