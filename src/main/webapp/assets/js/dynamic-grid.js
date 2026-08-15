let globalProductList = [];
let filteredProductList = [];
let currentView = 'grid'; 
let searchQuery = '';
let activeBrands = new Set();
let currentMaxPrice = 0;

window.addEventListener("load", async () => {
    const container = document.getElementById("dynamic-product-container");
    if (!container) return;

    if(typeof Notiflix !== 'undefined') Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });

    const urlParams = new URLSearchParams(window.location.search);
    if(urlParams.has('q')) {
        let qVal = urlParams.get('q');
        searchQuery = qVal.toLowerCase();
        
        let displayTitle = qVal.charAt(0).toUpperCase() + qVal.slice(1);
        let titleEl = document.getElementById("page-title");
        let breadEl = document.getElementById("page-breadcrumb");
        if(titleEl) titleEl.innerText = 'Search Results: "' + displayTitle + '"';
        if(breadEl) breadEl.innerText = displayTitle;
        
        let advSearchBtn = document.getElementById("advanced-search-btn");
        if(advSearchBtn) advSearchBtn.href = "search.jsp?q=" + encodeURIComponent(qVal);
    }

    let apiUrl = "";
    let dataKey = "";

    if (window.location.pathname.includes("deals.jsp")) {
        apiUrl = "api/data/deals";
        dataKey = "deals";
    } else if (window.location.pathname.includes("new-arrivals.jsp")) {
        apiUrl = "api/data/new-arrivals";
        dataKey = "newArrivals";
    } else if (window.location.pathname.includes("products.jsp")) {
        apiUrl = "api/advanced-search/all-data";
        dataKey = "productList";
    }

    try {
        const response = await fetch(apiUrl);
        if (response.ok) {
            const data = await response.json();
            let productList = data[dataKey] || data.productList;
            if (productList) {

                if(searchQuery) {
                    productList = productList.filter(p => p.title.toLowerCase().includes(searchQuery));
                }
                
                globalProductList = productList;
                filteredProductList = [...globalProductList];

                if (document.getElementById("brands-container")) {
                    initSidebarFilters(data.brandList, data.minPrice, data.maxPrice);
                }
                
                renderDynamicProducts();
                updateResultCount();
            } else {
                container.innerHTML = "<p class='text-muted mt-4'>No products found.</p>";
            }
        } else {
            if(typeof Notiflix !== 'undefined') Notiflix.Notify.failure("Failed to load products!", { position: 'center-top' });
        }
    } catch (e) {
        if(typeof Notiflix !== 'undefined') Notiflix.Notify.failure("Error: " + e.message, { position: 'center-top' });
    } finally {
        if(typeof Notiflix !== 'undefined') Notiflix.Loading.remove();
    }
});

function sortProducts(type) {
    const sortBtn = document.getElementById("sort-btn");
    
    if (type === 'price_asc') {
        filteredProductList.sort((a, b) => a.price - b.price);
        if(sortBtn) sortBtn.innerHTML = "Sort by: Price (Low to High)";
    } else if (type === 'price_desc') {
        filteredProductList.sort((a, b) => b.price - a.price);
        if(sortBtn) sortBtn.innerHTML = "Sort by: Price (High to Low)";
    } else {
        if(sortBtn) sortBtn.innerHTML = "Sort by: Featured";
    }
    renderDynamicProducts();
}

function initSidebarFilters(brands, minPrice, maxPrice) {
    const brandsContainer = document.getElementById("brands-container");
    const priceSlider = document.getElementById("price-slider");
    const maxLabel = document.getElementById("price-max-label");
    
    if (brandsContainer && brands) {
        brandsContainer.innerHTML = "";
        brands.forEach(b => {
            brandsContainer.innerHTML += `
                <div class="form-check mb-2 custom-checkbox">
                    <input class="form-check-input brand-checkbox" type="checkbox" id="brand_${b.id}" value="${b.name}" onchange="applyFilters()">
                    <label class="form-check-label fs-7 text-muted" for="brand_${b.id}">${b.name}</label>
                </div>
            `;
        });
    }
    
    if (priceSlider) {
        priceSlider.min = minPrice || 0;
        priceSlider.max = maxPrice || 1000000;
        priceSlider.value = priceSlider.max;
        currentMaxPrice = priceSlider.max;
        maxLabel.innerHTML = "LKR " + new Intl.NumberFormat("en-US").format(priceSlider.max);
    }
}

