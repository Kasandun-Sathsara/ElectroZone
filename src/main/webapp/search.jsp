<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Search</title>
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
    <jsp:include page="include/header.jsp"/>

    <!-- Main Content -->
    <main class="container pb-5">
        
        <!-- Hero Search Section -->
        <section class="search-hero">
            <h1 class="display-5 fw-bolder text-dark mb-2">Find Your Gear</h1>
            <p class="text-muted fs-5 mb-4">Search across thousands of electronics with precision.</p>
            
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-8">
                    <div class="position-relative">
                        <i class="bi bi-search search-icon-large"></i>
                        <input type="text" class="form-control main-search-input" value="Gaming Laptop">
                        <button class="btn btn-primary btn-search-large shadow-sm">Search</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter Bar -->
        <div class="card filter-bar-card bg-white p-3 mb-4 shadow-sm">
            <div class="row g-3 border-bottom pb-3 mb-3">
                <div class="col-md-4 col-lg">
                    <label class="filter-label">Category</label>
                    <select class="form-select filter-select" id="filter-category" onchange="searchProduct(0)">
                        <option value="">All Categories</option>
                    </select>
                </div>
                <div class="col-md-4 col-lg">
                    <label class="filter-label">Brand</label>
                    <select class="form-select filter-select" id="filter-brand" onchange="searchProduct(0)">
                        <option value="">All Brands</option>
                    </select>
                </div>
                <div class="col-md-4 col-lg">
                    <label class="filter-label">Condition</label>
                    <select class="form-select filter-select" id="filter-condition" onchange="searchProduct(0)">
                        <option value="">All Conditions</option>
                    </select>
                </div>
                <div class="col-md-6 col-lg">
                    <label class="filter-label">Color</label>
                    <select class="form-select filter-select" id="filter-color" onchange="searchProduct(0)">
                        <option value="">All Colors</option>
                    </select>
                </div>
                <div class="col-md-6 col-lg">
                    <label class="filter-label">Storage</label>
                    <select class="form-select filter-select" id="filter-storage" onchange="searchProduct(0)">
                        <option value="">All Storages</option>
                    </select>
                </div>
            </div>
            
            <!-- Active Filters -->
            <div class="d-flex flex-wrap justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2 flex-wrap">
                    <span class="text-muted fs-8 fw-medium me-2">Active Filters:</span>
                    <span class="active-filter-chip">Laptops <i class="bi bi-x"></i></span>
                    <span class="active-filter-chip">In Stock <i class="bi bi-x"></i></span>
                </div>
                <a href="#" class="text-muted text-decoration-underline fs-8 hover-dark mt-2 mt-md-0">Clear All Filters</a>
            </div>
        </div>

        <!-- Results Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-4">
            <h5 class="fw-bold text-dark mb-0 d-flex align-items-end gap-2">
                142 Results Found <span class="text-muted fs-6 fw-normal">for "Gaming Laptop"</span>
            </h5>
            
            <div class="d-flex align-items-center gap-3 mt-3 mt-md-0">
                <div class="input-group input-group-sm" style="width: 200px;">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-sort-down"></i></span>
                    <select class="form-select border-start-0 ps-0 text-dark fw-medium focus-ring focus-ring-light shadow-none" id="sort-select" onchange="searchProduct(0)">
                        <option value="1" selected>Relevance</option>
                        <option value="2">Price: Low to High</option>
                        <option value="3">Price: High to Low</option>
                        <option value="4">Newest Arrivals</option>
                    </select>
                </div>
                
                <div class="btn-group border bg-white rounded-2 overflow-hidden shadow-sm" role="group">
                    <button type="button" class="btn btn-white btn-sm text-dark px-2 active border-end" style="background-color: #f8fafc;"><i class="bi bi-list fs-5"></i></button>
                    <button type="button" class="btn btn-white btn-sm text-muted px-2 hover-bg-light"><i class="bi bi-grid-fill fs-6"></i></button>
                </div>
            </div>
        </div>

        <!-- Product List -->
        <div class="d-flex flex-column gap-4" id="search-results-container">
            <!-- Results injected via search.js -->
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-5 mb-3">
            <nav aria-label="Search results pages">
                <ul class="pagination gap-2">
                    <li class="page-item disabled">
                        <a class="page-link rounded bg-white text-muted border border-light shadow-sm px-3" href="#" tabindex="-1" aria-disabled="true"><i class="bi bi-chevron-left"></i></a>
                    </li>
                    <li class="page-item active" aria-current="page">
                        <a class="page-link rounded bg-primary text-white border-primary shadow-sm px-3 fw-medium" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">3</a>
                    </li>
                    <li class="page-item disabled">
                        <span class="page-link border-0 bg-transparent text-muted px-2">...</span>
                    </li>
                    <li class="page-item">
                        <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 fw-medium hover-bg-light" href="#">12</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link rounded bg-white text-dark border border-light shadow-sm px-3 hover-bg-light" href="#"><i class="bi bi-chevron-right"></i></a>
                    </li>
                </ul>
            </nav>
        </div>

    </main>

    <!-- Footer -->
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container text-center">
            <p class="text-muted fs-7 mb-0">&copy; 2024 ElectroZone. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/cart.js"></script>
    <script src="assets/js/search.js"></script>
</body>
</html>
