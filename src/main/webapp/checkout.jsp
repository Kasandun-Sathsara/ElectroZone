<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Checkout</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="checkout-page-body">

    <!-- Minimalist Navbar -->
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top">
        <div class="container d-flex justify-content-between align-items-center">
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center m-0" href="index.jsp">
                <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 28px; height: 28px; border-radius: 6px;">
                    <i class="bi bi-lightning-fill text-white fs-6"></i>
                </div>
                <span class="fw-bold fs-5 tracking-tight text-dark">ElectroZone</span>
            </a>

            <!-- Breadcrumbs -->
            <div class="d-none d-md-flex align-items-center fs-7">
                <a href="cart.jsp" class="text-primary text-decoration-none fw-medium">Cart</a>
                <i class="bi bi-chevron-right text-muted mx-2" style="font-size: 0.7rem;"></i>
                <span class="text-primary fw-bold">Checkout</span>
                <i class="bi bi-chevron-right text-muted mx-2" style="font-size: 0.7rem;"></i>
                <span class="text-muted fw-medium">Confirmation</span>
            </div>

            <!-- Secure Badge -->
            <div class="bg-light rounded-pill px-3 py-2 d-flex align-items-center text-dark fs-8 fw-medium border">
                <i class="bi bi-lock-fill text-primary me-2"></i> Secure Checkout
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-5">
        
        <div class="mb-4">
            <h1 class="fw-bolder display-6 mb-1">Checkout</h1>
            <p class="text-muted fs-6">Complete your order details below.</p>
        </div>

        <div class="row g-5">
            
            <!-- Left Column: Forms -->
            <div class="col-lg-7">
                
                <!-- Step 1: Contact Information -->
                <div class="card border-0 shadow-sm rounded-4 mb-4 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="d-flex align-items-center gap-2">
                            <span class="step-circle">1</span>
                            <h5 class="fw-bold mb-0">Contact Information</h5>
                        </div>
                        <a href="login.jsp" class="text-primary text-decoration-none fw-medium fs-7">Log in</a>
                    </div>
                    
                    <div class="mb-3">
                        <label class="checkout-label">Email address</label>
                        <input type="email" class="form-control checkout-input" placeholder="you@example.com">
                    </div>
                    <div>
                        <label class="checkout-label">Phone number</label>
                        <input type="tel" class="form-control checkout-input" placeholder="+94 77 123 4567">
                    </div>
                </div>

                <!-- Step 2: Shipping Address -->
                <div class="card border-0 shadow-sm rounded-4 mb-4 p-4">
                    <div class="d-flex align-items-center gap-2 mb-4">
                        <span class="step-circle">2</span>
                        <h5 class="fw-bold mb-0">Shipping Address</h5>
                    </div>
                    
                    <div class="row g-3 mb-3">
                        <div class="col-sm-6">
                            <label class="checkout-label">First name</label>
                            <input type="text" class="form-control checkout-input" placeholder="Saman">
                        </div>
                        <div class="col-sm-6">
                            <label class="checkout-label">Last name</label>
                            <input type="text" class="form-control checkout-input" placeholder="Perera">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="checkout-label">Address</label>
                        <input type="text" class="form-control checkout-input" placeholder="123 Galle Road">
                    </div>
                    <div class="mb-3">
                        <label class="checkout-label">Apartment, suite, etc. (optional)</label>
                        <input type="text" class="form-control checkout-input" placeholder="Apt 4B">
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-5">
                            <label class="checkout-label">City</label>
                            <input type="text" class="form-control checkout-input" placeholder="Colombo">
                        </div>
                        <div class="col-sm-4">
                            <label class="checkout-label">Country</label>
                            <select class="form-select checkout-input text-dark">
                                <option selected>Sri Lanka</option>
                                <option>United States</option>
                                <option>United Kingdom</option>
                                <option>Australia</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label class="checkout-label">Postal Code</label>
                            <input type="text" class="form-control checkout-input" placeholder="00100">
                        </div>
                    </div>
                </div>

                <!-- Step 3: Payment Method -->
                <div class="card border-0 shadow-sm rounded-4 mb-4 p-4">
                    <div class="d-flex align-items-center gap-2 mb-4">
                        <span class="step-circle">3</span>
                        <h5 class="fw-bold mb-0">Payment Method</h5>
                    </div>
                    
                    <div class="payment-box active mb-3">
                        <label class="payment-option mb-0">
                            <input type="radio" name="paymentMethod" class="custom-radio-input" checked>
                            <i class="bi bi-credit-card-2-front-fill text-primary payment-icon"></i>
                            <span class="fw-bold fs-7">Credit Card</span>
                            <div class="ms-auto">
                                <span class="mock-card-icon"></span>
                                <span class="mock-card-icon"></span>
                            </div>
                        </label>
                        <div class="payment-option-content">
                            <div class="mb-3">
                                <label class="checkout-label text-primary" style="opacity: 0.8;">Card number</label>
                                <input type="text" class="form-control checkout-input bg-white" placeholder="0000 0000 0000 0000">
                            </div>
                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <label class="checkout-label text-primary" style="opacity: 0.8;">Expiration (MM/YY)</label>
                                    <input type="text" class="form-control checkout-input bg-white" placeholder="MM / YY">
                                </div>
                                <div class="col-sm-6">
                                    <label class="checkout-label text-primary" style="opacity: 0.8;">CVC</label>
                                    <input type="text" class="form-control checkout-input bg-white" placeholder="123">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="payment-box mb-3">
                        <label class="payment-option mb-0">
                            <input type="radio" name="paymentMethod" class="custom-radio-input">
                            <i class="bi bi-cash-stack payment-icon"></i>
                            <span class="fw-bold fs-7 text-dark">Cash on Delivery</span>
                        </label>
                    </div>

                    <div class="payment-box">
                        <label class="payment-option mb-0">
                            <input type="radio" name="paymentMethod" class="custom-radio-input">
                            <i class="bi bi-bank payment-icon"></i>
                            <span class="fw-bold fs-7 text-dark">Bank Transfer</span>
                        </label>
                    </div>

                </div>

            </div>

            <!-- Right Column: Order Summary Sidebar -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-4">Order Summary</h5>
                    
                    <!-- Item 1 -->
                    <div class="d-flex align-items-center mb-4 pb-2 border-bottom border-light">
                        <div class="item-thumbnail me-3">
                            <img src="assets/img/iphone_15_pro_max_1780590648972.png" alt="UltraPhone X1" class="img-fluid mix-blend-multiply" style="max-height: 48px;">
                            <span class="item-badge">1</span>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-bold fs-7 mb-1">UltraPhone X1</h6>
                            <p class="text-muted fs-8 mb-1">Midnight Black · 256GB</p>
                            <p class="text-muted fs-8 mb-0">Qty: 1</p>
                        </div>
                        <div class="fw-bold fs-7 text-dark">LKR 299,700</div>
                    </div>

                    <!-- Item 2 -->
                    <div class="d-flex align-items-center mb-4 pb-4 border-bottom border-light">
                        <div class="item-thumbnail item-thumbnail-2 me-3">
                            <img src="assets/img/headphones_1777403193238.png" alt="NoiseCancel Pro" class="img-fluid mix-blend-multiply" style="max-height: 48px;">
                            <span class="item-badge">1</span>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-bold fs-7 mb-1">NoiseCancel Pro</h6>
                            <p class="text-muted fs-8 mb-1">Titanium Silver</p>
                            <p class="text-muted fs-8 mb-0">Qty: 1</p>
                        </div>
                        <div class="fw-bold fs-7 text-dark">LKR 89,700</div>
                    </div>

                    <!-- Discount Code -->
                    <div class="mb-4 pb-4 border-bottom">
                        <div class="input-group">
                            <input type="text" class="form-control checkout-input bg-light border-light" placeholder="Gift card or discount code" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                            <button class="btn btn-light bg-light border-light text-secondary fw-medium px-4 fs-7" type="button" style="border-top-right-radius: 6px; border-bottom-right-radius: 6px; background-color: #e2e8f0 !important;">Apply</button>
                        </div>
                    </div>

                    <!-- Totals -->
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted fs-7">Subtotal</span>
                        <span class="text-dark fw-medium fs-7">LKR 389,400</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted fs-7">Shipping</span>
                        <span class="text-success fw-medium fs-7">Free</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4 pb-4 border-bottom">
                        <span class="text-muted fs-7">Tax (Estimated)</span>
                        <span class="text-dark fw-medium fs-7">LKR 31,152</span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="text-dark fw-bold fs-5">Total</span>
                        <div>
                            <span class="text-muted fs-8 fw-medium me-1">LKR</span>
                            <span class="text-dark fw-bolder fs-3">420,552</span>
                        </div>
                    </div>

                    <button class="btn btn-primary w-100 py-3 rounded-3 fw-bold fs-6 mb-3 d-flex justify-content-center align-items-center gap-2 shadow-sm">
                        Confirm Order <i class="bi bi-arrow-right"></i>
                    </button>

                    <div class="text-center text-muted fs-8 fw-medium">
                        <i class="bi bi-lock-fill"></i> Payments are secure and encrypted
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center">
            <p class="text-muted fs-8 mb-3 mb-md-0">&copy; 2024 ElectroZone Inc.</p>
            <div>
                <a href="#" class="footer-link-small">Refund Policy</a>
                <a href="#" class="footer-link-small">Shipping Policy</a>
                <a href="#" class="footer-link-small">Privacy Policy</a>
                <a href="#" class="footer-link-small">Terms of Service</a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple script to handle payment method selection styling
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                // Remove active class from all
                document.querySelectorAll('.payment-box').forEach(box => {
                    box.classList.remove('active');
                });
                // Add active class to selected
                if(this.checked) {
                    this.closest('.payment-box').classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
