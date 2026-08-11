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
                    <li class="nav-item mx-2"><a class="nav-link text-dark" href="#">Home</a></li>
                    <li class="nav-item mx-2"><a class="nav-link text-muted hover-dark" href="#">Products</a></li>
                    <li class="nav-item mx-2"><a class="nav-link text-muted hover-dark" href="#">Deals</a></li>
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
                    </a>
                    
                    <a href="#" class="text-dark hover-primary d-flex align-items-center gap-1 text-decoration-none">
                        <i class="bi bi-person-circle fs-5"></i>
                        <i class="bi bi-chevron-down fs-8"></i>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container py-5">
        
        <div class="row g-5">
            
            <!-- Left Sidebar -->
            <aside class="col-lg-3 d-none d-lg-block">
                <nav class="sticky-top" style="top: 100px;">
                    <a href="#" class="account-sidebar-link">
                        <i class="bi bi-grid"></i> Account Overview
                    </a>
                    <a href="#" class="account-sidebar-link active">
                        <i class="bi bi-box-seam"></i> My Orders
                    </a>
                    <a href="wishlist.jsp" class="account-sidebar-link">
                        <i class="bi bi-heart"></i> Wishlist
                    </a>
                    <a href="#" class="account-sidebar-link">
                        <i class="bi bi-chat-left-text"></i> My Reviews
                    </a>
                    <a href="#" class="account-sidebar-link">
                        <i class="bi bi-gear"></i> Settings
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

                <!-- Filter Bar -->
                <div class="card border-0 shadow-sm rounded-3 p-3 mb-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                    
                    <div class="d-flex flex-grow-1 gap-3 flex-column flex-sm-row">
                        <div class="filter-input-group d-flex align-items-center flex-grow-1" style="max-width: 400px;">
                            <i class="bi bi-search text-muted ms-2 me-1"></i>
                            <input type="text" class="form-control filter-search-input" placeholder="Search by Order ID or Product Name">
                        </div>
                        <select class="form-select filter-select" style="width: auto; min-width: 150px;">
                            <option selected>Last 30 days</option>
                            <option>Past 6 months</option>
                            <option>2023</option>
                            <option>2022</option>
                        </select>
                    </div>

                    <div class="d-flex gap-1 overflow-auto">
                        <a href="#" class="status-tab active">All Orders</a>
                        <a href="#" class="status-tab">Open</a>
                        <a href="#" class="status-tab">Cancelled</a>
                    </div>
                </div>

                <!-- Order List -->
                <div class="d-flex flex-column">
                    
                    <!-- Order Card 1: Delivered -->
                    <div class="order-card shadow-sm">
                        <div class="order-header">
                            <div class="d-flex gap-4 flex-wrap">
                                <div>
                                    <div class="order-meta-label">Order Placed</div>
                                    <div class="order-meta-value">Oct 24, 2023</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Total</div>
                                    <div class="order-meta-value">$348.00</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Order ID</div>
                                    <div class="order-meta-value"><a href="#" class="text-primary text-decoration-none hover-dark">#44921</a></div>
                                </div>
                            </div>
                            <div class="mt-2 mt-md-0">
                                <a href="#" class="item-action-link">View Invoice</a>
                            </div>
                        </div>
                        <div class="order-body">
                            <div class="d-flex align-items-center gap-3 mb-4">
                                <h5 class="fw-bold mb-0 text-dark">Delivered Oct 26</h5>
                                <span class="status-badge status-delivered"><i class="bi bi-check-circle-fill"></i> Delivered</span>
                            </div>

                            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-4">
                                <!-- Items -->
                                <div class="d-flex gap-3 flex-grow-1">
                                    <div class="order-item-img">
                                        <img src="assets/img/headphones_1777403193238.png" alt="Headphones">
                                    </div>
                                    <div>
                                        <h6 class="fw-bold fs-7 mb-1 text-dark">Sony WH-1000XM5 Wireless Noise Canceling Headphones</h6>
                                        <p class="text-muted fs-8 mb-2">Silver · Quantity: 1</p>
                                        <div>
                                            <a href="#" class="item-action-link">Buy again</a>
                                            <span class="action-divider">|</span>
                                            <a href="#" class="item-action-link text-muted">Write a review</a>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Actions -->
                                <div class="action-buttons-container d-flex flex-column align-items-md-end">
                                    <button class="btn btn-primary btn-order-action">Track Package</button>
                                    <button class="btn btn-outline-secondary border-light text-dark btn-order-action mb-0 hover-bg-light">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Card 2: Shipped -->
                    <div class="order-card shadow-sm">
                        <div class="order-header">
                            <div class="d-flex gap-4 flex-wrap">
                                <div>
                                    <div class="order-meta-label">Order Placed</div>
                                    <div class="order-meta-value">Nov 02, 2023</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Total</div>
                                    <div class="order-meta-value">$1,299.00</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Order ID</div>
                                    <div class="order-meta-value"><a href="#" class="text-primary text-decoration-none hover-dark">#45002</a></div>
                                </div>
                            </div>
                            <div class="mt-2 mt-md-0">
                                <a href="#" class="item-action-link">View Invoice</a>
                            </div>
                        </div>
                        <div class="order-body">
                            <div class="d-flex align-items-center gap-3 mb-4">
                                <h5 class="fw-bold mb-0 text-dark">Arriving Tomorrow by 8 PM</h5>
                                <span class="status-badge status-shipped"><i class="bi bi-truck"></i> Shipped</span>
                            </div>

                            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-4">
                                <!-- Items -->
                                <div class="d-flex gap-3 flex-grow-1">
                                    <div class="order-item-img" style="background-color: #f8fafc;">
                                        <img src="https://placehold.co/400x300/e2e8f0/334155?text=Monitor" alt="Monitor">
                                    </div>
                                    <div>
                                        <h6 class="fw-bold fs-7 mb-1 text-dark">Dell UltraSharp 27 4K USB-C Hub Monitor - U2723QE</h6>
                                        <p class="text-muted fs-8 mb-2">Black · Quantity: 1</p>
                                        <div>
                                            <a href="#" class="item-action-link">Product Support</a>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Actions -->
                                <div class="action-buttons-container d-flex flex-column align-items-md-end">
                                    <button class="btn btn-primary btn-order-action">Track Package</button>
                                    <button class="btn btn-outline-secondary border-light text-dark btn-order-action mb-0 hover-bg-light">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Card 3: Processing (Multiple Items) -->
                    <div class="order-card shadow-sm">
                        <div class="order-header">
                            <div class="d-flex gap-4 flex-wrap">
                                <div>
                                    <div class="order-meta-label">Order Placed</div>
                                    <div class="order-meta-value">Nov 03, 2023</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Total</div>
                                    <div class="order-meta-value">$89.98</div>
                                </div>
                                <div>
                                    <div class="order-meta-label">Order ID</div>
                                    <div class="order-meta-value"><a href="#" class="text-primary text-decoration-none hover-dark">#45110</a></div>
                                </div>
                            </div>
                            <div class="mt-2 mt-md-0">
                                <a href="#" class="item-action-link">View Invoice</a>
                            </div>
                        </div>
                        <div class="order-body">
                            <div class="d-flex align-items-center gap-3 mb-4">
                                <h5 class="fw-bold mb-0 text-dark">Preparing for Shipment</h5>
                                <span class="status-badge status-processing"><i class="bi bi-box-seam"></i> Processing</span>
                            </div>

                            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-4">
                                <!-- Items Container -->
                                <div class="d-flex flex-column gap-4 flex-grow-1">
                                    
                                    <!-- Item 1 -->
                                    <div class="d-flex gap-3">
                                        <div class="order-item-img" style="background-color: #1e293b;">
                                            <img src="https://placehold.co/200x200/334155/94a3b8?text=Cable" alt="Cable">
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <h6 class="fw-bold fs-7 mb-0 text-dark">Anker 6ft Premium Nylon USB-C Cable</h6>
                                        </div>
                                    </div>

                                    <!-- Item 2 -->
                                    <div class="d-flex gap-3">
                                        <div class="order-item-img" style="background-color: #fdf6e3;">
                                            <img src="https://placehold.co/200x200/e3ccba/1e293b?text=Case" alt="Case">
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <h6 class="fw-bold fs-7 mb-0 text-dark">Spigen Ultra Hybrid Case for Pixel 8</h6>
                                        </div>
                                    </div>
                                    
                                </div>
                                
                                <!-- Actions -->
                                <div class="action-buttons-container d-flex flex-column align-items-md-end">
                                    <button class="btn btn-primary btn-order-action">Track Package</button>
                                    <button class="btn btn-outline-secondary border-light text-dark btn-order-action hover-bg-light">View Details</button>
                                    <a href="#" class="item-action-link text-danger mt-2">Cancel Order</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Pagination -->
                <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-4">
                    <button class="btn btn-white border shadow-sm text-dark fw-medium px-3 py-2 d-flex align-items-center gap-2">
                        <i class="bi bi-arrow-left"></i> Previous
                    </button>
                    
                    <nav aria-label="Page navigation">
                        <ul class="pagination mb-0 gap-2">
                            <li class="page-item active" aria-current="page">
                                <a class="page-link rounded bg-primary text-white border-primary shadow-sm px-3 fw-medium" href="#">1</a>
                            </li>
                            <li class="page-item d-none d-sm-block">
                                <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">2</a>
                            </li>
                            <li class="page-item d-none d-sm-block">
                                <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">3</a>
                            </li>
                            <li class="page-item disabled d-none d-sm-block">
                                <span class="page-link border-0 bg-transparent text-muted px-2">...</span>
                            </li>
                            <li class="page-item d-none d-sm-block">
                                <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">8</a>
                            </li>
                        </ul>
                    </nav>

                    <button class="btn btn-white border shadow-sm text-dark fw-medium px-4 py-2 d-flex align-items-center gap-2">
                        Next <i class="bi bi-arrow-right"></i>
                    </button>
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
</body>
</html>
