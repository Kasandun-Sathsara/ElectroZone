<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Manage Customers</title>
    
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
                    <span class="sidebar-brand-subtitle text-muted small d-block" style="font-size: 0.75rem;">Admin Console</span>
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

        
        <main class="admin-main">
            
            
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

            
            <div class="row g-4">
                
                
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-blue">Total Customers</span>
                            <span class="stat-value" id="stat-total-customers">0</span>
                        </div>
                        <div class="stat-icon icon-bg-blue">
                            <i class="bi bi-people-fill"></i>
                        </div>
                    </div>
                </div>

                
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-teal">Active Members</span>
                            <span class="stat-value" id="stat-active-members">0</span>
                        </div>
                        <div class="stat-icon icon-bg-green">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                </div>

                
                <div class="col-md-4">
                    <div class="stat-card shadow-sm">
                        <div class="stat-content">
                            <span class="stat-label label-purple">New This Month</span>
                            <span class="stat-value" id="stat-new-this-month">0</span>
                        </div>
                        <div class="stat-icon icon-bg-purple">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>
                    </div>
                </div>

            </div>

            
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
                            
                        </tbody>
                    </table>
                </div>
                
                
                <div class="table-footer flex-column flex-sm-row gap-3">
                    <div class="showing-text">
                        Showing <strong>All</strong> customers
                    </div>
                </div>
            </div>

            
            <div class="page-footer">
                &copy; 2024 ElectroZone Inc. All rights reserved.
            </div>

        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="../assets/js/admin-customers.js"></script>
</body>
</html>
