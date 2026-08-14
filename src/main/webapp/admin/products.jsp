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
            <a href="orders.jsp" class="sidebar-nav-link">
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
                    <button class="btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="bi bi-plus-lg"></i> Add Product
                    </button>
                </div>
            </header>

            <!-- Filter Bar -->
            <div class="filter-card">
                <div class="filter-search">
                    <i class="bi bi-search"></i>
                    <input type="text" id="searchInput" placeholder="Search by name, SKU or brand...">
                </div>
                
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-filter text-muted fs-5"></i>
                    <select class="filter-select" id="categoryFilter">
                        <option value="all">All Categories</option>
                    </select>
                </div>

                <div class="d-flex align-items-center gap-2 ms-auto">
                    <i class="bi bi-sort-down text-muted fs-5"></i>
                    <select class="filter-select" id="sortFilter">
                        <option value="newest">Newest</option>
                        <option value="price_asc">Price: Low to High</option>
                        <option value="price_desc">Price: High to Low</option>
                        <option value="stock_low">Stock: Low to High</option>
                        <option value="stock_high">Stock: High to Low</option>
                    </select>
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
                        <tbody id="admin-products-tbody">
                            <!-- Populated by JS -->
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

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" data-bs-focus="false" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addProductForm">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="productTitle" class="form-label">Product Title</label>
                                <input type="text" class="form-control" id="productTitle" name="title" required>
                            </div>
                            <div class="col-md-12">
                                <label for="productCategory" class="form-label">Category</label>
                                <div class="input-group">
                                    <select class="form-select" id="productCategory" name="categoryId" required>
                                        <option value="" disabled selected>Select Category</option>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" onclick="addNewCategory()">+</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productBrand" class="form-label">Brand</label>
                                <div class="input-group">
                                    <select class="form-select" id="productBrand" name="brandId" onchange="loadModelsForBrand()" required>
                                        <option value="" disabled selected>Select Brand</option>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" onclick="addNewBrand()">+</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productModel" class="form-label">Model</label>
                                <div class="input-group">
                                    <select class="form-select" id="productModel" name="modelId" required>
                                        <option value="" disabled selected>Select Model</option>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" onclick="addNewModel()">+</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productStorage" class="form-label">Storage</label>
                                <div class="input-group">
                                    <select class="form-select" id="productStorage" name="storageId" required>
                                        <option value="" disabled selected>Select Storage</option>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" onclick="addNewStorage()">+</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productColor" class="form-label">Color</label>
                                <div class="input-group">
                                    <select class="form-select" id="productColor" name="colorId" required>
                                        <option value="" disabled selected>Select Color</option>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" onclick="addNewColor()">+</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productPrice" class="form-label">Price (LKR)</label>
                                <input type="number" class="form-control" id="productPrice" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="col-md-6">
                                <label for="productQty" class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="productQty" name="qty" min="1" required>
                            </div>
                            <div class="col-md-12">
                                <label for="productDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="productDescription" name="description" rows="3" required></textarea>
                            </div>
                            <div class="col-md-12">
                                <label for="productImages" class="form-label">Product Images</label>
                                <input type="file" class="form-control" id="productImages" name="images[]" multiple accept="image/*" required>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="addAdminProduct()">Save Product</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div class="modal fade" id="editProductModal" data-bs-focus="false" aria-labelledby="editProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProductForm">
                        <input type="hidden" id="editProductId" name="productId">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="editProductTitle" class="form-label">Product Title</label>
                                <input type="text" class="form-control" id="editProductTitle" name="title" required>
                            </div>
                            <div class="col-md-12">
                                <label for="editProductCategory" class="form-label">Category</label>
                                <select class="form-select" id="editProductCategory" name="categoryId" required>
                                    <option value="" disabled>Select Category</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductBrand" class="form-label">Brand</label>
                                <select class="form-select" id="editProductBrand" name="brandId" onchange="loadModelsForBrandEdit()" required>
                                    <option value="" disabled>Select Brand</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductModel" class="form-label">Model</label>
                                <select class="form-select" id="editProductModel" name="modelId" required>
                                    <option value="" disabled>Select Model</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductStorage" class="form-label">Storage</label>
                                <select class="form-select" id="editProductStorage" name="storageId" required>
                                    <option value="" disabled>Select Storage</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductColor" class="form-label">Color</label>
                                <select class="form-select" id="editProductColor" name="colorId" required>
                                    <option value="" disabled>Select Color</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductPrice" class="form-label">Price (LKR)</label>
                                <input type="number" class="form-control" id="editProductPrice" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editProductQty" class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="editProductQty" name="qty" min="0" required>
                            </div>
                            <div class="col-md-12">
                                <label for="editProductDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="editProductDescription" name="description" rows="3" required></textarea>
                            </div>
                            <div class="col-md-12">
                                <label for="editProductImages" class="form-label">Append New Images (Optional)</label>
                                <input type="file" class="form-control" id="editProductImages" name="images[]" multiple accept="image/*">
                                <small class="text-muted">Leaving this blank will keep existing images.</small>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="updateAdminProduct()">Update Product</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="../assets/js/admin-products.js?v=2"></script>
</body>
</html>
