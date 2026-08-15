<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Order Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body class="admin-page-body">

    
    <nav class="admin-navbar">
        <a href="../index.jsp" class="navbar-brand-custom d-flex align-items-center gap-2 text-decoration-none">
            <div class="brand-icon shadow-sm" style="background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); width: 34px; height: 34px; border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-lightning-fill text-white fs-6"></i>
            </div>
            <span class="navbar-brand-text fw-bold text-dark fs-5 mb-0">Electro<span class="text-primary">Zone</span> <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill fs-8 ms-1">Admin</span></span>
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
                    <i class="bi bi-gear"></i> Settings
                </div>
            </a>

            
            <div class="pro-plan-card">
                <div class="pro-plan-title">Pro Plan</div>
                <div class="pro-plan-text">Your subscription renews on Nov 1st.</div>
                <button class="btn-manage-plan">Manage Plan</button>
            </div>
            
        </aside>

        
        <main class="admin-main">
            
            <div class="admin-breadcrumbs">
                <a href="#">Home</a>
                <i class="bi bi-chevron-right" style="font-size: 0.7rem;"></i>
                <span class="breadcrumb-current">Orders</span>
            </div>

            
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

            
            <div class="filter-card">
                <div class="filter-search w-100 mb-2 mb-md-0 me-md-3">
                    <i class="bi bi-search"></i>
                    <input type="text" id="order-search-input" placeholder="Search by Customer Name or Invoice No..." onkeyup="filterOrders()">
                </div>
                
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-filter text-muted fs-5"></i>
                    <select class="filter-select" id="order-status-filter" onchange="filterOrders()">
                        <option value="">All Statuses</option>
                        <option value="PENDING">Pending</option>
                        <option value="PACKING">Packing</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="DELIVERED">Delivered</option>
                        <option value="CANCELED">Canceled</option>
                    </select>
                </div>
            </div>

            
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
                            
                        </tbody>
                    </table>
                </div>
                
                
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
