<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - My Orders</title>
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
    <jsp:include page="include/header.jsp"/>

    <!-- Main Content -->
    <main class="container py-5">
        
        <div class="row g-5">
            
            <!-- Left Sidebar -->
            <aside class="col-lg-3 d-none d-lg-block">
                <nav class="sticky-top" style="top: 100px;">
                    <a href="my-account.jsp" class="account-sidebar-link">
                        <i class="bi bi-grid"></i> Account Overview
                    </a>
                    <a href="orders.jsp" class="account-sidebar-link active">
                        <i class="bi bi-box-seam"></i> My Orders
                    </a>
                    <a href="wishlist.jsp" class="account-sidebar-link">
                        <i class="bi bi-heart"></i> Wishlist
                    </a>
                    <a href="#" class="account-sidebar-link text-danger mt-5" onclick="logout()">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </nav>
            </aside>

            <!-- Main Orders Area -->
            <div class="col-lg-9">
                
                <!-- Header -->
                <div class="mb-4">
                    <h1 class="fw-bolder display-6 mb-1 text-dark">My Orders</h1>
                    <p class="text-muted fs-6 mb-0">Check the status of recent orders, manage returns, and discover similar products.</p>
                </div>

                <!-- Order List -->
                <div id="orders-container" class="d-flex flex-column">
                    <!-- Orders will be loaded here dynamically by orders.js -->
                </div>

            </div>
        </div>

    </main>

    <!-- Footer -->
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center">
            <p class="text-muted fs-8 mb-3 mb-md-0">&copy; 2023 ElectroZone. All rights reserved.</p>
            <div>
                <a href="#" class="text-muted text-decoration-none fs-8 ms-3 hover-dark">Privacy Policy</a>
                <a href="#" class="text-muted text-decoration-none fs-8 ms-3 hover-dark">Terms of Service</a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/orders.js"></script>
<script src="assets/js/cart.js?v=2"></script>
</body>
</html>
