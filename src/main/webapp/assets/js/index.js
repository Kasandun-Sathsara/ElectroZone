window.addEventListener("load", async () => {
    Notiflix.Loading.pulse("Wait...", {
        clickToClose: false,
        svgColor: '#0284c7'
    });
    try {
        await loadDeals();

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
        let isOutOfStock = (product.qty <= 0);
        let badgeHtml = isOutOfStock 
            ? `<span class="product-badge bg-danger text-white position-absolute top-0 start-0 m-2 px-2 py-1 rounded fw-bold" style="font-size: 0.75rem; z-index: 10;">OUT OF STOCK</span>`
            : `<span class="product-badge bg-primary text-white position-absolute top-0 start-0 m-2 px-2 py-1 rounded" style="font-size: 0.75rem; z-index: 10;">DEAL</span>`;
        
        let cartBtnHtml = isOutOfStock
            ? `<button class="btn btn-outline-secondary rounded-circle disabled" disabled title="Out of Stock" style="width: 40px; height: 40px; padding: 0; display: flex; align-items: center; justify-content: center; opacity: 0.4; cursor: not-allowed;">
                    <i class="bi bi-slash-circle fs-5"></i>
               </button>`
            : `<button class="btn btn-outline-primary rounded-circle" onclick="addToCart(${product.stockId},1);" style="width: 40px; height: 40px; padding: 0; display: flex; align-items: center; justify-content: center;">
                    <i class="bi bi-cart-plus fs-5"></i>
               </button>`;

        container.innerHTML += `
            <div class="col-sm-6 col-lg-3">
                <div class="product-card h-100 bg-white shadow-sm border border-light position-relative">
                    <div class="product-img-wrapper" style="position: relative; overflow: hidden; height: 200px; display: flex; align-items: center; justify-content: center; padding: 10px;">
                        ${badgeHtml}
                        <button class="like-btn position-absolute top-0 end-0 m-2 border-0 bg-transparent" onclick="addToWishlist(${product.stockId})" title="Add to Wishlist" style="z-index: 10;"><i class="bi bi-heart-fill text-danger fs-5"></i></button>
                        <a href="single-product.jsp?productId=${product.stockId}" class="w-100 h-100 d-flex align-items-center justify-content-center">
                            <img src="${imageSrc}" alt="${product.title}" class="img-fluid" style="max-height: 100%; max-width: 100%; object-fit: contain; ${isOutOfStock ? 'opacity: 0.6;' : ''}">
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
                            ${cartBtnHtml}
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}
