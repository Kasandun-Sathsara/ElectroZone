<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Admin Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS (Scoped for Admin) -->
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body class="admin-page-body">

    <div class="admin-layout">
        
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <a href="../index.jsp" class="sidebar-brand">
                <div class="sidebar-brand-icon">
                    <i class="bi bi-lightning-fill"></i>
                </div>
                <div class="sidebar-brand-text">
                    <span class="sidebar-brand-title">ElectroZone</span>
                    <span class="sidebar-brand-subtitle">Admin Panel</span>
                </div>
            </a>

            <nav class="sidebar-nav mt-3">
                <a href="dashboard.jsp" class="sidebar-link active">
                    <i class="bi bi-grid-fill"></i> Dashboard
                </a>
                <a href="products.jsp" class="sidebar-link">
                    <i class="bi bi-box-seam"></i> Products
                </a>
                <a href="#" class="sidebar-link">
                    <i class="bi bi-cart3"></i> Orders
                </a>
                <a href="customers.jsp" class="sidebar-link">
                    <i class="bi bi-people"></i> Customers
                </a>
                <a href="#" class="sidebar-link">
                    <i class="bi bi-bar-chart"></i> Analytics
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

        <!-- Main Content -->
        <main class="admin-main">
            
            <!-- Header -->
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

            <!-- Stats Row -->
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
                        <h2 class="stat-value">$124,592.00</h2>
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
                        <h2 class="stat-value">1,245</h2>
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
                        <h2 class="stat-value">320</h2>
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
                        <h2 class="stat-value">850</h2>
                    </div>
                </div>

            </div>

            <!-- Bottom Row -->
            <div class="row g-4 mb-4">
                
                <!-- Recent Orders -->
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
                                <tbody>
                                    <tr>
                                        <td class="td-order-id">#ORD-001</td>
                                        <td>John Doe</td>
                                        <td><span class="status-pill pill-shipped">Shipped</span></td>
                                        <td>Oct 24</td>
                                        <td class="td-total">$299.00</td>
                                    </tr>
                                    <tr>
                                        <td class="td-order-id">#ORD-002</td>
                                        <td>Jane Smith</td>
                                        <td><span class="status-pill pill-pending">Pending</span></td>
                                        <td>Oct 24</td>
                                        <td class="td-total">$1,250.00</td>
                                    </tr>
                                    <tr>
                                        <td class="td-order-id">#ORD-003</td>
                                        <td>Robert Brown</td>
                                        <td><span class="status-pill pill-delivered">Delivered</span></td>
                                        <td>Oct 23</td>
                                        <td class="td-total">$85.00</td>
                                    </tr>
                                    <tr>
                                        <td class="td-order-id">#ORD-004</td>
                                        <td>Emily Davis</td>
                                        <td><span class="status-pill pill-processing">Processing</span></td>
                                        <td>Oct 23</td>
                                        <td class="td-total">$450.00</td>
                                    </tr>
                                    <tr>
                                        <td class="td-order-id">#ORD-005</td>
                                        <td>Michael Wilson</td>
                                        <td><span class="status-pill pill-cancelled">Cancelled</span></td>
                                        <td>Oct 22</td>
                                        <td class="td-total">$120.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Low Stock Alerts -->
                <div class="col-xl-4">
                    <div class="admin-card d-flex flex-column">
                        <div class="admin-card-header">
                            <h2 class="admin-card-title">Low Stock Alerts</h2>
                            <a href="#" class="admin-card-link text-muted">See All</a>
                        </div>
                        
                        <div class="flex-grow-1">
                            <!-- Alert 1 -->
                            <div class="alert-item">
                                <div class="alert-img-wrapper bg-teal">
                                    <img src="../assets/img/watch_1777403179511.png" alt="Watch">
                                </div>
                                <div class="alert-info">
                                    <h4 class="alert-title">Smart Watch<br>Series 7</h4>
                                    <p class="alert-id">ID: #PROD-248</p>
                                </div>
                                <div class="alert-status">
                                    <p class="alert-qty">2 Left</p>
                                    <p class="alert-text">Restock Soon</p>
                                </div>
                            </div>

                            <!-- Alert 2 -->
                            <div class="alert-item">
                                <div class="alert-img-wrapper bg-peach">
                                    <img src="../assets/img/headphones_1777403193238.png" alt="Headphones">
                                </div>
                                <div class="alert-info">
                                    <h4 class="alert-title">Noise Cancelling<br>Headphones</h4>
                                    <p class="alert-id">ID: #PROD-112</p>
                                </div>
                                <div class="alert-status">
                                    <p class="alert-qty">5 Left</p>
                                    <p class="alert-text">Low Stock</p>
                                </div>
                            </div>

                            <!-- Alert 3 -->
                            <div class="alert-item">
                                <div class="alert-img-wrapper bg-rose">
                                    <!-- Use a generic camera or placeholder, since camera_1780590494553.png isn't guaranteed -->
                                    <img src="https://placehold.co/100x100/ffe4e6/1e293b?text=Camera" alt="Camera">
                                </div>
                                <div class="alert-info">
                                    <h4 class="alert-title">Instax Mini 11</h4>
                                    <p class="alert-id">ID: #PROD-334</p>
                                </div>
                                <div class="alert-status">
                                    <p class="alert-qty">8 Left</p>
                                    <p class="alert-text">Low Stock</p>
                                </div>
                            </div>
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
</body>
</html>
