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
                <a href="#" class="sidebar-link">
                    <i class="bi bi-bag-fill"></i> Orders
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
                        <input type="text" placeholder="Search by name, email, or phone...">
                    </div>
                    
                    <select class="form-select filter-select shadow-sm">
                        <option>Status: All</option>
                        <option>Status: Active</option>
                        <option>Status: Blocked</option>
                    </select>
                </div>
                
                <div class="action-group-right">
                    <button class="btn-outline-custom">
                        <i class="bi bi-download"></i> Export
                    </button>
                    <button class="btn-primary-custom">
                        <i class="bi bi-plus-lg"></i> Add Customer
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
                        <tbody>
                            <!-- Row 1 -->
                            <tr>
                                <td>
                                    <img src="https://ui-avatars.com/api/?name=Alex+Johnson&background=1e293b&color=fff" alt="Profile" class="customer-profile-img">
                                </td>
                                <td>
                                    <p class="customer-name">Alex Johnson</p>
                                    <p class="customer-id">ID: #CUS-00921</p>
                                </td>
                                <td>
                                    <div class="contact-line">
                                        <i class="bi bi-envelope-fill"></i> alex.j@example.com
                                    </div>
                                    <div class="contact-line">
                                        <i class="bi bi-telephone-fill"></i> +1 (555) 010-9988
                                    </div>
                                </td>
                                <td class="join-date">Oct 24, 2023</td>
                                <td>
                                    <span class="status-pill pill-active"><span class="dot"></span> Active</span>
                                </td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-eye-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-slash-circle-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 2 -->
                            <tr>
                                <td>
                                    <img src="https://ui-avatars.com/api/?name=Maria+Garcia&background=ea580c&color=fff" alt="Profile" class="customer-profile-img">
                                </td>
                                <td>
                                    <p class="customer-name">Maria Garcia</p>
                                    <p class="customer-id">ID: #CUS-00922</p>
                                </td>
                                <td>
                                    <div class="contact-line">
                                        <i class="bi bi-envelope-fill"></i> m.garcia@email.com
                                    </div>
                                    <div class="contact-line">
                                        <i class="bi bi-telephone-fill"></i> +1 (555) 012-3456
                                    </div>
                                </td>
                                <td class="join-date">Sep 15, 2023</td>
                                <td>
                                    <span class="status-pill pill-blocked"><span class="dot"></span> Blocked</span>
                                </td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-eye-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn unblock"><i class="bi bi-check-circle-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 3 -->
                            <tr>
                                <td>
                                    <img src="https://ui-avatars.com/api/?name=David+Smith&background=d97706&color=fff" alt="Profile" class="customer-profile-img">
                                </td>
                                <td>
                                    <p class="customer-name">David Smith</p>
                                    <p class="customer-id">ID: #CUS-00923</p>
                                </td>
                                <td>
                                    <div class="contact-line">
                                        <i class="bi bi-envelope-fill"></i> d.smith@test.com
                                    </div>
                                    <div class="contact-line">
                                        <i class="bi bi-telephone-fill"></i> +1 (555) 123-4567
                                    </div>
                                </td>
                                <td class="join-date">Aug 30, 2023</td>
                                <td>
                                    <span class="status-pill pill-active"><span class="dot"></span> Active</span>
                                </td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-eye-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-slash-circle-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 4 -->
                            <tr>
                                <td>
                                    <img src="https://ui-avatars.com/api/?name=Emily+Davis&background=fb923c&color=fff" alt="Profile" class="customer-profile-img">
                                </td>
                                <td>
                                    <p class="customer-name">Emily Davis</p>
                                    <p class="customer-id">ID: #CUS-00924</p>
                                </td>
                                <td>
                                    <div class="contact-line">
                                        <i class="bi bi-envelope-fill"></i> emily.d@site.com
                                    </div>
                                    <div class="contact-line">
                                        <i class="bi bi-telephone-fill"></i> +1 (555) 987-6543
                                    </div>
                                </td>
                                <td class="join-date">Aug 12, 2023</td>
                                <td>
                                    <span class="status-pill pill-active"><span class="dot"></span> Active</span>
                                </td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-eye-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-slash-circle-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 5 -->
                            <tr>
                                <td>
                                    <img src="https://ui-avatars.com/api/?name=Chris+Wilson&background=0f172a&color=fff" alt="Profile" class="customer-profile-img">
                                </td>
                                <td>
                                    <p class="customer-name">Chris Wilson</p>
                                    <p class="customer-id">ID: #CUS-00925</p>
                                </td>
                                <td>
                                    <div class="contact-line">
                                        <i class="bi bi-envelope-fill"></i> chris.w@mail.com
                                    </div>
                                    <div class="contact-line">
                                        <i class="bi bi-telephone-fill"></i> +1 (555) 456-7890
                                    </div>
                                </td>
                                <td class="join-date">Jul 05, 2023</td>
                                <td>
                                    <span class="status-pill pill-active"><span class="dot"></span> Active</span>
                                </td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-eye-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn"><i class="bi bi-slash-circle-fill"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <!-- Table Footer / Pagination -->
                <div class="table-footer flex-column flex-sm-row gap-3">
                    <div class="showing-text">
                        Showing <strong>1</strong> to <strong>5</strong> of <strong>97</strong> results
                    </div>
                    <div class="pagination-controls">
                        <a href="#" class="page-btn disabled" aria-label="Previous"><i class="bi bi-chevron-left"></i></a>
                        <a href="#" class="page-btn active">1</a>
                        <a href="#" class="page-btn">2</a>
                        <a href="#" class="page-btn">3</a>
                        <span class="page-dots">...</span>
                        <a href="#" class="page-btn" style="width: auto; padding: 0 0.5rem;">20</a>
                        <a href="#" class="page-btn" aria-label="Next"><i class="bi bi-chevron-right"></i></a>
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
</body>
</html>
