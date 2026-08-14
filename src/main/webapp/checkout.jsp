<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
    <jsp:include page="include/header.jsp"/>

    <!-- Main Content -->
    <main class="container my-5">
        
        <div class="mb-4">
            <h1 class="fw-bolder display-6 mb-1">Checkout</h1>
            <p class="text-muted fs-6">Complete your order details below.</p>
        </div>

        <form action="checkout" method="post" class="row g-5">
            
            <!-- Left Column: Forms -->
            <div class="col-lg-7">
                
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="d-flex align-items-center gap-2">
                            <span class="step-circle">1</span>
                            <h5 class="fw-bold mb-0">Contact & Shipping Information</h5>
                        </div>
                    </div>
                    
                    <div class="form-check mb-4 border p-3 rounded-3 bg-light">
                        <input class="form-check-input" type="checkbox" id="usePrimaryAddressCheckbox">
                        <label class="form-check-label fw-bold ms-2 mt-1" for="usePrimaryAddressCheckbox">
                            Use my primary saved address
                        </label>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-sm-6">
                            <label class="checkout-label">First name</label>
                            <input type="text" id="firstName" name="firstName" class="form-control checkout-input" placeholder="Saman" required>
                        </div>
                        <div class="col-sm-6">
                            <label class="checkout-label">Last name</label>
                            <input type="text" id="lastName" name="lastName" class="form-control checkout-input" placeholder="Perera" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="checkout-label">Phone number</label>
                        <input type="tel" id="mobile" name="mobile" class="form-control checkout-input" placeholder="+94 77 123 4567" required>
                    </div>
                    <div class="mb-3">
                        <label class="checkout-label">Address</label>
                        <input type="text" id="lineOne" name="address" class="form-control checkout-input" placeholder="123 Galle Road" required>
                    </div>
                    <div class="mb-3">
                        <label class="checkout-label">Apartment, suite, etc. (optional)</label>
                        <input type="text" id="lineTwo" name="apartment" class="form-control checkout-input" placeholder="Apt 4B">
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-5">
                            <label class="checkout-label">City</label>
                            <select id="citySelect" name="city" class="form-select checkout-input text-dark" required>
                                <option selected disabled value="0">Select City</option>
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <label class="checkout-label">Country</label>
                            <select name="country" class="form-select checkout-input text-dark" disabled>
                                <option selected value="Sri Lanka">Sri Lanka</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label class="checkout-label">Postal Code</label>
                            <input type="text" id="postalCode" name="postalCode" class="form-control checkout-input" placeholder="00100" required>
                        </div>
                    </div>
                </div>

                    <!-- Remove dummy payment method blocks and only show PayHere -->
                    <div class="payment-box active mb-3">
                        <label class="payment-option mb-0">
                            <input type="radio" name="paymentMethod" class="custom-radio-input" checked>
                            <i class="bi bi-credit-card-2-front-fill text-primary payment-icon"></i>
                            <span class="fw-bold fs-7">Online Payment (PayHere)</span>
                            <div class="ms-auto d-flex gap-2 align-items-center">
                                <img src="https://www.payhere.lk/downloads/images/payhere_short_banner.png" alt="PayHere" style="max-height: 30px;">
                            </div>
                        </label>
                    </div>

                </div>

            </div>

            <!-- Right Column: Order Summary Sidebar -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-4">Order Summary</h5>
                    
                    <div id="checkout-order-items">
                        <!-- Items injected via checkout.js -->
                    </div>

                    <!-- Totals -->
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted fs-7">Subtotal</span>
                        <span class="text-dark fw-medium fs-7" id="checkout-subtotal">LKR 0.00</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4 pb-4 border-bottom">
                        <span class="text-muted fs-7">Shipping</span>
                        <span class="text-success fw-medium fs-7" id="checkout-shipping">LKR 0.00</span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="text-dark fw-bold fs-5">Total</span>
                        <div>
                            <span class="text-muted fs-8 fw-medium me-1">LKR</span>
                            <span class="text-dark fw-bolder fs-3" id="checkout-total">0.00</span>
                        </div>
                    </div>

                    <button type="button" onclick="processCheckout()" class="btn btn-primary w-100 py-3 rounded-3 fw-bold fs-6 mb-3 d-flex justify-content-center align-items-center gap-2 shadow-sm">
                        Confirm & Pay <i class="bi bi-arrow-right"></i>
                    </button>

                    <div class="text-center text-muted fs-8 fw-medium">
                        <i class="bi bi-lock-fill"></i> Payments are processed securely via PayHere
                    </div>
                </div>
            </div>

        </div>

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
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <!-- PayHere Script -->
    <script type="text/javascript" src="https://www.payhere.lk/lib/payhere.js"></script>
    <script src="assets/js/checkout.js"></script>
    <script>
        // Load cities
        fetch("api/auth/load-data")
        .then(response => response.json())
        .then(data => {
            if(data.status){
                const citySelect = document.getElementById("citySelect");
                data.cities.forEach(city => {
                    citySelect.innerHTML += `<option value="${city.id}">${city.name}</option>`;
                });
            }
        });
    </script>
</body>
</html>
