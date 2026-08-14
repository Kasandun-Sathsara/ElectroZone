let currentPage = 0;
let productPerPage = 12;

window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        await loadAdvancedSearchData();
        await searchProduct(0);
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadAdvancedSearchData() {
    const urlParams = new URLSearchParams(window.location.search);
    if(urlParams.has('q')) {
        let qVal = urlParams.get('q');
        let searchInput = document.getElementById("search-input");
        if(searchInput) searchInput.value = qVal;
    }
    
    try {
        const response = await fetch("api/advanced-search/all-data");
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                populateSelect("filter-category", data.categoryList, "id", "name");
                populateSelect("filter-brand", data.brandList, "name", "name");
                populateSelect("filter-color", data.colorList, "value", "value");
                populateSelect("filter-storage", data.storageList, "value", "value");
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        }
    } catch (e) {
        console.error("Filter data loading failed:", e);
    }
}

function populateSelect(selectId, dataList, valueProp, textProp) {
    const select = document.getElementById(selectId);
    if (!select) return;
    
    // Keep the first default option
    const firstOption = select.options[0];
    select.innerHTML = "";
    if (firstOption) select.appendChild(firstOption);

    dataList.forEach(item => {
        const option = document.createElement("option");
        option.value = item[valueProp];
        option.textContent = item[textProp];
        select.appendChild(option);
    });
}

async function searchProduct(firstResult = 0) {
    if(typeof Notiflix !== 'undefined') Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
    try {
        const brandName = document.getElementById("filter-brand")?.value || "";
        const colorValue = document.getElementById("filter-color")?.value || "";
        const storageValue = document.getElementById("filter-storage")?.value || "";
        const sortValue = document.getElementById("sort-select")?.value || "1";
        
        const categoryId = document.getElementById("filter-category")?.value || "";
        const title = document.getElementById("search-input")?.value || "";

        const searchData = {
            firstResult: firstResult,
            brandName: brandName,
            colorValue: colorValue,
            storageValue: storageValue,
            priceStart: 0,
            priceEnd: 100000000,
            sortValue: sortValue
        };
        
        if (categoryId) searchData.categoryId = parseInt(categoryId);
        if (title) searchData.title = title;

        const response = await fetch("api/advanced-search/search-data", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(searchData)
        });

        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                updateProductView(data);
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        } else {
            Notiflix.Notify.failure("Search operation failed!", { position: 'center-top' });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    } finally {
        Notiflix.Loading.remove();
    }
}

function updateProductView(data) {
    const container = document.getElementById("search-results-container");
    if (!container) return;
    container.innerHTML = "";
    
    // Update count
    const countEl = document.getElementById("result-count-number");
    if (countEl) countEl.innerText = data.allProductCount || data.productList.length;
    
    // Update search term text
    const termEl = document.getElementById("result-search-term");
    const searchInput = document.getElementById("search-input");
    if (termEl && searchInput && searchInput.value) {
        termEl.innerText = `for "${searchInput.value}"`;
    } else if (termEl) {
        termEl.innerText = "";
    }
    
    // Update active filters UI
    const activeFiltersList = document.getElementById("active-filters-list");
    if (activeFiltersList) {
        activeFiltersList.innerHTML = '<span class="text-muted fs-8 fw-medium me-2">Active Filters:</span>';
        const brand = document.getElementById("filter-brand")?.value;
        const cat = document.getElementById("filter-category");
        const catText = cat && cat.selectedIndex > 0 ? cat.options[cat.selectedIndex].text : "";
        
        if (brand) activeFiltersList.innerHTML += `<span class="active-filter-chip">${brand} <i class="bi bi-x"></i></span>`;
        if (catText) activeFiltersList.innerHTML += `<span class="active-filter-chip">${catText} <i class="bi bi-x"></i></span>`;
    }

    if (data.productList.length === 0) {
        container.innerHTML = `
            <div class="col-12 text-center py-5">
                <i class="bi bi-box-seam text-muted" style="font-size: 4rem; opacity: 0.5;"></i>
                <h4 class="text-dark fw-bold mt-3">No Products Found</h4>
                <p class="text-muted mb-4">We couldn't find any products matching your search criteria.</p>
                <a href="search.jsp" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">Clear Filters</a>
            </div>
        `;
        return;
    }

    data.productList.forEach(item => {
        let imageSrc = item.images && item.images.length > 0 ? item.images[0] : 'assets/img/default-product.png';
        const formattedPrice = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(item.price);
        
        container.innerHTML += `
            <div class="product-list-card shadow-sm border border-light">
                <div class="card-img-container p-4 bg-white d-flex align-items-center justify-content-center" style="cursor:pointer;" onclick="window.location='single-product.jsp?productId=${item.stockId}'">
                    <img src="${imageSrc}" alt="${item.title}" style="max-width: 100%; max-height: 200px; object-fit: contain;">
                </div>
                <div class="card-body-wrapper p-4">
                    <div class="flex-grow-1 pe-lg-4">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h3 class="product-title-large m-0" style="font-size: 1.25rem;"><a href="single-product.jsp?productId=${item.stockId}" class="text-dark text-decoration-none">${item.title}</a></h3>
                            <button class="btn btn-link text-muted p-0 ms-3 hover-danger" onclick="addToWishlist(${item.stockId})"><i class="bi bi-heart-fill fs-5"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning d-flex gap-1 fs-8 me-2">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                            </div>
                            <span class="text-muted fs-8">(4.8)</span>
                        </div>
                        
                        <p class="text-muted fs-7 mb-4" style="max-height: 3em; overflow: hidden; text-overflow: ellipsis;">
                            ${item.description || 'High quality product available at ElectroZone.'}
                        </p>
                        
                        <div class="d-flex flex-wrap gap-2">
                            <span class="spec-pill bg-light rounded px-2 py-1 fs-8">${item.brandName || 'Brand'}</span>
                            <span class="spec-pill bg-light rounded px-2 py-1 fs-8">${item.storageValue || 'Standard'}</span>
                        </div>
                    </div>
                    
                    <div class="price-section text-end d-flex flex-column justify-content-between">
                        <div class="fw-bolder text-dark mb-1" style="font-size: 1.5rem;">LKR ${formattedPrice}</div>
                        <div class="mt-auto pt-3">
                            <button class="btn btn-primary w-100 rounded-3 py-2 fw-bold shadow-sm d-flex justify-content-center align-items-center gap-2" onclick="addToCart(${item.stockId},1)">
                                <i class="bi bi-cart-plus fs-5"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}

function clearFilters() {
    document.getElementById("search-input").value = "";
    document.getElementById("filter-category").selectedIndex = 0;
    document.getElementById("filter-brand").selectedIndex = 0;
    document.getElementById("filter-color").selectedIndex = 0;
    document.getElementById("filter-storage").selectedIndex = 0;
    document.getElementById("sort-select").value = "1";
    searchProduct(0);
}

