<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Product Management</title>
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
            <a href="products.jsp" class="sidebar-nav-link active">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-box-seam"></i> Products
                </div>
            </a>
            <a href="#" class="sidebar-nav-link">
                <div class="sidebar-nav-link-content">
                    <i class="bi bi-cart3"></i> Orders
                </div>
                <span class="nav-badge">12</span>
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
                <span class="breadcrumb-current">Products</span>
            </div>

            <!-- Page Header -->
            <header class="page-header flex-column flex-md-row">
                <div class="mb-3 mb-md-0">
                    <h1 class="page-title">Product Management</h1>
                    <p class="page-subtitle">Manage your product catalog, inventory, and pricing.</p>
                </div>
                <div class="header-actions">
                    <button class="btn-outline-custom">
                        <i class="bi bi-download"></i> Export
                    </button>
                    <button class="btn-primary-custom">
                        <i class="bi bi-plus-lg"></i> Add Product
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
                                <th class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </th>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Product 1 -->
                            <tr>
                                <td class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </td>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img-wrapper bg-laptop">
                                            <img src="../assets/img/laptop_1777403253050.png" alt="Laptop">
                                        </div>
                                        <div class="product-info">
                                            <p class="product-name">UltraBook Pro X1</p>
                                            <p class="product-sku">SKU: EZ-LP-001</p>
                                        </div>
                                    </div>
                                </td>
                                <td>Laptops</td>
                                <td class="fw-bold text-dark">LKR 1,299.00</td>
                                <td>
                                    <div class="stock-wrapper">
                                        <p class="stock-text normal">45 in stock</p>
                                        <div class="stock-bar-container">
                                            <div class="stock-bar normal"></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="status-pill pill-active">Active</span></td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn delete"><i class="bi bi-trash-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Product 2 -->
                            <tr>
                                <td class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </td>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img-wrapper bg-watch">
                                            <img src="../assets/img/watch_1777403179511.png" alt="Watch">
                                        </div>
                                        <div class="product-info">
                                            <p class="product-name">SmartWatch Series 5</p>
                                            <p class="product-sku">SKU: EZ-SW-205</p>
                                        </div>
                                    </div>
                                </td>
                                <td>Wearables</td>
                                <td class="fw-bold text-dark">LKR 299.00</td>
                                <td>
                                    <div class="stock-wrapper">
                                        <p class="stock-text low">Low Stock (2)</p>
                                        <div class="stock-bar-container">
                                            <div class="stock-bar low"></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="status-pill pill-active">Active</span></td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn delete"><i class="bi bi-trash-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Product 3 -->
                            <tr>
                                <td class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </td>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img-wrapper bg-headphones">
                                            <img src="../assets/img/headphones_1777403193238.png" alt="Headphones">
                                        </div>
                                        <div class="product-info">
                                            <p class="product-name">SonicBoom Headphones</p>
                                            <p class="product-sku">SKU: EZ-AU-512</p>
                                        </div>
                                    </div>
                                </td>
                                <td>Audio</td>
                                <td class="fw-bold text-dark">LKR 199.50</td>
                                <td>
                                    <div class="stock-wrapper">
                                        <p class="stock-text normal">120 in stock</p>
                                        <div class="stock-bar-container">
                                            <div class="stock-bar normal" style="width: 80%;"></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="status-pill pill-draft">Draft</span></td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn delete"><i class="bi bi-trash-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Product 4 -->
                            <tr>
                                <td class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </td>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img-wrapper bg-tablet">
                                            <img src="https://placehold.co/100x100/fed7aa/ea580c?text=Tab" alt="Tablet">
                                        </div>
                                        <div class="product-info">
                                            <p class="product-name">PadPro 11"</p>
                                            <p class="product-sku">SKU: EZ-TB-900</p>
                                        </div>
                                    </div>
                                </td>
                                <td>Tablets</td>
                                <td class="fw-bold text-dark">LKR 799.00</td>
                                <td>
                                    <div class="stock-wrapper">
                                        <p class="stock-text out">Out of Stock</p>
                                        <div class="stock-bar-container">
                                            <div class="stock-bar out"></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="status-pill pill-inactive">Inactive</span></td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn delete"><i class="bi bi-trash-fill"></i></button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Product 5 -->
                            <tr>
                                <td class="checkbox-cell">
                                    <input class="form-check-input" type="checkbox">
                                </td>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img-wrapper bg-phone">
                                            <img src="../assets/img/iphone_15_black_1780590662560.png" alt="Phone">
                                        </div>
                                        <div class="product-info">
                                            <p class="product-name">Galaxy Edge 22</p>
                                            <p class="product-sku">SKU: EZ-PH-331</p>
                                        </div>
                                    </div>
                                </td>
                                <td>Smartphones</td>
                                <td class="fw-bold text-dark">LKR 899.00</td>
                                <td>
                                    <div class="stock-wrapper">
                                        <p class="stock-text normal">21 in stock</p>
                                        <div class="stock-bar-container">
                                            <div class="stock-bar normal" style="width: 30%;"></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="status-pill pill-active">Active</span></td>
                                <td>
                                    <div class="action-icons">
                                        <button class="action-icon-btn"><i class="bi bi-pencil-fill"></i></button>
                                        <button class="action-icon-btn delete"><i class="bi bi-trash-fill"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <!-- Table Footer / Pagination -->
                <div class="table-footer flex-column flex-sm-row gap-3">
                    <div class="showing-text">
                        Showing <strong>1</strong> to <strong>5</strong> of <strong>50</strong> products
                    </div>
                    <div class="pagination-controls">
                        <a href="#" class="page-btn disabled">Previous</a>
                        <a href="#" class="page-btn active">1</a>
                        <a href="#" class="page-btn">2</a>
                        <a href="#" class="page-btn">3</a>
                        <span class="page-dots">...</span>
                        <a href="#" class="page-btn">10</a>
                        <a href="#" class="page-btn">Next</a>
                    </div>
                </div>
            </div>

        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
