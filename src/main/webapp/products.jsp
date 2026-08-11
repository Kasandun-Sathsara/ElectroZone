<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Smartphones & Accessories</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="bg-light">

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
                    <i class="bi bi-search" style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #6c757d;"></i>
                    <input type="text" class="form-control rounded-pill search-input w-100 bg-light border-0 ps-5" placeholder="Search for laptops, phones...">
                </div>

                <!-- Navigation Links -->
                <ul class="navbar-nav mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Deals</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">New Arrivals</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Brands</a>
                    </li>
                </ul>

                <!-- Icons -->
                <div class="d-flex align-items-center ms-lg-auto mt-3 mt-lg-0">
                    <a href="#" class="text-dark position-relative me-3">
                        <i class="bi bi-heart fs-5"></i>
                    </a>
                    <a href="#" class="text-dark position-relative me-3">
                        <i class="bi bi-cart3 fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary" style="font-size: 0.6rem;">
                            3
                        </span>
                    </a>
                    <a href="login.jsp" class="btn rounded-circle p-0 d-flex align-items-center justify-content-center border-0 overflow-hidden" style="width: 40px; height: 40px;">
                        <img src="https://ui-avatars.com/api/?name=User&background=random" alt="User" class="img-fluid">
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Breadcrumb -->
    <div class="container mt-4 mb-2">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb fs-7">
                <li class="breadcrumb-item"><a href="index.jsp" class="text-muted text-decoration-none">Home</a></li>
                <li class="breadcrumb-item"><a href="#" class="text-muted text-decoration-none">Electronics</a></li>
                <li class="breadcrumb-item active text-dark fw-medium" aria-current="page">Smartphones & Accessories</li>
            </ol>
        </nav>
    </div>

    <!-- Main Content -->
    <main class="container mb-5">
        <div class="row">
            
            <!-- Sidebar Filters -->
            <aside class="col-lg-3 d-none d-lg-block pe-4">
                
                <!-- Categories -->
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

                <!-- Price Range -->
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

                <!-- Brands -->
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

                <!-- Ratings -->
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

            <!-- Product Grid Area -->
            <div class="col-lg-9">
                
                <!-- Top Bar -->
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-3">
                    <h2 class="fw-bold fs-4 mb-0">Smartphones & Accessories</h2>
                    
                    <div class="d-flex align-items-center gap-3">
                        <span class="text-muted fs-7">Showing 1-12 of 120</span>
                        <div class="dropdown">
                            <button class="btn btn-outline-light text-dark border bg-white btn-sm px-3 dropdown-toggle rounded-3 fs-7" type="button" data-bs-toggle="dropdown">
                                Sort by: Featured
                            </button>
                            <ul class="dropdown-menu fs-7">
                                <li><a class="dropdown-item" href="#">Featured</a></li>
                                <li><a class="dropdown-item" href="#">Price: Low to High</a></li>
                                <li><a class="dropdown-item" href="#">Price: High to Low</a></li>
                            </ul>
                        </div>
                        <div class="btn-group border bg-white rounded-3 overflow-hidden d-none d-sm-flex" role="group">
                            <button type="button" class="btn btn-light btn-sm text-dark px-2 active"><i class="bi bi-grid-fill"></i></button>
                            <button type="button" class="btn btn-white btn-sm text-muted px-2"><i class="bi bi-list"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Active Filters -->
                <div class="d-flex flex-wrap align-items-center gap-2 mb-4">
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1">
                        Samsung <i class="bi bi-x cursor-pointer"></i>
                    </span>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-medium border border-primary border-opacity-25 d-flex align-items-center gap-1">
                        LKR 0 - LKR 255k <i class="bi bi-x cursor-pointer"></i>
                    </span>
                    <a href="#" class="text-muted fs-7 ms-2 text-decoration-none hover-dark">Clear All</a>
                </div>

                <!-- Grid -->
                <div class="row row-cols-1 row-cols-sm-2 row-cols-xl-4 g-4">
                    
                    <!-- Product 1 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <div class="position-absolute top-0 start-0 m-3 z-1">
                                <span class="badge bg-danger rounded-pill px-2 py-1 fs-8">-15% OFF</span>
                            </div>
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/1e1e1e/FFF?text=Phone" class="card-img-top img-fluid mix-blend-multiply" alt="Galaxy S23 Ultra" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.8</span>
                                    <span class="text-muted fs-8">(120)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Galaxy S23 Ultra 5G - Phantom Black</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-primary fw-bold fs-5">LKR 299,700</span>
                                        <span class="text-muted text-decoration-line-through fs-8 mb-1">LKR 359,700</span>
                                    </div>
                                    <button class="btn btn-primary w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 2 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <div class="position-absolute top-0 start-0 m-3 z-1">
                                <span class="badge bg-success rounded-pill px-2 py-1 fs-8">NEW</span>
                            </div>
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/1e1e1e/FFF?text=MacBook" class="card-img-top img-fluid mix-blend-multiply" alt="MacBook Air" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.9</span>
                                    <span class="text-muted fs-8">(56)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">MacBook Air M2 13-inch - Midnight</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 329,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 3 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/1e1e1e/FFF?text=Watch" class="card-img-top img-fluid mix-blend-multiply" alt="Apple Watch" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.5</span>
                                    <span class="text-muted fs-8">(32)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Apple Watch Series 8 GPS 45mm</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 119,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 4 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <div class="position-absolute top-0 start-0 m-3 z-1">
                                <span class="badge bg-primary rounded-pill px-2 py-1 fs-8">BEST SELLER</span>
                            </div>
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Headphones" class="card-img-top img-fluid mix-blend-multiply" alt="Sony Headphones" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.7</span>
                                    <span class="text-muted fs-8">(215)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Sony WH-1000XM5 Wireless Headphones</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 104,400</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 5 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Tablet" class="card-img-top img-fluid mix-blend-multiply" alt="iPad Air" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.6</span>
                                    <span class="text-muted fs-8">(88)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">iPad Air 5th Gen 64GB Wi-Fi</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 167,700</span>
                                        <span class="text-muted text-decoration-line-through fs-8 mb-1">LKR 179,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 6 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Controller" class="card-img-top img-fluid mix-blend-multiply" alt="PS5 Controller" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.9</span>
                                    <span class="text-muted fs-8">(450)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">PS5 DualSense Wireless Controller</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 20,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 7 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Samsung+Tab" class="card-img-top img-fluid mix-blend-multiply" alt="Samsung Galaxy Tab S8" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.3</span>
                                    <span class="text-muted fs-8">(14)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Samsung Galaxy Tab S8</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 209,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 8 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <div class="position-absolute top-0 start-0 m-3 z-1">
                                <span class="badge bg-danger rounded-pill px-2 py-1 fs-8">-20% OFF</span>
                            </div>
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Fitbit" class="card-img-top img-fluid mix-blend-multiply" alt="Fitbit Versa 4" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.5</span>
                                    <span class="text-muted fs-8">(76)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Fitbit Versa 4 Fitness Smartwatch</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-primary fw-bold fs-5">LKR 59,985</span>
                                        <span class="text-muted text-decoration-line-through fs-8 mb-1">LKR 74,985</span>
                                    </div>
                                    <button class="btn btn-primary w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 9 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/1e1e1e/FFF?text=JBL+Tune" class="card-img-top img-fluid mix-blend-multiply" alt="JBL Tune" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.1</span>
                                    <span class="text-muted fs-8">(33)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">JBL Tune 510BT Wireless</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 14,985</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 10 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=iPhone+SE" class="card-img-top img-fluid mix-blend-multiply" alt="iPhone SE" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.7</span>
                                    <span class="text-muted fs-8">(190)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Apple iPhone SE (3rd Gen)</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 128,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 11 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/1e1e1e/FFF?text=Speaker" class="card-img-top img-fluid mix-blend-multiply" alt="UE Wonderboom" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">4.8</span>
                                    <span class="text-muted fs-8">(112)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">UE Wonderboom 2 Portable Speaker</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 26,997</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product 12 -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm product-card position-relative bg-white rounded-4 overflow-hidden">
                            <div class="position-absolute top-0 start-0 m-3 z-1">
                                <span class="badge bg-primary rounded-pill px-2 py-1 fs-8">PRE-ORDER</span>
                            </div>
                            <button class="btn btn-light bg-white rounded-circle position-absolute top-0 end-0 m-3 z-1 p-0 d-flex align-items-center justify-content-center text-muted hover-danger shadow-sm" style="width:32px; height:32px;">
                                <i class="bi bi-heart-fill text-muted"></i>
                            </button>
                            <div class="p-3 pb-0 text-center bg-light m-2 rounded-4">
                                <img src="https://placehold.co/400x400/e0e0e0/000?text=Razer+Blade" class="card-img-top img-fluid mix-blend-multiply" alt="Razer Blade" style="max-height: 160px; width: auto; object-fit: contain;">
                            </div>
                            <div class="card-body d-flex flex-column px-3 pt-3 pb-4">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                    <span class="fw-bold fs-8 me-1">5.0</span>
                                    <span class="text-muted fs-8">(12)</span>
                                </div>
                                <h6 class="card-title fs-6 mb-2 fw-semibold product-title">Razer Blade 15 Gaming Laptop</h6>
                                <div class="mt-auto">
                                    <div class="d-flex align-items-end gap-2 mb-3">
                                        <span class="text-dark fw-bold fs-5">LKR 749,700</span>
                                    </div>
                                    <button class="btn btn-outline-light text-dark border w-100 rounded-3 py-2 fw-medium fs-7 d-flex align-items-center justify-content-center gap-2 hover-bg-light">
                                        <i class="bi bi-box-seam"></i> Pre-order
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Pagination -->
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

    <!-- Footer -->
    <footer class="bg-white border-top pt-5 pb-3">
        <div class="container mb-4">
            <div class="row gy-4">
                <div class="col-lg-4 pe-lg-5">
                    <a class="d-flex align-items-center mb-3 text-decoration-none" href="#">
                        <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm">
                            <i class="bi bi-lightning-fill text-white"></i>
                        </div>
                        <span class="fw-bold fs-4 tracking-tight text-dark">ElectroZone</span>
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
                    <a href="#" class="footer-link d-block mb-2 text-muted text-decoration-none fs-7 hover-primary">New Arrivals</a>
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
                <p class="text-muted fs-8 mb-2 mb-md-0">&copy; 2023 ElectroZone Inc. All rights reserved.</p>
                <div class="d-flex gap-2">
                    <div class="bg-light p-1 rounded"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png" alt="Mastercard" height="20"></div>
                    <div class="bg-light p-1 rounded"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" alt="Visa" height="20"></div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
