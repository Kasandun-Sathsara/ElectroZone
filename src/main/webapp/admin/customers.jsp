<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Manage Customers</title>
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

    <div class="admin-layout">
        
        <!-- Light Sidebar -->
        <aside class="admin-sidebar">
            
            <a href="../index.jsp" class="sidebar-brand">
                <div class="sidebar-brand-icon shadow-sm">
                    <i class="bi bi-lightning-fill"></i>
                </div>
                <div class="sidebar-brand-text">
                    <span class="sidebar-brand-title">ElectroZone</span>
                    <span class="sidebar-brand-subtitle">Admin Console</span>
                </div>
            </a>

            <nav class="sidebar-nav mt-2">
                <a href="dashboard.jsp" class="sidebar-link">
                    <i class="bi bi-pie-chart-fill"></i> Dashboard
                </a>
                <a href="products.jsp" class="sidebar-link">
                    <i class="bi bi-box-seam-fill"></i> Products
                </a>
                <a href="orders.jsp" class="sidebar-link">
                    <i class="bi bi-cart3"></i> Orders
                </a>
                <a href="customers.jsp" class="sidebar-link active">
                    <i class="bi bi-people-fill"></i> Customers
                </a>
                <a href="#" class="sidebar-link">
                    <i class="bi bi-bar-chart-fill"></i> Analytics
                </a>

                <div class="sidebar-divider"></div>
                
                <a href="#" class="sidebar-link">
                    <i class="bi bi-gear-fill"></i> Settings
                </a>
            </nav>

            <div class="sidebar-footer">
                <div class="user-profile">
                    <div class="user-avatar-wrapper">
                        <div class="user-avatar" style="background-image: url('https://ui-avatars.com/api/?name=Admin+User&background=fcd34d&color=b45309');"></div>
                        <div class="online-dot"></div>
                    </div>
                    <div class="user-info">
                        <span class="user-name">Admin User</span>
                        <span class="user-email">admin@electro.zone</span>
                    </div>
                </div>
            </div>
            
        </aside>

        <!-- Main Content -->
        <main class="admin-main">
            
            <!-- Page Header -->
            <header class="admin-header">
                <h1 class="admin-page-title">Manage Customers</h1>
                
                <div class="header-actions">
                    <button class="icon-btn-header">
                        <i class="bi bi-bell-fill"></i>
                        <span class="notification-dot"></span>
                    </button>
                    <button class="icon-btn-header">
                        <i class="bi bi-question-circle-fill help-icon"></i>
                    </button>
                </div>
            </header>

            <!-- Stats Row -->
            <div class="row g-4">
                
                <!-- Stat 1 -->
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-blue">Total Customers</span>
                            <span class="stat-value">24,582</span>
                        </div>
                        <div class="stat-icon icon-bg-blue">
                            <i class="bi bi-people-fill"></i>
                        </div>
                    </div>
                </div>

                <!-- Stat 2 -->
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-teal">Active Members</span>
                            <span class="stat-value">23,901</span>
                        </div>
                        <div class="stat-icon icon-bg-green">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                </div>

                <!-- Stat 3 -->
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-purple">New This Month</span>
                            <span class="stat-value">+843</span>
                        </div>
                        <div class="stat-icon icon-bg-purple">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Filter & Action Bar -->
            <div class="filter-action-bar">
                
                <div class="filter-group-left">
                    <div class="search-input-wrapper">
                        <i class="bi bi-search"></i>
                        <input type="text" id="customer-search-input" placeholder="Search by name, email, or phone..." onkeyup="filterCustomers()">
                    </div>
                    
                    <select class="form-select filter-select shadow-sm" id="customer-status-filter" onchange="filterCustomers()">
                        <option value="">Status: All</option>
                        <option value="ACTIVE">Status: Active</option>
                        <option value="BLOCKED">Status: Blocked</option>
                    </select>
                </div>
                
                <div class="action-group-right">
                    <button class="btn-outline-custom">
                        <i class="bi bi-download"></i> Export
                    </button>
                </div>
                
            </div>

            <!-- Data Table Card -->
            <div class="table-card shadow-sm">
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Profile</th>
                                <th>Customer Name</th>
                                <th>Contact Info</th>
                                <th>Join Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-customers-tbody">
                            <!-- Customers will be loaded dynamically -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Table Footer / Pagination -->
                <div class="table-footer flex-column flex-sm-row gap-3">
                    <div class="showing-text">
                        Showing <strong>All</strong> customers
                    </div>
                </div>
            </div>

            <!-- Page Footer -->
            <div class="page-footer">
                &copy; 2024 ElectroZone Inc. All rights reserved.
            </div>

        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/notiflix-3.2.6.min.js"></script>
    <script src="../assets/js/admin-customers.js"></script>
</body>
</html>
