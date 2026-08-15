<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - My Wishlist</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    
    <jsp:include page="include/header.jsp"/>

    
    <main class="container py-5">
        <div class="row g-5">
            
            <aside class="col-lg-3 d-none d-lg-block">
                <nav class="sticky-top" style="top: 100px;">
                    <a href="my-account.jsp" class="account-sidebar-link">
                        <i class="bi bi-grid"></i> Account Overview
                    </a>
                    <a href="orders.jsp" class="account-sidebar-link">
                        <i class="bi bi-box-seam"></i> My Orders
                    </a>
                    <a href="wishlist.jsp" class="account-sidebar-link active">
                        <i class="bi bi-heart"></i> Wishlist
                    </a>
                    <a href="#" class="account-sidebar-link text-danger mt-5" onclick="logout()">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </nav>
            </aside>

            
            <div class="col-lg-9">
                
                <div class="wishlist-header d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 border-bottom pb-3">
                    <div>
                        <h1 class="fw-bolder display-6 mb-1 text-dark">My Wishlist</h1>
                        <p class="text-muted fs-6 mb-0" id="wishlist-count-text">Loading...</p>
                    </div>
                    <button class="btn btn-outline-danger d-flex align-items-center gap-2 mt-3 mt-md-0 shadow-sm" onclick="clearWishlist()">
                        <i class="bi bi-trash"></i> Clear All
                    </button>
                </div>

                
                <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-4 mb-5" id="wishlist-container">
                    
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js?v=2"></script>
    <script src="assets/js/wishlist.js"></script>
</body>
</html>
