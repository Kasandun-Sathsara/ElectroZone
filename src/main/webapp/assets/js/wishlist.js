window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        await loadWishlist();
    } finally {
        Notiflix.Loading.remove();
    }
});

async function addToWishlist(stockId) {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        const response = await fetch(`api/wishlist/add?sId=${stockId}`);
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                Notiflix.Notify.success(data.message, { position: 'center-top' });
            } else if (data.status_code === 401) {
                window.location.href = "login.jsp";
            } else {
                Notiflix.Notify.info(data.message, { position: 'center-top' });
            }
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    } finally {
        Notiflix.Loading.remove();
    }
}

async function loadWishlist() {
    try {
        const response = await fetch("api/wishlist/all");
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                updateWishlistView(data.wishlistItems);
            } else if (data.status_code === 401) {
                window.location.href = "login.jsp";
            }
        }
    } catch (e) {
        console.error("Wishlist loading failed:", e);
    }
}

function updateWishlistView(items) {
    const container = document.getElementById("wishlist-container");
    const countText = document.getElementById("wishlist-count-text");
    if (!container) return;

    container.innerHTML = "";
    if (countText) countText.textContent = `${items.length} items saved for later`;

    if (items.length === 0) {
        container.innerHTML = `<div class="col-12 text-center text-muted p-5"><h5>Your wishlist is empty.</h5><a href="search.jsp" class="btn btn-outline-primary mt-3">Start Shopping</a></div>`;
        return;
    }

    items.forEach(item => {
        let imageSrc = item.images && item.images.length > 0 ? item.images[0] : 'assets/img/default-product.png';
        const formattedPrice = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(item.currentPrice);
        
        let inStockHtml = item.stockId > 0 
            ? `<span class="stock-badge badge-instock bg-success text-white px-2 py-1 rounded fs-8 position-absolute top-0 end-0 m-2">In Stock</span>`
            : `<span class="stock-badge badge-outofstock bg-danger text-white px-2 py-1 rounded fs-8 position-absolute top-0 end-0 m-2">Out of Stock</span>`;
            
        let actionBtnHtml = item.stockId > 0
            ? `<button class="btn btn-primary w-100 shadow-sm rounded-3 py-2 fw-bold d-flex align-items-center justify-content-center gap-2" onclick="addToCart(${item.stockId}, 1)">
                 <i class="bi bi-cart-plus fs-5"></i> Move to Cart
               </button>`
            : `<button class="btn btn-secondary w-100 shadow-sm rounded-3 py-2 fw-bold" disabled>
                 Out of Stock
               </button>`;

        container.innerHTML += `
            <div class="col">
                <div class="wishlist-card card border-0 shadow-sm rounded-4 h-100 position-relative overflow-hidden">
                    <div class="wishlist-img-wrapper p-4 bg-light d-flex align-items-center justify-content-center position-relative" style="height: 200px;">
                        <img src="${imageSrc}" alt="${item.productTitle}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                        <button class="btn btn-light rounded-circle shadow-sm position-absolute top-0 start-0 m-2 text-danger" style="width:35px;height:35px;padding:0;" onclick="removeFromWishlist(${item.id})" aria-label="Remove item">
                            <i class="bi bi-trash-fill"></i>
                        </button>
                        ${inStockHtml}
                    </div>
                    <div class="card-body d-flex flex-column p-4">
                        <h3 class="card-title fs-6 fw-bold mb-3" style="height: 2.5rem; overflow: hidden;">${item.productTitle}</h3>
                        <div class="mt-auto">
                            <div class="d-flex align-items-end mb-3">
                                <span class="fw-bolder text-dark fs-5">LKR ${formattedPrice}</span>
                            </div>
                            ${actionBtnHtml}
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}

async function removeFromWishlist(id) {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        const response = await fetch(`api/wishlist/remove/${id}`, { method: "DELETE" });
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                Notiflix.Notify.success(data.message, { position: 'center-top' });
                await loadWishlist();
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    } finally {
        Notiflix.Loading.remove();
    }
}

async function clearWishlist() {
    Notiflix.Confirm.show(
        'Clear Wishlist',
        'Are you sure you want to clear your wishlist?',
        'Yes',
        'No',
        async function okCb() {
            try {
                Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
                const response = await fetch(`api/wishlist/clear`, { method: "DELETE" });
                if (response.ok) {
                    const data = await response.json();
                    if (data.status) {
                        Notiflix.Notify.success(data.message, { position: 'center-top' });
                        await loadWishlist();
                    } else {
                        Notiflix.Notify.failure(data.message, { position: 'center-top' });
                    }
                }
            } catch (e) {
                Notiflix.Notify.failure(e.message, { position: 'center-top' });
            } finally {
                Notiflix.Loading.remove();
            }
        }
    );
}
