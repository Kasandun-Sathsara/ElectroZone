<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iPhone 15 Pro Max - ElectroZone</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="bg-light" style="background-color: var(--bg-light) !important;">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top">
        <div class="container">
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm">
                    <i class="bi bi-lightning-fill text-white"></i>
                </div>
                <span class="fw-bold fs-4 tracking-tight text-dark">ElectroZone</span>
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Content -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <!-- Search Bar -->
                <div class="search-wrapper mx-lg-4 flex-grow-1 position-relative d-none d-lg-block" style="max-width: 400px;">
                    <i class="bi bi-search"></i>
                    <input type="text" class="form-control rounded-pill search-input w-100" placeholder="Search products...">
                </div>

                <!-- Navigation Links -->
                <ul class="navbar-nav mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Smartphones</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Laptops</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Gadgets</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Deals</a>
                    </li>
                </ul>

                <!-- Icons -->
                <div class="d-flex align-items-center ms-lg-auto mt-3 mt-lg-0">
                    <a href="#" class="text-dark position-relative me-3">
                        <i class="bi bi-cart3 fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                            2
                        </span>
                    </a>
                    <a href="login.jsp" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center border" style="width: 40px; height: 40px;">
                        <i class="bi bi-person text-dark fs-5"></i>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4">
        
        <!-- Breadcrumbs -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">Home</a></li>
                <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">Smartphones</a></li>
                <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">Apple</a></li>
                <li class="breadcrumb-item active breadcrumb-current" aria-current="page">iPhone 15 Pro Max</li>
            </ol>
        </nav>

        <div class="row g-5 mb-5 bg-white p-4 rounded-4 shadow-sm border" style="border-color: #f1f3f5 !important;">
            <!-- Left Column: Image Gallery -->
            <div class="col-lg-6">
                <!-- Main Image -->
                <div class="product-gallery-main mb-3">
                    <span class="badge bg-primary position-absolute top-0 start-0 m-3 fs-8 px-2 py-1">NEW</span>
                    <img src="assets/img/iphone_15_pro_max_1780590648972.png" alt="iPhone 15 Pro Max" id="mainImage">
                </div>
                
                <!-- Thumbnails -->
                <div class="d-flex gap-3 justify-content-center">
                    <div class="gallery-thumbnail active">
                        <img src="assets/img/iphone_15_pro_max_1780590648972.png" alt="Thumbnail 1">
                    </div>
                    <div class="gallery-thumbnail">
                        <img src="assets/img/iphone_15_black_1780590662560.png" alt="Thumbnail 2">
                    </div>
                    <div class="gallery-thumbnail" style="background-color: #fcf1e8;">
                        <img src="assets/img/iphone_15_pro_max_1780590648972.png" alt="Thumbnail 3">
                    </div>
                    <div class="gallery-thumbnail">
                        <img src="assets/img/iphone_15_black_1780590662560.png" alt="Thumbnail 4">
                    </div>
                </div>
            </div>

            <!-- Right Column: Product Details -->
            <div class="col-lg-6">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <span class="text-primary fw-bold fs-7 tracking-tight text-uppercase">APPLE</span>
                    <span class="text-success fw-bold fs-7"><i class="bi bi-check-circle-fill me-1"></i>In Stock</span>
                </div>
                
                <h1 class="fw-bolder mb-3 text-dark tracking-tight display-5">iPhone 15 Pro Max</h1>
                
                <div class="d-flex align-items-center mb-4">
                    <div class="text-warning me-2 fs-6">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-half"></i>
                    </div>
                    <span class="fw-bold fs-7 me-1">4.8</span>
                    <span class="text-muted fs-7">(2,400 Reviews)</span>
                </div>

                <div class="d-flex align-items-end mb-4 pb-4 border-bottom">
                    <div>
                        <div class="fw-bolder display-6 text-dark tracking-tight mb-0 lh-1">LKR 389,900.00</div>
                    </div>
                    <div class="ms-4 text-center">
                        <div class="text-muted text-decoration-line-through fs-7 fw-medium mb-1">LKR 422,900.00</div>
                        <span class="badge bg-danger bg-opacity-10 text-danger fs-8 fw-bold">-8% OFF</span>
                    </div>
                </div>

                <!-- Color Selection -->
                <div class="mb-4">
                    <span class="text-dark fs-7 fw-medium mb-2 d-block">Color: <span class="text-muted">Natural Titanium</span></span>
                    <div class="d-flex gap-2">
                        <div class="color-wrapper active">
                            <span class="color-option" style="background-color: #bebdb9;"></span>
                        </div>
                        <div class="color-wrapper">
                            <span class="color-option" style="background-color: #3b404d;"></span>
                        </div>
                        <div class="color-wrapper">
                            <span class="color-option" style="background-color: #2b2b2b;"></span>
                        </div>
                        <div class="color-wrapper">
                            <span class="color-option" style="background-color: #f1f2f3; border: 1px solid #e1e4e8;"></span>
                        </div>
                    </div>
                </div>

                <!-- Storage Selection -->
                <div class="mb-4 pb-4 border-bottom">
                    <span class="text-dark fs-7 fw-medium mb-2 d-block">Storage</span>
                    <div class="d-flex gap-2">
                        <button class="storage-btn">256GB</button>
                        <button class="storage-btn active">512GB</button>
                        <button class="storage-btn">1TB</button>
                    </div>
                </div>

                <!-- Actions -->
                <div class="d-flex gap-3 mb-4">
                    <div class="qty-selector">
                        <button class="qty-btn"><i class="bi bi-dash"></i></button>
                        <input type="text" value="1" class="qty-input">
                        <button class="qty-btn"><i class="bi bi-plus"></i></button>
                    </div>
                    <button class="btn btn-primary btn-lg fw-bold flex-grow-1 shadow-sm d-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-cart-plus fs-5"></i> Add to Cart
                    </button>
                    <button class="btn btn-buy-now btn-lg fw-bold px-4 shadow-sm">
                        Buy Now
                    </button>
                </div>

                <!-- Specs Grid -->
                <div class="row g-3 mb-4">
                    <div class="col-sm-6">
                        <div class="spec-box">
                            <div class="spec-icon"><i class="bi bi-cpu"></i></div>
                            <div>
                                <div class="spec-title">Processor</div>
                                <div class="spec-value">A17 Pro Chip</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="spec-box">
                            <div class="spec-icon"><i class="bi bi-camera"></i></div>
                            <div>
                                <div class="spec-title">Camera</div>
                                <div class="spec-value">48MP Main</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="spec-box">
                            <div class="spec-icon"><i class="bi bi-battery-charging"></i></div>
                            <div>
                                <div class="spec-title">Battery</div>
                                <div class="spec-value">29 hrs Video</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="spec-box">
                            <div class="spec-icon"><i class="bi bi-shield-check"></i></div>
                            <div>
                                <div class="spec-title">Warranty</div>
                                <div class="spec-value">1 Year Apple</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delivery Box -->
                <div class="delivery-box mt-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-truck fs-5 text-dark me-2"></i>
                        <span class="fw-bold fs-7 text-dark">Delivery Details</span>
                    </div>
                    <div class="postal-input-group mb-3">
                        <input type="text" class="postal-input" placeholder="Enter Postal Code">
                        <button class="postal-btn">Check</button>
                    </div>
                    <p class="text-muted fs-8 mb-0">Free delivery by <strong>Tue, Oct 24</strong> to <u>Colombo 03</u></p>
                </div>

            </div>
        </div>

        <!-- You might also like Section -->
        <section class="mb-5 pb-3">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">You might also like</h3>
                <a href="#" class="text-decoration-none fw-bold link-primary fs-7">View all <i class="bi bi-arrow-right"></i></a>
            </div>

            <div class="row g-4">
                <!-- Product 1 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white shadow-sm border-0">
                        <div class="product-img-wrapper bg-light">
                            <img src="assets/img/iphone_15_black_1780590662560.png" alt="iPhone 15" class="img-fluid" style="mix-blend-mode: multiply;">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <span class="text-muted fs-8 fw-medium mb-1">Apple</span>
                            <h5 class="fs-6 fw-bold mb-3 text-dark">iPhone 15</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 259,900</div>
                                </div>
                                <button class="btn btn-link p-0 text-primary"><i class="bi bi-cart-plus fs-4"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white shadow-sm border-0">
                        <div class="product-img-wrapper" style="background-color: #111;">
                            <img src="assets/img/watch_1777403179511.png" alt="Apple Watch Series 9" class="img-fluid">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <span class="text-muted fs-8 fw-medium mb-1">Apple</span>
                            <h5 class="fs-6 fw-bold mb-3 text-dark">Apple Watch Series 9</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 129,900</div>
                                </div>
                                <button class="btn btn-link p-0 text-primary"><i class="bi bi-cart-plus fs-4"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white shadow-sm border-0">
                        <div class="product-img-wrapper" style="background-color: #ebeae5;">
                            <span class="product-badge bg-danger text-white">HOT</span>
                            <img src="assets/img/laptop_1777403253050.png" alt="MacBook Pro 14" class="img-fluid" style="mix-blend-mode: multiply;">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <span class="text-muted fs-8 fw-medium mb-1">Apple</span>
                            <h5 class="fs-6 fw-bold mb-3 text-dark">MacBook Pro 14"</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 519,900</div>
                                </div>
                                <button class="btn btn-link p-0 text-primary"><i class="bi bi-cart-plus fs-4"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white shadow-sm border-0">
                        <div class="product-img-wrapper" style="background-color: #d1e2da;">
                            <img src="assets/img/earbuds_1777403268133.png" alt="AirPods Pro" class="img-fluid" style="mix-blend-mode: multiply;">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <span class="text-muted fs-8 fw-medium mb-1">Apple</span>
                            <h5 class="fs-6 fw-bold mb-3 text-dark">AirPods Pro (2nd Gen)</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 84,900</div>
                                </div>
                                <button class="btn btn-link p-0 text-primary"><i class="bi bi-cart-plus fs-4"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple script for gallery thumbnails
        document.querySelectorAll('.gallery-thumbnail').forEach(item => {
            item.addEventListener('click', function() {
                // Remove active from all
                document.querySelectorAll('.gallery-thumbnail').forEach(thumb => {
                    thumb.classList.remove('active');
                });
                // Add active to clicked
                this.classList.add('active');
                // Change main image source
                const newSrc = this.querySelector('img').getAttribute('src');
                document.getElementById('mainImage').setAttribute('src', newSrc);
            });
        });
    </script>
</body>
</html>