function applyFilters() {
    const brandCheckboxes = document.querySelectorAll('.brand-checkbox:checked');
    activeBrands.clear();
    brandCheckboxes.forEach(cb => activeBrands.add(cb.value));
    
    const priceSlider = document.getElementById("price-slider");
    if(priceSlider) {
        currentMaxPrice = parseFloat(priceSlider.value);
        document.getElementById("price-max-label").innerHTML = "LKR " + new Intl.NumberFormat("en-US").format(currentMaxPrice);
    }
    
    filteredProductList = globalProductList.filter(p => {
        let matchBrand = true;

        if (activeBrands.size > 0) {
            matchBrand = Array.from(activeBrands).some(b => p.title.toLowerCase().includes(b.toLowerCase()));
        }
        
        let matchPrice = p.price <= currentMaxPrice;
        
        return matchBrand && matchPrice;
    });
    
    updateActiveFiltersUI();
    renderDynamicProducts();
    updateResultCount();
}

function updateActiveFiltersUI() {
    const container = document.getElementById("active-filters-container");
    if(!container) return;
    container.innerHTML = "";
    
    activeBrands.forEach(b => {
        container.innerHTML += `
            <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1">
                ${b}
            </span>
        `;
    });
    
    if(currentMaxPrice > 0) {
        container.innerHTML += `
            <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1">
                Up to LKR ${new Intl.NumberFormat("en-US").format(currentMaxPrice)}
            </span>
        `;
    }
    
    if(activeBrands.size > 0 || currentMaxPrice < document.getElementById("price-slider").max) {
        container.innerHTML += `<a href="javascript:void(0)" onclick="clearFilters()" class="text-muted fs-7 ms-2 text-decoration-none hover-dark">Clear All</a>`;
    }
}

function clearFilters() {
    document.querySelectorAll('.brand-checkbox').forEach(cb => cb.checked = false);
    const slider = document.getElementById("price-slider");
    if(slider) {
        slider.value = slider.max;
        document.getElementById("price-max-label").innerHTML = "LKR " + new Intl.NumberFormat("en-US").format(slider.max);
    }
    applyFilters();
}

function setView(viewType) {
    currentView = viewType;
    const btnGrid = document.getElementById("btn-grid-view");
    const btnList = document.getElementById("btn-list-view");
    const container = document.getElementById("dynamic-product-container");
    
    if (viewType === 'grid') {
        if(btnGrid) { btnGrid.classList.add("btn-light", "active"); btnGrid.classList.remove("btn-white", "text-muted"); }
        if(btnList) { btnList.classList.add("btn-white", "text-muted"); btnList.classList.remove("btn-light", "active"); }
        if(container) { container.className = "row row-cols-1 row-cols-sm-2 row-cols-xl-4 g-4"; }
    } else {
        if(btnList) { btnList.classList.add("btn-light", "active"); btnList.classList.remove("btn-white", "text-muted"); }
        if(btnGrid) { btnGrid.classList.add("btn-white", "text-muted"); btnGrid.classList.remove("btn-light", "active"); }
        if(container) { container.className = "row row-cols-1 g-4"; }
    }
    renderDynamicProducts();
}

function updateResultCount() {
    const countEl = document.getElementById("result-count");
    if(countEl) {
        countEl.innerHTML = "Showing " + filteredProductList.length + " products";
    }
}

