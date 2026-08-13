<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - My Wishlist</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center m-0 me-4" href="index.jsp">
                <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 32px; height: 32px; border-radius: 8px;">
                    <i class="bi bi-lightning-fill text-white fs-5"></i>
                </div>
                <span class="fw-bold fs-4 tracking-tight text-dark">ElectroZone</span>
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Links & Actions -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-2"><a class="nav-link text-dark" href="index.jsp">Home</a></li>
                    <li class="nav-item mx-2"><a class="nav-link text-muted hover-dark" href="#">Products</a></li>
                    <li class="nav-item mx-2"><a class="nav-link text-muted hover-dark" href="deals.jsp">Deals</a></li>
                    <li class="nav-item mx-2"><a class="nav-link text-muted hover-dark" href="#">Support</a></li>
                </ul>
                
                <div class="d-flex align-items-center gap-4 mt-3 mt-lg-0">
                    <!-- Search Bar -->
                    <div class="position-relative d-none d-lg-block" style="width: 300px;">
                        <i class="bi bi-search" style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #6c757d;"></i>
                        <input type="text" class="form-control rounded-pill bg-light border-0 ps-5" placeholder="Search products...">
                    </div>

                    <a href="cart.jsp" class="text-dark position-relative d-flex align-items-center justify-content-center hover-primary">
                        <i class="bi bi-cart3 fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary" style="font-size: 0.6rem;">
                            2
                        </span>
                    </a>
                    
                    <a href="login.jsp" class="text-dark hover-primary">
                        <i class="bi bi-person-circle fs-5"></i>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container py-5">
        
        <!-- Header -->
        <div class="wishlist-header d-flex justify-content-between align-items-end">
            <div>
                <h1 class="fw-bolder display-6 mb-1 text-dark">My Wishlist</h1>
                <p class="text-muted fs-6 mb-0" id="wishlist-count-text">0 items saved for later</p>
            </div>
            <button class="btn-clear-all d-flex align-items-center gap-2 shadow-sm" onclick="clearWishlist()">
                <i class="bi bi-trash"></i> Clear All
            </button>
        </div>

        <!-- Wishlist Grid -->
        <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4 mb-5" id="wishlist-container">
            <!-- Items will be injected here by wishlist.js -->
        </div>
                <div class="wishlist-card">
                    <div class="wishlist-img-wrapper" style="background-color: #e5e9ec;">
                        <img src="assets/img/watch_1777403179511.png" alt="Smart Watch" class="mix-blend-multiply">
                        <button class="btn-delete-item" aria-label="Remove item"><i class="bi bi-trash-fill"></i></button>
                        <span class="stock-badge badge-instock">In Stock</span>
                    </div>
                    <div class="wishlist-body">
                        <h3 class="product-title">ElectroZone Smart Watch Series 7 - Midnight Aluminum</h3>
                        <div class="mt-auto">
                            <div class="d-flex align-items-end">
                                <span class="price-current">$399.00</span>
                                <span class="price-old">$429.00</span>
                            </div>
                            <div class="card-divider"></div>
                            <button class="btn-action btn-add-cart shadow-sm">
                                <i class="bi bi-cart-plus fs-5"></i> Move to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js"></script>
    <script src="assets/js/wishlist.js"></script>
</body>
</html>
