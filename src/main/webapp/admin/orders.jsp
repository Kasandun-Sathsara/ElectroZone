<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Order Management</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body class="admin-page-body">

    <!-- Top Navbar -->
    <nav class="admin-navbar">
        <a href="../index.jsp" class="navbar-brand-custom">
            <i class="bi bi-lightning-fill navbar-brand-icon"></i>
            <span class="navbar-brand-text">ElectroZone Admin</span>
        </a>

        <div class="d-flex align-items-center flex-grow-1 ms-4 justify-content-end gap-4">
            
            <div class="navbar-search d-none d-md-block">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search...">
            </div>

            <div class="navbar-actions">
                <button class="nav-icon-btn"><i class="bi bi-bell"></i></button>
                <button class="nav-icon-btn"><i class="bi bi-gear"></i></button>
                <div class="user-avatar-small">
                    <i class="bi bi-person-fill"></i>
                </div>
            </div>
            
        </div>
    </nav>

    <div class="admin-layout">
        
        <!-- Light Sidebar -->
        <aside class="admin-sidebar-light">
            
            <div class="sidebar-group-label">Main Menu</div>
            <a href="dashboard.jsp" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-grid"></i> Dashboard
                </div>
            </a>
            <a href="products.jsp" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-box-seam"></i> Products
                </div>
            </a>
            <a href="orders.jsp" class="sidebar-nav-link active">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-cart3"></i> Orders
                </div>
            </a>
            <a href="customers.jsp" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-people"></i> Customers
                </div>
            </a>

            <div class="sidebar-group-label mt-4">Management</div>
            <a href="#" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-bar-chart"></i> Analytics
                </div>
            </a>
            <a href="#" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-gear"></i> Settings
                </div>
            </a>

            <!-- Pro Plan Promo -->
            <div class="pro-plan-card">
                <div class="pro-plan-title">Pro Plan</div>
                <div class="pro-plan-text">Your subscription renews on Nov 1st.</div>
                <button class="btn-manage-plan">Manage Plan</button>
            </div>
            
        </aside>

        <!-- Main Content -->
        <main class="admin-main">
            
            <div class="admin-breadcrumbs">
                <a href="#">Home</a>
                <i class="bi bi-chevron-right" style="font-size: 0.7rem;"></i>
                <span class="breadcrumb-current">Orders</span>
            </div>

            <!-- Page Header -->
            <header class="page-header flex-column flex-md-row">
                <div class="mb-3 mb-md-0">
                    <h1 class="page-title">Order Management</h1>
                    <p class="page-subtitle">Manage customer orders and update their status.</p>
                </div>
                <div class="header-actions">
                    <button class="btn-outline-custom">
                        <i class="bi bi-download"></i> Export
                    </button>
                </div>
            </header>

            <!-- Filter Bar -->
            <div class="filter-card">
                <div class="filter-search">
                    <i class="bi bi-search"></i>
                    <input type="text" placeholder="Search by name, SKU or brand...">
                </div>
                
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-filter text-muted fs-5"></i>
                    <select class="filter-select">
                        <option>All Categories</option>
                        <option>Laptops</option>
                        <option>Wearables</option>
                    </select>
                </div>

                <div class="filter-tags-group">
                    <span class="filter-tag">Stock: Low (3)</span>
                    <span class="filter-tag">Status: Active</span>
                    <span class="filter-tag">Price: High to Low</span>
                </div>
            </div>

            <!-- Product Table Card -->
            <div class="table-card shadow-sm mb-4">
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer Name</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-orders-tbody">
                            <!-- Populated by JS -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Table Footer / Pagination -->
                <div class="table-footer flex-column flex-sm-row gap-3">
                    <div class="showing-text">
                        Showing all orders
                    </div>
                </div>
            </div>

        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="../assets/js/admin-orders.js"></script>
</body>
</html>