function renderDynamicProducts() {
    const container = document.getElementById("dynamic-product-container");
    if(!container) return;
    
    container.innerHTML = "";
    if(filteredProductList.length === 0) {
        container.innerHTML = `
            <div class="col-12 text-center py-5">
                <i class="bi bi-box-seam text-muted" style="font-size: 4rem; opacity: 0.5;"></i>
                <h4 class="text-dark fw-bold mt-3">No Products Found</h4>
                <p class="text-muted mb-4">We couldn't find any products matching your search criteria.</p>
                <a href="products.jsp" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">View All Products</a>
            </div>
        `;
        return;
    }

    filteredProductList.forEach((product) => {
        const id = product.stockId || product.id;
        const title = product.title;
        const price = product.price;
        const image = product.images && product.images.length > 0 ? product.images[0] : "https:
        const isOutOfStock = (product.qty <= 0);
        
        let badge = isOutOfStock ? `<span class="badge bg-danger rounded-pill px-2 py-1 fs-8 fw-bold">OUT OF STOCK</span>` :
                    window.location.pathname.includes("deals.jsp") ? `<span class="badge bg-danger rounded-pill px-2 py-1 fs-8">-HOT DEAL</span>` :
                    window.location.pathname.includes("new-arrivals.jsp") ? `<span class="badge bg-success rounded-pill px-2 py-1 fs-8">NEW</span>` : "";

        let cartBtnGrid = isOutOfStock 
            ? `<button class="btn btn-secondary border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 disabled" disabled style="opacity: 0.6; cursor: not-allowed;">
                    <i class="bi bi-slash-circle"></i> Out of Stock
               </button>`
            : `<button onclick="addToCart(${id}, 1);" class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                    <i class="bi bi-cart-plus"></i> Add to Cart
               </button>`;

        let cartBtnList = isOutOfStock
            ? `<button class="btn btn-secondary border px-4 py-2 rounded-3 fw-medium fs-7 d-flex align-items-center gap-2 disabled" disabled style="opacity: 0.6; cursor: not-allowed;">
                    <i class="bi bi-slash-circle"></i> Out of Stock
               </button>`
            : `<button onclick="addToCart(${id}, 1);" class="btn btn-outline-light text-dark border px-4 py-2 rounded-3 fw-medium fs-7 d-flex align-items-center gap-2 hover-bg-light">
                    <i class="bi bi-cart-plus"></i> Add to Cart
               </button>`;

        if (currentView === 'grid') {
            container.innerHTML += `
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                        <div class="position-absolute top-0 start-0 m-3 z-1">
                             ${badge}
                        </div>
                        <button onclick="addToWishlist(${id})" title="Add to Wishlist" class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-danger shadow-sm" style="width:32px; height:32px;">
                            <i class="bi bi-heart-fill"></i>
                        </button>
                        <a href="single-product.jsp?productId=${id}" class="p-3 pb-0 text-center bg-light m-2 rounded-4 d-block text-decoration-none">
                            <img src="${image}" class="card-img-top img-fluid mix-blend-multiply" alt="${title}" style="max-height: 160px; width: auto; object-fit: contain; ${isOutOfStock ? 'opacity: 0.6;' : ''}">
                        </a>
                        <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                <span class="fw-bold fs-8 me-1">4.5</span>
                            </div>
                            <h6 class="card-title fs-6 mb-2 fw-semibold product-title">${title}</h6>
                            <div class="mt-auto">
                                <div class="d-flex align-items-end gap-2 mb-3">
                                    <span class="text-dark fw-bold fs-5">Rs. ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(price)}</span>
                                </div>
                                ${cartBtnGrid}
                            </div>
                        </div>
                    </div>
                </div>`;
        } else {

            container.innerHTML += `
                <div class="col">
                    <div class="card border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                        <div class="row g-0">
                            <div class="col-md-3 bg-light m-2 rounded-4 d-flex align-items-center justify-content-center" style="position:relative;">
                                <div class="position-absolute top-0 start-0 m-2 z-1">${badge}</div>
                                <a href="single-product.jsp?productId=${id}" class="d-block text-decoration-none p-2">
                                    <img src="${image}" class="img-fluid mix-blend-multiply" alt="${title}" style="max-height: 140px; width: auto; object-fit: contain; ${isOutOfStock ? 'opacity: 0.6;' : ''}">
                                </a>
                            </div>
                            <div class="col-md-9">
                                <div class="card-body d-flex flex-column h-100 justify-content-center">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <h5 class="card-title fw-semibold product-title">${title}</h5>
                                            <div class="d-flex align-items-center mb-2">
                                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                                <span class="fw-bold fs-8 me-1">4.5</span>
                                            </div>
                                        </div>
                                        <button onclick="addToWishlist(${id})" title="Add to Wishlist" class="btn btn-light bg-white rounded-circle text-danger shadow-sm p-0 d-flex align-items-center justify-content-center" style="width:32px; height:32px;">
                                            <i class="bi bi-heart-fill"></i>
                                        </button>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between mt-3">
                                        <span class="text-dark fw-bold fs-4">Rs. ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(price)}</span>
                                        ${cartBtnList}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>`;
        }
    });
}
