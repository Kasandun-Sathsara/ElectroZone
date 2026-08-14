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
    <jsp:include page="include/header.jsp"/>

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

                <div id="cart-item-container">
                    <!-- Cart Items will be injected here by cart.js -->
                </div>

                <div class="mt-4">
                    <a href="search.jsp" class="btn btn-outline-secondary px-4 py-2 fw-medium text-dark border-light shadow-sm hover-bg-light">
                        <i class="bi bi-arrow-left"></i> Continue Shopping
                    </a>
                </div>

            </div>

            <!-- Order Summary Sidebar -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-4">Order Summary</h5>
                    
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted fs-7">Subtotal</span>
                        <span class="text-dark fw-medium fs-7" id="order-total-amount">LKR 0.00</span>
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
                        <span class="text-dark fw-bolder fs-4" id="order-final-amount">LKR 0.00</span>
                    </div>

                    <a id="checkout-btn" href="checkout.jsp" class="btn btn-primary w-100 py-3 rounded-3 fw-bold fs-6 mb-4 d-flex justify-content-center align-items-center gap-2 shadow-sm text-white text-decoration-none">
                        Proceed to Checkout <i class="bi bi-arrow-right"></i>
                    </a>

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
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js?v=2"></script>
    <script>
        window.addEventListener('load', () => {
            loadCartItems();
        });
    </script>
</body>
</html>
