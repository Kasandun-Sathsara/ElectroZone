<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body class="admin-page-body">

    <div class="admin-layout">
        
        
        <aside class="admin-sidebar">
            <a href="../index.jsp" class="sidebar-brand">
                <div class="sidebar-brand-icon shadow-sm" style="background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center;">
                    <i class="bi bi-lightning-fill text-white fs-5"></i>
                </div>
                <div class="sidebar-brand-text ms-2">
                    <span class="sidebar-brand-title fw-bold text-dark fs-5">Electro<span class="text-primary">Zone</span></span>
                    <span class="sidebar-brand-subtitle text-muted small d-block" style="font-size: 0.75rem;">Admin Panel</span>
                </div>
            </a>

            <nav class="sidebar-nav mt-3">
                <a href="dashboard.jsp" class="sidebar-link active">
                    <i class="bi bi-grid-fill"></i> Dashboard
                </a>
                <a href="products.jsp" class="sidebar-link">
                    <i class="bi bi-box-seam"></i> Products
                </a>
                <a href="orders.jsp" class="sidebar-link">
                    <i class="bi bi-cart3"></i> Orders
                </a>
                <a href="customers.jsp" class="sidebar-link">
                    <i class="bi bi-people"></i> Customers
                </a>
            </nav>

            <div class="sidebar-footer">
                <a href="#" class="sidebar-link px-0 text-muted">
                    <i class="bi bi-gear"></i> Settings
                </a>
                
                <div class="user-profile">
                    <div class="user-avatar" style="background-image: url('https://ui-avatars.com/api/?name=Alex+Morgan&background=fca5a5&color=991b1b'); background-size: cover;"></div>
                    <div class="user-info">
                        <span class="user-name">Alex Morgan</span>
                        <span class="user-role">Super Admin</span>
                    </div>
                </div>
            </div>
        </aside>

        
        <main class="admin-main">
            
            
            <header class="admin-header">
                <h1 class="admin-page-title">Dashboard Overview</h1>
                
                <div class="admin-header-actions">
                    <div class="admin-search-wrapper">
                        <i class="bi bi-search admin-search-icon"></i>
                        <input type="text" class="admin-search-input" placeholder="Search...">
                    </div>
                    <a href="#" class="btn-notification">
                        <i class="bi bi-bell-fill"></i>
                    </a>
                </div>
            </header>

            
            <div class="row g-4 mb-4">
                
                <div class="col-sm-6 col-xl-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon-wrapper icon-blue">
                                <i class="bi bi-cash-stack"></i>
                            </div>
                            <span class="trend-badge trend-up">
                                <i class="bi bi-arrow-up-right"></i> +12.5%
                            </span>
                        </div>
                        <div class="stat-label">Total Revenue</div>
                        <h2 class="stat-value" id="stat-revenue">LKR 0.00</h2>
                    </div>
                </div>

                <div class="col-sm-6 col-xl-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon-wrapper icon-purple">
                                <i class="bi bi-bag-check-fill"></i>
                            </div>
                            <span class="trend-badge trend-up">
                                <i class="bi bi-arrow-up-right"></i> +5.2%
                            </span>
                        </div>
                        <div class="stat-label">Total Orders</div>
                        <h2 class="stat-value" id="stat-orders">0</h2>
                    </div>
                </div>

                <div class="col-sm-6 col-xl-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon-wrapper icon-orange">
                                <i class="bi bi-box-fill"></i>
                            </div>
                            <span class="trend-badge trend-up">
                                <i class="bi bi-arrow-up-right"></i> +2.1%
                            </span>
                        </div>
                        <div class="stat-label">Total Products</div>
                        <h2 class="stat-value" id="stat-products">0</h2>
                    </div>
                </div>

                <div class="col-sm-6 col-xl-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="stat-icon-wrapper icon-pink">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            <span class="trend-badge trend-up">
                                <i class="bi bi-arrow-up-right"></i> +8.4%
                            </span>
                        </div>
                        <div class="stat-label">Total Customers</div>
                        <h2 class="stat-value" id="stat-customers">0</h2>
                    </div>
                </div>

            </div>

            
            <div class="row g-4 mb-4">
                
                
                <div class="col-xl-8">
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <h2 class="admin-card-title">Recent Orders</h2>
                            <a href="#" class="admin-card-link">View All</a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th class="th-total">Total</th>
                                    </tr>
                                </thead>
                                <tbody id="recent-orders-tbody">
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                
                <div class="col-xl-4">
                    <div class="admin-card d-flex flex-column">
                        <div class="admin-card-header">
                            <h2 class="admin-card-title">Low Stock Alerts</h2>
                            <a href="#" class="admin-card-link text-muted">See All</a>
                        </div>
                        
                        <div class="flex-grow-1" id="low-stock-container">
                            
                        </div>

                        <button class="btn-restock">
                            <i class="bi bi-cart-plus"></i> Create Restock Order
                        </button>
                    </div>
                </div>

            </div>

        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="../assets/js/admin-dashboard.js"></script>
</body>
</html>
