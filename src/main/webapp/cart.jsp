<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Your Cart</title>
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
                <div class="search-wrapper mx-lg-4 flex-grow-1 position-relative d-none d-lg-block" style="max-width: 500px;">
                    <i class="bi bi-search" style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #6c757d;"></i>
                    <input type="text" class="form-control rounded-pill search-input w-100 bg-light border-0 ps-5" placeholder="Search for smartphones, laptops...">
                </div>

                <!-- Navigation Links -->
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 fw-medium align-items-center">
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="products.jsp">Smartphones</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Laptops</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Gadgets</a>
                    </li>
                    <li class="nav-item mx-2 ms-lg-4">
                        <a href="login.jsp" class="text-dark fs-5 text-decoration-none">
                            <i class="bi bi-person-fill"></i>
                        </a>
                    </li>
                    <li class="nav-item mx-2">
                        <a href="#" class="text-primary position-relative d-flex align-items-center justify-content-center bg-primary bg-opacity-10 rounded-circle" style="width: 42px; height: 42px;">
                            <i class="bi bi-cart3 fs-5"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary" style="font-size: 0.65rem;">
                                2
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-5">
        
        <div class="mb-4">
            <h1 class="fw-bolder display-6 d-inline-block me-2">Your Cart</h1>
            <span class="text-muted fs-5 fw-medium">(2 items)</span>
            <div class="text-success mt-2 fw-medium fs-7 d-flex align-items-center">
                <i class="bi bi-truck me-2 fs-6"></i> You qualify for Free Shipping!
            </div>
        </div>

        <div class="row g-4">
            
            <!-- Cart Items Area -->
            <div class="col-lg-8">
                
                <!-- Header Row -->
                <div class="d-none d-md-flex text-muted fs-7 fw-medium mb-3 px-3">
                    <div class="col-md-5">Product</div>
                    <div class="col-md-3 text-center">Price</div>
                    <div class="col-md-2 text-center">Quantity</div>
                    <div class="col-md-2 text-end">Total</div>
                </div>

                <!-- Cart Item 1 -->
                <div class="card border-0 shadow-sm rounded-4 mb-3 p-3 position-relative">
                    <div class="row align-items-center gy-3">
                        <div class="col-12 col-md-5 d-flex align-items-center gap-3">
                            <div class="bg-light rounded-3 p-2 d-flex align-items-center justify-content-center mix-blend-multiply" style="width: 90px; height: 90px; flex-shrink: 0;">
                                <img src="assets/img/iphone_15_pro_max_1780590648972.png" alt="iPhone 15 Pro Max" class="img-fluid" style="max-height: 100%;">
                            </div>
                            <div>
                                <div class="text-primary fw-bold text-uppercase fs-8 letter-spacing-1 mb-1">APPLE</div>
                                <h6 class="fw-bold fs-6 mb-1">iPhone 15 Pro Max</h6>
                                <p class="text-muted fs-7 mb-0">256GB - Natural Titanium</p>
                            </div>
                        </div>
                        
                        <div class="col-6 col-md-3 text-md-center">
                            <span class="d-md-none text-muted fs-7 me-2">Price:</span>
                            <span class="fw-medium text-dark">LKR 365,000.00</span>
                        </div>
                        
                        <div class="col-6 col-md-2 d-flex justify-content-md-center justify-content-end">
                            <div class="qty-selector-pill d-flex align-items-center bg-light rounded-pill px-2 py-1 border">
                                <button class="btn btn-sm text-muted p-0 border-0 fw-medium d-flex align-items-center justify-content-center hover-dark" style="width: 24px; height: 24px;"><i class="bi bi-dash"></i></button>
                                <span class="fw-bold mx-3 fs-7">1</span>
                                <button class="btn btn-sm text-muted p-0 border-0 fw-medium d-flex align-items-center justify-content-center hover-dark" style="width: 24px; height: 24px;"><i class="bi bi-plus"></i></button>
                            </div>
                        </div>
                        
                        <div class="col-12 col-md-2 text-md-end text-center mt-3 mt-md-0 d-flex flex-column align-items-md-end align-items-center">
                            <div class="mb-1">
                                <span class="text-dark fw-bold fs-8">LKR</span><br class="d-none d-md-block">
                                <span class="fw-bold fs-6">365,000.00</span>
                            </div>
                            <button class="btn text-muted p-0 mt-2 hover-danger"><i class="bi bi-trash-fill fs-5"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Cart Item 2 -->
                <div class="card border-0 shadow-sm rounded-4 mb-4 p-3 position-relative">
                    <div class="row align-items-center gy-3">
                        <div class="col-12 col-md-5 d-flex align-items-center gap-3">
                            <div class="bg-light rounded-3 p-2 d-flex align-items-center justify-content-center mix-blend-multiply" style="width: 90px; height: 90px; flex-shrink: 0; background: #e0e6ed !important;">
                                <img src="assets/img/headphones_1777403193238.png" alt="WH-1000XM5 Headphones" class="img-fluid" style="max-height: 100%;">
                            </div>
                            <div>
                                <div class="text-primary fw-bold text-uppercase fs-8 letter-spacing-1 mb-1">SONY</div>
                                <h6 class="fw-bold fs-6 mb-1">WH-1000XM5 Headphones</h6>
                                <p class="text-muted fs-7 mb-0">Noise Canceling - Black</p>
                            </div>
                        </div>
                        
                        <div class="col-6 col-md-3 text-md-center">
                            <span class="d-md-none text-muted fs-7 me-2">Price:</span>
                            <span class="fw-medium text-dark">LKR 105,500.00</span>
                        </div>
                        
                        <div class="col-6 col-md-2 d-flex justify-content-md-center justify-content-end">
                            <div class="qty-selector-pill d-flex align-items-center bg-light rounded-pill px-2 py-1 border">
                                <button class="btn btn-sm text-muted p-0 border-0 fw-medium d-flex align-items-center justify-content-center hover-dark" style="width: 24px; height: 24px;"><i class="bi bi-dash"></i></button>
                                <span class="fw-bold mx-3 fs-7">1</span>
                                <button class="btn btn-sm text-muted p-0 border-0 fw-medium d-flex align-items-center justify-content-center hover-dark" style="width: 24px; height: 24px;"><i class="bi bi-plus"></i></button>
                            </div>
                        </div>
                        
                        <div class="col-12 col-md-2 text-md-end text-center mt-3 mt-md-0 d-flex flex-column align-items-md-end align-items-center">
                            <div class="mb-1">
                                <span class="text-dark fw-bold fs-8">LKR</span><br class="d-none d-md-block">
                                <span class="fw-bold fs-6">105,500.00</span>
                            </div>
                            <button class="btn text-muted p-0 mt-2 hover-danger"><i class="bi bi-trash-fill fs-5"></i></button>
                        </div>
                    </div>
                </div>

                <a href="products.jsp" class="btn btn-link text-primary text-decoration-none fw-medium ps-0 mb-4 d-inline-flex align-items-center gap-2">
                    <i class="bi bi-arrow-left"></i> Continue Shopping
                </a>

            </div>

            <!-- Order Summary Sidebar -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-4">Order Summary</h5>
                    
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted fs-7">Subtotal</span>
                        <span class="text-dark fw-medium fs-7">LKR 470,500.00</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted fs-7">Discount</span>
                        <span class="text-success fw-medium fs-7">-LKR 0.00</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted fs-7">Shipping</span>
                        <span class="text-dark fw-medium fs-7">Free</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4 pb-4 border-bottom">
                        <span class="text-muted fs-7">Tax</span>
                        <span class="text-muted fs-8 fst-italic">Calculated at checkout</span>
                    </div>

                    <div class="mb-4">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-lg bg-light border-0 fs-7" placeholder="Promo Code">
                            <button class="btn btn-light bg-light text-primary fw-medium border-0 px-3 fs-7" type="button">Apply</button>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="text-dark fw-bold">Total</span>
                        <span class="text-dark fw-bolder fs-4">LKR 470,500.00</span>
                    </div>

                    <button class="btn btn-primary w-100 py-3 rounded-3 fw-bold fs-6 mb-4 d-flex justify-content-center align-items-center gap-2 shadow-sm">
                        Proceed to Checkout <i class="bi bi-arrow-right"></i>
                    </button>

                    <div class="d-flex justify-content-center align-items-center gap-3 mb-4 text-muted fs-8 fw-medium">
                        <span class="d-flex align-items-center gap-1"><i class="bi bi-lock-fill"></i> Secure Payment</span>
                        <span>•</span>
                        <span class="d-flex align-items-center gap-1"><i class="bi bi-patch-check-fill"></i> 30-Day Returns</span>
                    </div>

                    <div class="d-flex justify-content-center gap-2">
                        <div class="bg-secondary bg-opacity-25 rounded" style="width: 40px; height: 24px;"></div>
                        <div class="bg-secondary bg-opacity-25 rounded" style="width: 40px; height: 24px;"></div>
                        <div class="bg-secondary bg-opacity-25 rounded" style="width: 40px; height: 24px;"></div>
                        <div class="bg-secondary bg-opacity-25 rounded" style="width: 40px; height: 24px;"></div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Simplified Footer -->
    <footer class="bg-light border-top py-4 mt-auto">
        <div class="container text-center">
            <p class="text-muted fs-7 mb-0">&copy; 2024 ElectroZone. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
