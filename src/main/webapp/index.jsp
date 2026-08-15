<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Home</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    
    <jsp:include page="include/header.jsp"/>

    
    <main class="container my-4">
        
        
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
                    <a href="products.jsp?q=Laptop" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-laptop"></i>
                        </div>
                        <span class="fw-medium fs-7">Laptops</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Phone" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-phone"></i>
                        </div>
                        <span class="fw-medium fs-7">Phones</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Audio" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-headphones"></i>
                        </div>
                        <span class="fw-medium fs-7">Audio</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Camera" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-camera"></i>
                        </div>
                        <span class="fw-medium fs-7">Cameras</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Gaming" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-controller"></i>
                        </div>
                        <span class="fw-medium fs-7">Gaming</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Wearable" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-smartwatch"></i>
                        </div>
                        <span class="fw-medium fs-7">Wearables</span>
                    </a>
                </div>
                <div class="col-auto">
                    <a href="products.jsp?q=Smart" class="category-item px-3">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-house-door"></i>
                        </div>
                        <span class="fw-medium fs-7">Smart Home</span>
                    </a>
                </div>
            </div>
        </section>

        
        <section class="mb-5 pb-3">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">Best Sellers</h3>
                <a href="products.jsp" class="text-decoration-none fw-bold link-primary fs-7">View All <i class="bi bi-arrow-right"></i></a>
            </div>

            <div class="row g-4" id="best-sellers-container">
                
            </div>
        </section>

        
        <section class="row g-4 mb-5 pb-3">
            <div class="col-md-6">
                <div class="promo-banner promo-banner-vr">
                    <div class="promo-content">
                        <h2 class="fw-bold mb-2 text-dark">VR Headsets</h2>
                        <p class="text-muted mb-4 pe-md-4">Immerse yourself in new worlds.</p>
                        <a href="products.jsp?q=VR" class="text-decoration-none fw-bold link-primary">Shop Collection <i class="bi bi-arrow-right ms-1"></i></a>
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
                    
                    <div class="position-absolute end-0 top-50 translate-middle-y pe-4" style="z-index: 1;">
                        <i class="bi bi-controller text-dark opacity-25" style="font-size: 14rem;"></i>
                    </div>
                </div>
            </div>
        </section>

        
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

    
    <footer class="bg-white mt-auto pt-5">
        <div class="container footer-top">
            <div class="row g-4">
                <div class="col-lg-4 pe-lg-5">
                    <div class="brand mb-4 d-flex align-items-center gap-2">
                        <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 34px; height: 34px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 9px;">
                            <i class="bi bi-lightning-fill text-white fs-6"></i>
                        </div>
                        <h4 class="mb-0 fw-bold tracking-tight text-dark">Electro<span class="text-primary">Zone</span></h4>
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
                    <a href="new-arrivals.jsp" class="footer-link">New Arrivals</a>
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
                <p class="text-muted fs-8 mb-0">&copy; 2023 ElectroZone Inc. All rights reserved.</p>
                <div class="d-flex gap-3 align-items-center text-muted fs-7">
                    <span><i class="bi bi-shield-check text-success me-1"></i> Secure Payments</span>
                    <span><i class="bi bi-truck text-primary me-1"></i> Island-wide Delivery</span>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js?v=2"></script>
    <script src="assets/js/index.js"></script>
</body>

</html>
