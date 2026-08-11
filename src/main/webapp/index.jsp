<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Home</title>
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
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top">
        <div class="container">
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center" href="#">
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
                    <input type="text" class="form-control rounded-pill search-input w-100" placeholder="Search for products, brands and more">
                </div>

                <!-- Navigation Links -->
                <ul class="navbar-nav mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="#">Home</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Categories</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Deals</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="#">Support</a>
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
        
        <!-- Hero Section -->
        <section class="hero-section mb-5" style="background-image: url('assets/img/hero_bg_1777403135954.png');">
            <div class="p-5 p-md-5 hero-content text-white">
                <div class="col-md-7 col-lg-6 p-3 p-md-4">
                    <span class="badge bg-primary bg-opacity-25 text-info rounded-pill px-3 py-2 mb-3 fw-bold fs-8 border border-info border-opacity-25">
                        <i class="bi bi-fire me-1"></i> HOT DEAL
                    </span>
                    <h1 class="display-4 fw-bolder mb-3">
                        New Zenith X5<br>
                        <span style="color: #9f7aea;">Smartphone</span>
                    </h1>
                    <p class="fs-5 mb-4 text-light-muted pe-md-4">
                        Experience the future with 20% off for a limited time. Stunning display, all-day battery, and pro-grade cameras.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="btn btn-primary btn-lg rounded-pill px-4 fw-bold shadow-sm">Shop Now <i class="bi bi-arrow-right ms-1"></i></a>
                        <a href="#" class="btn btn-outline-light btn-lg rounded-pill px-4 fw-bold">View Specs</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Browse by Category -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">Browse by Category</h3>
                <div>
                    <a href="#" class="slider-btn me-2"><i class="bi bi-chevron-left fs-6"></i></a>
                    <a href="#" class="slider-btn"><i class="bi bi-chevron-right fs-6"></i></a>
                </div>
            </div>
            
            <div class="row g-2 text-center text-md-start flex-nowrap overflow-auto hide-scrollbar pb-3">
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-laptop"></i>
                        </div>
                        <span class="fw-medium fs-7">Laptops</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-phone"></i>
                        </div>
                        <span class="fw-medium fs-7">Phones</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-headphones"></i>
                        </div>
                        <span class="fw-medium fs-7">Audio</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-camera"></i>
                        </div>
                        <span class="fw-medium fs-7">Cameras</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-controller"></i>
                        </div>
                        <span class="fw-medium fs-7">Gaming</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-smartwatch"></i>
                        </div>
                        <span class="fw-medium fs-7">Wearables</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="#" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-house-door"></i>
                        </div>
                        <span class="fw-medium fs-7">Smart Home</span>
                    </a>
                </div>
            </div>
        </section>

        <!-- Best Sellers -->
        <section class="mb-5 pb-3">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">Best Sellers</h3>
                <a href="#" class="text-decoration-none fw-bold link-primary fs-7">View All <i class="bi bi-arrow-right"></i></a>
            </div>

            <div class="row g-4">
                <!-- Product 1 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white">
                        <div class="product-img-wrapper">
                            <span class="product-badge bg-danger text-white">-15%</span>
                            <button class="like-btn"><i class="bi bi-heart-fill text-muted"></i></button>
                            <img src="assets/img/watch_1777403179511.png" alt="Chronos Smart Watch" class="img-fluid">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                <span class="fw-bold fs-8">4.8</span>
                                <span class="text-muted fs-8 ms-1">(124)</span>
                            </div>
                            <h5 class="fs-6 fw-bold mb-3 text-dark lh-base" style="height: 48px; overflow: hidden;">Chronos Smart Watch Series 7 Midnight</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="text-muted text-decoration-line-through fs-8">LKR 99,000</div>
                                    <div class="fw-bold fs-5 text-dark">LKR 84,150</div>
                                </div>
                                <button class="add-to-cart-btn"><i class="bi bi-cart-plus fs-5"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white">
                        <div class="product-img-wrapper" style="background-color: #f1f2f6;">
                            <button class="like-btn"><i class="bi bi-heart-fill text-muted"></i></button>
                            <img src="assets/img/headphones_1777403193238.png" alt="SonicBlast Headphones" class="img-fluid">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                <span class="fw-bold fs-8">4.9</span>
                                <span class="text-muted fs-8 ms-1">(850)</span>
                            </div>
                            <h5 class="fs-6 fw-bold mb-3 text-dark lh-base" style="height: 48px; overflow: hidden;">SonicBlast Pro Wireless Noise Cancelling Headphones</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 65,500</div>
                                </div>
                                <button class="add-to-cart-btn"><i class="bi bi-cart-plus fs-5"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white">
                        <div class="product-img-wrapper" style="background-color: #f8f9fa;">
                            <span class="product-badge bg-primary text-white">NEW</span>
                            <button class="like-btn"><i class="bi bi-heart-fill text-muted"></i></button>
                            <img src="assets/img/laptop_1777403253050.png" alt="UltraBook Pro 14" class="img-fluid">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                <span class="fw-bold fs-8">4.7</span>
                                <span class="text-muted fs-8 ms-1">(42)</span>
                            </div>
                            <h5 class="fs-6 fw-bold mb-3 text-dark lh-base" style="height: 48px; overflow: hidden;">UltraBook Pro 14" M2 Chip 512GB SSD</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 429,990</div>
                                </div>
                                <button class="add-to-cart-btn"><i class="bi bi-cart-plus fs-5"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col-sm-6 col-lg-3">
                    <div class="product-card h-100 bg-white">
                        <div class="product-img-wrapper">
                            <button class="like-btn"><i class="bi bi-heart-fill text-muted"></i></button>
                            <img src="assets/img/earbuds_1777403268133.png" alt="AeroBuds" class="img-fluid">
                        </div>
                        <div class="p-4 d-flex flex-column" style="height: calc(100% - 250px);">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-star-fill text-warning fs-8 me-1"></i>
                                <span class="fw-bold fs-8">4.6</span>
                                <span class="text-muted fs-8 ms-1">(210)</span>
                            </div>
                            <h5 class="fs-6 fw-bold mb-3 text-dark lh-base" style="height: 48px; overflow: hidden;">AeroBuds True Wireless Earbuds</h5>
                            <div class="d-flex justify-content-between align-items-end mt-auto">
                                <div>
                                    <div class="fw-bold fs-5 text-dark">LKR 26,450</div>
                                </div>
                                <button class="add-to-cart-btn"><i class="bi bi-cart-plus fs-5"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Twin Banners -->
        <section class="row g-4 mb-5 pb-3">
            <div class="col-md-6">
                <div class="promo-banner promo-banner-vr">
                    <div class="promo-content">
                        <h2 class="fw-bold mb-2 text-dark">VR Headsets</h2>
                        <p class="text-muted mb-4 pe-md-4">Immerse yourself in new worlds.</p>
                        <a href="#" class="text-decoration-none fw-bold link-primary">Shop Collection <i class="bi bi-arrow-right ms-1"></i></a>
                    </div>
                    <img src="assets/img/vr_headset_1777403554263.png" alt="VR Headset">
                </div>
            </div>
            <div class="col-md-6">
                <div class="promo-banner promo-banner-gaming">
                    <div class="promo-content">
                        <h2 class="fw-bold mb-2 text-dark">Gaming Consoles</h2>
                        <p class="text-muted mb-4 pe-md-4">Next-gen performance is here.</p>
                        <a href="#" class="text-decoration-none fw-bold link-primary">Shop Collection <i class="bi bi-arrow-right ms-1"></i></a>
                    </div>
                    <!-- Fallback icon instead of image -->
                    <div class="position-absolute end-0 top-50 translate-middle-y pe-4" style="z-index: 1;">
                        <i class="bi bi-controller text-dark opacity-25" style="font-size: 14rem;"></i>
                    </div>
                </div>
            </div>
        </section>

        <!-- Newsletter -->
        <section class="mb-5">
            <div class="newsletter-section">
                <div class="row align-items-center">
                    <div class="col-md-5 mb-4 mb-md-0 text-center text-md-start ps-md-4">
                        <div class="newsletter-icon mx-auto mx-md-0">
                            <i class="bi bi-envelope"></i>
                        </div>
                        <h2 class="fw-bold mb-2">Stay Plugged In</h2>
                        <p class="text-muted pe-md-4">Get the latest tech news, exclusive deals, and new arrivals delivered straight to your inbox.</p>
                    </div>
                    <div class="col-md-7 pe-md-4">
                        <form class="d-flex flex-column flex-sm-row gap-3">
                            <input type="email" class="form-control form-control-lg bg-white border flex-grow-1" placeholder="Enter your email address" style="padding-left: 1.25rem;">
                            <button class="btn btn-primary btn-lg fw-bold px-4 shadow-sm" type="submit">Subscribe</button>
                        </form>
                        <div class="text-muted fs-8 mt-3 text-center text-md-start">We respect your privacy. Unsubscribe at any time.</div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <!-- Footer -->
    <footer class="bg-white mt-auto pt-5">
        <div class="container footer-top">
            <div class="row g-4">
                <div class="col-lg-4 pe-lg-5">
                    <div class="brand mb-4 d-flex align-items-center">
                        <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 32px; height: 32px; border-radius: 8px;">
                            <i class="bi bi-lightning-fill text-white fs-6"></i>
                        </div>
                        <h4 class="mb-0 fw-bold tracking-tight text-dark">ElectroZone</h4>
                    </div>
                    <p class="text-muted fs-7 mb-4">
                        Your one-stop destination for the latest electronics and gadgets. We bring the future to your doorstep with premium quality and unbeatable prices.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-muted text-decoration-none fs-5"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-muted text-decoration-none fs-5"><i class="bi bi-twitter-x"></i></a>
                        <a href="#" class="text-muted text-decoration-none fs-5"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
                
                <div class="col-6 col-sm-4 col-lg-2">
                    <h6 class="fw-bold mb-4 text-dark">Shop</h6>
                    <a href="#" class="footer-link">New Arrivals</a>
                    <a href="#" class="footer-link">Best Sellers</a>
                    <a href="#" class="footer-link">Laptops & Computers</a>
                    <a href="#" class="footer-link">Smartphones</a>
                    <a href="#" class="footer-link">Audio & Headphones</a>
                </div>

                <div class="col-6 col-sm-4 col-lg-2">
                    <h6 class="fw-bold mb-4 text-dark">Support</h6>
                    <a href="#" class="footer-link">Help Center</a>
                    <a href="#" class="footer-link">Order Status</a>
                    <a href="#" class="footer-link">Returns & Warranty</a>
                    <a href="#" class="footer-link">Contact Us</a>
                    <a href="#" class="footer-link">Shipping Info</a>
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
                <p class="text-muted fs-8 mb-2 mb-md-0">&copy; 2024 ElectroZone. All rights reserved.</p>
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
