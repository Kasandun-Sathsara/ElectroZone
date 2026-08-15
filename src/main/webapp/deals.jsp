<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Hot Deals</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="bg-light">

    
    <jsp:include page="include/header.jsp"/>

    
    <div class="container mt-4 mb-2">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb fs-7">
                <li class="breadcrumb-item"><a href="index.jsp" class="text-muted text-decoration-none">Home</a></li>
                <li class="breadcrumb-item"><a href="#" class="text-muted text-decoration-none">Electronics</a></li>
                <li class="breadcrumb-item active text-dark fw-medium" aria-current="page">Hot Deals</li>
            </ol>
        </nav>
    </div>

    
    <main class="container mb-5">
        <div class="row">
            
            
            <aside class="col-lg-3 d-none d-lg-block pe-4">
                
                
                <div class="mb-4">
                    <h6 class="fw-bold text-uppercase text-muted fs-8 mb-3 letter-spacing-1">Categories</h6>
                    <ul class="list-unstyled mb-0 filter-list">
                        <li class="d-flex justify-content-between align-items-center mb-2">
                            <a href="#" class="text-dark fw-medium text-decoration-none fs-7">Smartphones</a>
                            <span class="text-muted fs-8">(120)</span>
                        </li>
                        <li class="d-flex justify-content-between align-items-center mb-2">
                            <a href="#" class="text-muted text-decoration-none fs-7 hover-dark">Laptops</a>
                            <span class="text-muted fs-8">(45)</span>
                        </li>
                        <li class="d-flex justify-content-between align-items-center mb-2">
                            <a href="#" class="text-muted text-decoration-none fs-7 hover-dark">Tablets</a>
                            <span class="text-muted fs-8">(12)</span>
                        </li>
                        <li class="d-flex justify-content-between align-items-center mb-2">
                            <a href="#" class="text-muted text-decoration-none fs-7 hover-dark">Audio</a>
                            <span class="text-muted fs-8">(89)</span>
                        </li>
                        <li class="d-flex justify-content-between align-items-center">
                            <a href="#" class="text-muted text-decoration-none fs-7 hover-dark">Wearables</a>
                            <span class="text-muted fs-8">(34)</span>
                        </li>
                    </ul>
                </div>

                
                <div class="mb-4 pt-3 border-top">
                    <h6 class="fw-bold text-uppercase text-muted fs-8 mb-3 letter-spacing-1">Price Range (LKR)</h6>
                    <div class="position-relative mt-4 mb-3">
                        <div class="progress" style="height: 4px;">
                            <div class="progress-bar bg-primary" role="progressbar" style="width: 40%; margin-left: 20%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <div class="position-absolute top-50 translate-middle bg-primary rounded-circle border border-2 border-white slider-thumb" style="width: 16px; height: 16px; left: 20%;"></div>
                        <div class="position-absolute top-50 translate-middle bg-primary rounded-circle border border-2 border-white slider-thumb" style="width: 16px; height: 16px; left: 60%;"></div>
                    </div>
                    <div class="d-flex justify-content-between mb-3 text-dark fw-medium fs-7">
                        <span>LKR 0</span>
                        <span>LKR 600k+</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <input type="text" class="form-control form-control-sm text-center fs-7 text-muted" value="LKR 0" readonly>
                        <span class="text-muted">-</span>
                        <input type="text" class="form-control form-control-sm text-center fs-7 text-muted" value="LKR 255k" readonly>
                    </div>
                </div>

                
                <div class="mb-4 pt-3 border-top">
                    <h6 class="fw-bold text-uppercase text-muted fs-8 mb-3 letter-spacing-1">Brands</h6>
                    <div class="form-check mb-2 custom-checkbox">
                        <input class="form-check-input" type="checkbox" id="brandApple">
                        <label class="form-check-label fs-7 text-muted" for="brandApple">Apple</label>
                    </div>
                    <div class="form-check mb-2 custom-checkbox">
                        <input class="form-check-input" type="checkbox" id="brandSamsung" checked>
                        <label class="form-check-label fs-7 text-dark fw-medium" for="brandSamsung">Samsung</label>
                    </div>
                    <div class="form-check mb-2 custom-checkbox">
                        <input class="form-check-input" type="checkbox" id="brandSony">
                        <label class="form-check-label fs-7 text-muted" for="brandSony">Sony</label>
                    </div>
                    <div class="form-check mb-2 custom-checkbox">
                        <input class="form-check-input" type="checkbox" id="brandGoogle">
                        <label class="form-check-label fs-7 text-muted" for="brandGoogle">Google</label>
                    </div>
                    <div class="form-check custom-checkbox">
                        <input class="form-check-input" type="checkbox" id="brandDell">
                        <label class="form-check-label fs-7 text-muted" for="brandDell">Dell</label>
                    </div>
                </div>

                
                <div class="mb-4 pt-3 border-top">
                    <h6 class="fw-bold text-uppercase text-muted fs-8 mb-3 letter-spacing-1">Ratings</h6>
                    <div class="form-check mb-2 custom-radio d-flex align-items-center">
                        <input class="form-check-input mt-0 me-2" type="radio" name="rating" id="rating4">
                        <label class="form-check-label fs-7 text-muted d-flex align-items-center" for="rating4">
                            <div class="text-warning me-2 d-flex">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star"></i>
                            </div>
                            & Up
                        </label>
                    </div>
                    <div class="form-check custom-radio d-flex align-items-center">
                        <input class="form-check-input mt-0 me-2" type="radio" name="rating" id="rating3">
                        <label class="form-check-label fs-7 text-muted d-flex align-items-center" for="rating3">
                            <div class="text-warning me-2 d-flex">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star"></i>
                                <i class="bi bi-star"></i>
                            </div>
                            & Up
                        </label>
                    </div>
                </div>

            </aside>

            
            <div class="col-lg-9">
                
                
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-3">
                    <h2 class="fw-bold fs-4 mb-0">Hot Deals</h2>
                    
                    <div class="d-flex align-items-center gap-3">
                        <span id="result-count" class="text-muted fs-7">Showing products...</span>
                        <div class="dropdown">
                            <button class="btn btn-outline-light text-dark border bg-white btn-sm px-3 dropdown-toggle rounded-3 fs-7" type="button" data-bs-toggle="dropdown" id="sort-btn">
                                Sort by: Featured
                            </button>
                            <ul class="dropdown-menu fs-7">
                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="sortProducts('featured')">Featured</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="sortProducts('price_asc')">Price: Low to High</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="sortProducts('price_desc')">Price: High to Low</a></li>
                            </ul>
                        </div>
                        <div class="btn-group border bg-white rounded-3 overflow-hidden d-none d-sm-flex" role="group">
                            <button type="button" id="btn-grid-view" onclick="setView('grid')" class="btn btn-light btn-sm text-dark px-2 active"><i class="bi bi-grid-fill"></i></button>
                            <button type="button" id="btn-list-view" onclick="setView('list')" class="btn btn-white btn-sm text-muted px-2"><i class="bi bi-list"></i></button>
                        </div>
                    </div>
                </div>

                
                <div class="d-flex flex-wrap align-items-center gap-2 mb-4">
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1" onclick="this.remove()">
                        Samsung <i class="bi bi-x cursor-pointer"></i>
                    </span>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1" onclick="this.remove()">
                        LKR 0 - LKR 255k <i class="bi bi-x cursor-pointer"></i>
                    </span>
                    <a href="#" onclick="this.parentElement.innerHTML=''" class="text-muted fs-7 ms-2 text-decoration-none hover-dark">Clear All</a>
                </div>

                
                <div id="dynamic-product-container" class="row row-cols-1 row-cols-sm-2 row-cols-xl-4 g-4">
                </div>

                
                <div class="d-flex justify-content-center mt-5 mb-3">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm gap-2">
                            <li class="page-item disabled">
                                <a class="page-link rounded bg-white text-muted border-0 shadow-sm px-3" href="#" tabindex="-1" aria-disabled="true"><i class="bi bi-chevron-left"></i></a>
                            </li>
                            <li class="page-item active" aria-current="page">
                                <a class="page-link rounded bg-primary text-white border-0 shadow-sm px-3 fw-medium" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link rounded bg-white text-dark border-0 shadow-sm px-3 fw-medium" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link rounded bg-white text-dark border-0 shadow-sm px-3 fw-medium" href="#">3</a>
                            </li>
                            <li class="page-item disabled">
                                <span class="page-link border-0 bg-transparent text-muted px-2">...</span>
                            </li>
                            <li class="page-item">
                                <a class="page-link rounded bg-white text-dark border-0 shadow-sm px-3 fw-medium" href="#">8</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link rounded bg-white text-dark border-0 shadow-sm px-3" href="#"><i class="bi bi-chevron-right"></i></a>
                            </li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </main>

    
    <footer class="bg-white border-top pt-5 pb-3">
        <div class="container mb-4">
            <div class="row gy-4">
                <div class="col-lg-4 pe-lg-5">
                    <a class="d-flex align-items-center gap-2 mb-3 text-decoration-none" href="index.jsp">
                        <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 34px; height: 34px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 9px;">
                            <i class="bi bi-lightning-fill text-white fs-6"></i>
                        </div>
                        <span class="fw-bold fs-4 tracking-tight text-dark mb-0">Electro<span class="text-primary">Zone</span></span>
                    </a>
                    <p class="text-muted fs-7 mb-4">
                        Your one-stop destination for the latest in tech, gadgets, and accessories. Premium quality at unbeatable prices.
                    </p>
                    <div class="d-flex gap-2">
                        <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center social-icon"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center social-icon"><i class="bi bi-twitter-x"></i></a>
                        <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center social-icon"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center social-icon"><i class="bi bi-youtube"></i></a>
                    </div>
                </div>
                
                <div class="col-6 col-sm-4 col-lg-2">
                    <h6 class="fw-bold mb-4 text-dark">Shop</h6>
                    <a href="new-arrivals.jsp" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">New Arrivals</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Best Sellers</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Laptops & Computers</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Smartphones</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Audio & Headphones</a>
                </div>

                <div class="col-6 col-sm-4 col-lg-2">
                    <h6 class="fw-bold mb-4 text-dark">Support</h6>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Help Center</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Order Status</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Returns & Warranty</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Contact Us</a>
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">Shipping Info</a>
                </div>

                <div class="col-sm-4 col-lg-4">
                    <h6 class="fw-bold mb-4 text-dark">Contact</h6>
                    <ul class="list-unstyled mb-0">
                        <li class="d-flex align-items-start mb-3">
                            <i class="bi bi-geo-alt-fill text-muted mt-1 me-3"></i>
                            <span class="text-muted fs-7">123 Tech Boulevard,<br>Silicon Valley, CA 94000</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <i class="bi bi-telephone-fill text-muted me-3"></i>
                            <span class="text-muted fs-7">+1 (800) 123-4567</span>
                        </li>
                        <li class="d-flex align-items-center">
                            <i class="bi bi-envelope-fill text-muted me-3"></i>
                            <span class="text-muted fs-7">support@electrozone.com</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="container footer-bottom">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                <p class="text-muted fs-8 mb-0">&copy; 2023 ElectroZone Inc. All rights reserved.</p>
                <div class="d-flex gap-3 align-items-center text-muted fs-7">
                    <span><i class="bi bi-shield-check text-success me-1"></i> Secure Payments</span>
                    <span><i class="bi bi-truck text-primary me-1"></i> Island-wide Delivery</span>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js?v=2"></script>
    <script src="assets/js/dynamic-grid.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const searchInputs = document.querySelectorAll('.search-input');
            searchInputs.forEach(input => {
                input.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        const query = this.value.trim();
                        if (query) {
                            window.location.href = 'products.jsp?q=' + encodeURIComponent(query);
                        }
                    }
                });
            });
        });
    </script>
</body>

</html>

