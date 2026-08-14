<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Order Invoice</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }
        .invoice-card-wrapper {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
            border: 1px solid #e2e8f0;
            padding: 40px;
            max-width: 900px;
            margin: 0 auto;
        }
        .status-badge-paid {
            background-color: #10b981;
            color: #ffffff;
            font-size: 0.85rem;
            font-weight: 700;
            padding: 6px 18px;
            border-radius: 50px;
            letter-spacing: 0.5px;
            display: inline-block;
        }
        .invoice-items-table {
            width: 100%;
            margin-bottom: 1.5rem;
        }
        .invoice-items-table th {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 16px;
            border: none;
        }
        .invoice-items-table td {
            padding: 14px 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            font-size: 0.95rem;
        }
        .order-summary-box {
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 20px;
        }
        .success-alert-box {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            border-radius: 12px;
            padding: 18px 24px;
            max-width: 900px;
            margin: 0 auto 24px auto;
        }
        @media print {
            .no-print, nav, footer { display: none !important; }
            .invoice-card-wrapper { box-shadow: none !important; border: none !important; padding: 0 !important; }
            body { background: #fff !important; }
        }
    </style>
</head>
<body style="min-height: 100vh; display: flex; flex-direction: column;">

    <!-- Navbar -->
    <jsp:include page="include/header.jsp"/>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">

        <!-- Success Banner -->
        <div class="success-alert-box d-flex align-items-center gap-3 no-print">
            <i class="bi bi-check-circle-fill text-success fs-3"></i>
            <div>
                <h5 class="fw-bold mb-0 text-success">Payment Completed Successfully!</h5>
                <p class="mb-0 text-muted small">Your order has been confirmed. Below is your official bill & invoice.</p>
            </div>
        </div>

        <!-- Invoice Card -->
        <div class="invoice-card-wrapper">
            <!-- Header Section -->
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-start pb-4 mb-4 border-bottom">
                <div class="mb-3 mb-sm-0">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-lightning-charge-fill fs-2 text-primary"></i>
                        <span class="fw-bolder fs-3 text-dark">ElectroZone</span>
                    </div>
                    <p class="text-muted mb-0 small">Tax Invoice / Official Bill of Supply</p>
                </div>
                <div class="text-sm-end">
                    <h3 class="fw-bolder mb-1 text-dark">INVOICE</h3>
                    <div class="fw-bold fs-5 text-primary mb-1" id="invoice-no">#---</div>
                    <div class="text-muted small mb-2" id="invoice-date">---</div>
                    <span class="status-badge-paid" id="invoice-status">PAID</span>
                </div>
            </div>

            <!-- Customer & Merchant Details -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6">
                    <div class="p-3 bg-light rounded-3 h-100 border">
                        <div class="text-uppercase fw-bold text-muted small mb-2">Customer Details (Billed To)</div>
                        <h6 class="fw-bold mb-1 text-dark" id="buyer-name">---</h6>
                        <p class="text-muted small mb-1" id="buyer-address">---</p>
                        <p class="text-muted small mb-1"><span id="city-name">---</span>, <span id="country-name">Sri Lanka</span></p>
                        <p class="text-primary small mb-0 fw-semibold" id="buyer-email">---</p>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="p-3 bg-light rounded-3 h-100 text-sm-end border">
                        <div class="text-uppercase fw-bold text-muted small mb-2">Merchant Details (From)</div>
                        <h6 class="fw-bold mb-1 text-dark">ElectroZone (PVT) LTD</h6>
                        <p class="text-muted small mb-1">No 45, Galle Road, Colombo 03</p>
                        <p class="text-muted small mb-1">Western Province, Sri Lanka</p>
                        <p class="text-muted small mb-0">info@electrozone.lk | +94 11 234 5678</p>
                    </div>
                </div>
            </div>

            <!-- Items Table -->
            <div class="table-responsive mb-4">
                <table class="table invoice-items-table">
                    <thead>
                        <tr>
                            <th style="width: 8%;">#</th>
                            <th style="width: 47%;">Product Details</th>
                            <th class="text-center" style="width: 15%;">Quantity</th>
                            <th class="text-end" style="width: 15%;">Unit Price</th>
                            <th class="text-end" style="width: 15%;">Line Total</th>
                        </tr>
                    </thead>
                    <tbody id="item-tbody">
                        <tr>
                            <td colspan="5" class="text-center py-4 text-muted">
                                <div class="spinner-border spinner-border-sm text-primary me-2" role="status"></div>
                                Loading invoice items...
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Totals Section -->
            <div class="row justify-content-end mb-4">
                <div class="col-md-6 col-lg-5">
                    <div class="order-summary-box">
                        <div class="d-flex justify-content-between mb-2 small text-muted">
                            <span>Subtotal</span>
                            <span class="fw-bold text-dark">Rs. <span id="subtotal">0.00</span></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2 small text-muted">
                            <span>Shipping & Delivery</span>
                            <span class="fw-bold text-dark">Rs. <span id="shipping-charges">0.00</span></span>
                        </div>
                        <hr class="my-2 text-muted">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold fs-6 text-dark">Grand Total</span>
                            <span class="fw-bolder fs-5 text-primary">Rs. <span id="total">0.00</span></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex flex-wrap justify-content-between align-items-center pt-3 border-top no-print gap-2">
                <a href="index.jsp" class="btn btn-outline-secondary rounded-pill px-4 btn-sm">
                    <i class="bi bi-arrow-left me-1"></i> Continue Shopping
                </a>
                <div class="d-flex gap-2">
                    <button onclick="window.print()" class="btn btn-outline-primary rounded-pill px-4 btn-sm">
                        <i class="bi bi-printer me-1"></i> Print Invoice
                    </button>
                    <a href="my-account.jsp" class="btn btn-primary rounded-pill px-4 btn-sm">
                        <i class="bi bi-person me-1"></i> My Account
                    </a>
                </div>
            </div>
        </div>

        <div class="text-center mt-4 text-muted small no-print">
            Thank you for shopping with <b>ElectroZone</b>!
        </div>

    </main>

    <!-- Footer -->
    <footer class="bg-white border-top py-3 mt-auto no-print">
        <div class="container text-center text-muted small">
            &copy; 2026 ElectroZone (PVT) LTD. All Rights Reserved.
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/invoice.js?v=7"></script>
</body>
</html>
