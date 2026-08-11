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
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center m-0 me-5" href="index.jsp">
                <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 32px; height: 32px; border-radius: 8px;">
                    <i class="bi bi-lightning-fill text-white fs-5"></i>
                </div>
                <span class="fw-bold fs-4 tracking-tight text-dark">ElectroZone</span>
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Links & Actions -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-3"><a class="nav-link text-muted hover-dark" href="#">Products</a></li>
                    <li class="nav-item mx-3"><a class="nav-link text-muted hover-dark" href="#">Deals</a></li>
                    <li class="nav-item mx-3"><a class="nav-link text-muted hover-dark" href="#">Support</a></li>
                </ul>
                
                <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0">
                    <a href="cart.jsp" class="btn btn-primary d-flex align-items-center gap-2 px-3 py-2 rounded-3 fw-medium">
                        <i class="bi bi-cart3"></i> Cart
                    </a>
                    <a href="login.jsp" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center border" style="width: 42px; height: 42px;">
                        <i class="bi bi-person text-muted fs-5"></i>
                    </a>
                    <div class="rounded-circle overflow-hidden bg-light border border-2 border-white shadow-sm" style="width: 42px; height: 42px;">
                        <img src="https://ui-avatars.com/api/?name=User&background=random" alt="Avatar" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
    </nav>

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
                    <select class="form-select filter-select">
                        <option selected>Laptops & Notebooks</option>
                        <option>Desktop Computers</option>
                        <option>Components</option>
                    </select>
                </div>
                <div class="col-md-4 col-lg">
                    <label class="filter-label">Brand</label>
                    <select class="form-select filter-select">
                        <option selected>All Brands</option>
                        <option>Asus</option>
                        <option>MSI</option>
                        <option>Razer</option>
                    </select>
                </div>
                <div class="col-md-4 col-lg">
                    <label class="filter-label">Price Range</label>
                    <select class="form-select filter-select">
                        <option selected>Any Price</option>
                        <option>Under $500</option>
                        <option>$500 - $1000</option>
                        <option>Over $1000</option>
                    </select>
                </div>
                <div class="col-md-6 col-lg">
                    <label class="filter-label">Condition</label>
                    <select class="form-select filter-select">
                        <option selected>New & Used</option>
                        <option>New Only</option>
                        <option>Refurbished</option>
                    </select>
                </div>
                <div class="col-md-6 col-lg">
                    <label class="filter-label">Availability</label>
                    <select class="form-select filter-select">
                        <option selected>In Stock</option>
                        <option>Include Out of Stock</option>
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
                    <select class="form-select border-start-0 ps-0 text-dark fw-medium focus-ring focus-ring-light shadow-none">
                        <option selected>Relevance</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                        <option>Newest Arrivals</option>
                    </select>
                </div>
                
                <div class="btn-group border bg-white rounded-2 overflow-hidden shadow-sm" role="group">
                    <button type="button" class="btn btn-white btn-sm text-dark px-2 active border-end" style="background-color: #f8fafc;"><i class="bi bi-list fs-5"></i></button>
                    <button type="button" class="btn btn-white btn-sm text-muted px-2 hover-bg-light"><i class="bi bi-grid-fill fs-6"></i></button>
                </div>
            </div>
        </div>

        <!-- Product List -->
        <div class="d-flex flex-column gap-4">
            
            <!-- Product 1 -->
            <div class="product-list-card shadow-sm">
                <div class="card-img-container p-0"> <!-- p-0 to let image bleed -->
                    <span class="badge-custom badge-instock">IN STOCK</span>
                    <img src="https://placehold.co/600x400/2c3e50/ecf0f1?text=Gaming+Laptop+X15" alt="Titan Pro X15">
                </div>
                <div class="card-body-wrapper">
                    <div class="flex-grow-1 pe-lg-4">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h3 class="product-title-large">Titan Pro X15 - Ultra Gaming Laptop</h3>
                            <button class="btn btn-link text-muted p-0 ms-3 hover-danger"><i class="bi bi-heart-fill fs-5"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning d-flex gap-1 fs-8 me-2">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                            </div>
                            <span class="text-muted fs-8">(124 Reviews)</span>
                        </div>
                        
                        <p class="text-muted fs-7 mb-4">
                            Experience next-gen gaming with the Titan Pro. Featuring the latest RTX 4080 GPU, 32GB DDR5 RAM, and a stunning 240Hz OLED display.
                        </p>
                        
                        <div class="d-flex flex-wrap">
                            <span class="spec-pill">Intel i9-13900K</span>
                            <span class="spec-pill">32GB RAM</span>
                            <span class="spec-pill">1TB SSD</span>
                            <span class="spec-pill">15.6" OLED</span>
                        </div>
                    </div>
                    
                    <div class="price-section text-end">
                        <div class="fw-bolder text-dark mb-1" style="font-size: 1.8rem;">$2,499.00</div>
                        <div class="text-muted text-decoration-line-through fs-7 fw-medium mb-1">$2,899.00</div>
                        <div class="text-success fw-bold fs-8 mb-4">Save $400</div>
                        <button class="btn btn-primary w-100 rounded-3 py-2 fw-bold shadow-sm d-flex justify-content-center align-items-center gap-2">
                            <i class="bi bi-cart-plus fs-5"></i> Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 2 -->
            <div class="product-list-card shadow-sm">
                <div class="card-img-container p-4 bg-white">
                    <span class="badge-custom badge-bestseller">BEST SELLER</span>
                    <img src="https://placehold.co/500x500/f8fafc/a0aec0?text=MacBook" alt="StreamBook Air 13" style="object-fit: contain;">
                </div>
                <div class="card-body-wrapper">
                    <div class="flex-grow-1 pe-lg-4">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h3 class="product-title-large">StreamBook Air 13 - Lightweight Power</h3>
                            <button class="btn btn-link text-muted p-0 ms-3 hover-danger"><i class="bi bi-heart-fill fs-5"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning d-flex gap-1 fs-8 me-2">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                            </div>
                            <span class="text-muted fs-8">(86 Reviews)</span>
                        </div>
                        
                        <p class="text-muted fs-7 mb-4">
                            Perfect for students and professionals. All-day battery life, crystal clear Retina display, and silent fanless design.
                        </p>
                        
                        <div class="d-flex flex-wrap">
                            <span class="spec-pill">M2 Chip</span>
                            <span class="spec-pill">8GB Unified</span>
                            <span class="spec-pill">256GB SSD</span>
                        </div>
                    </div>
                    
                    <div class="price-section text-end">
                        <div class="fw-bolder text-dark mb-2" style="font-size: 1.8rem;">$999.00</div>
                        <div class="text-muted fs-8 fw-medium mb-4">Free Shipping</div>
                        <button class="btn btn-primary w-100 rounded-3 py-2 fw-bold shadow-sm d-flex justify-content-center align-items-center gap-2">
                            <i class="bi bi-cart-plus fs-5"></i> Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 3 - Out of Stock -->
            <div class="product-list-card shadow-sm out-of-stock-card">
                <div class="card-img-container p-0">
                    <span class="badge-custom badge-outofstock">OUT OF STOCK</span>
                    <img src="https://placehold.co/600x400/94a3b8/cbd5e1?text=Silver+Laptop" alt="Stealth Raider 17" style="filter: grayscale(100%); opacity: 0.8;">
                </div>
                <div class="card-body-wrapper">
                    <div class="flex-grow-1 pe-lg-4">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h3 class="product-title-large text-secondary">Stealth Raider 17 - Previous Gen</h3>
                            <button class="btn btn-link text-muted p-0 ms-3"><i class="bi bi-heart fs-5"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-secondary d-flex gap-1 fs-8 me-2">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                            </div>
                            <span class="text-muted fs-8">(42 Reviews)</span>
                        </div>
                        
                        <p class="text-muted fs-7 mb-4">
                            A classic powerhouse. Reliable performance for older titles and work tasks. Limited refurbished stock available soon.
                        </p>
                        
                        <div class="d-flex flex-wrap">
                            <span class="spec-pill bg-light text-muted">RTX 3060</span>
                            <span class="spec-pill bg-light text-muted">16GB RAM</span>
                        </div>
                    </div>
                    
                    <div class="price-section text-end">
                        <div class="fw-bolder text-secondary mb-1" style="font-size: 1.8rem;">$850.00</div>
                        <div class="text-muted fs-8 fw-medium mb-4">Sold Out</div>
                        <button class="btn btn-notify w-100 rounded-3 py-2 fw-bold d-flex justify-content-center align-items-center gap-2">
                            Notify Me
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 4 -->
            <div class="product-list-card shadow-sm">
                <div class="card-img-container p-0">
                    <span class="badge-custom badge-refurbished">REFURBISHED</span>
                    <img src="https://placehold.co/600x400/1e293b/94a3b8?text=WorkStation" alt="WorkMate Pro 16">
                </div>
                <div class="card-body-wrapper">
                    <div class="flex-grow-1 pe-lg-4">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h3 class="product-title-large">WorkMate Pro 16 - Certified Refurbished</h3>
                            <button class="btn btn-link text-muted p-0 ms-3 hover-danger"><i class="bi bi-heart-fill fs-5"></i></button>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning d-flex gap-1 fs-8 me-2">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            </div>
                            <span class="text-muted fs-8">(15 Reviews)</span>
                        </div>
                        
                        <p class="text-muted fs-7 mb-4">
                            A great value for a high-performance workstation. Professionally inspected and tested to work like new. 1-Year Warranty included.
                        </p>
                        
                        <div class="d-flex flex-wrap">
                            <span class="spec-pill">Ryzen 9</span>
                            <span class="spec-pill">64GB RAM</span>
                            <span class="spec-pill">Grade A</span>
                        </div>
                    </div>
                    
                    <div class="price-section text-end">
                        <div class="fw-bolder text-dark mb-1" style="font-size: 1.8rem;">$1,150.00</div>
                        <div class="text-muted text-decoration-line-through fs-7 fw-medium mb-4">$1,500.00</div>
                        <button class="btn btn-primary w-100 rounded-3 py-2 fw-bold shadow-sm d-flex justify-content-center align-items-center gap-2">
                            <i class="bi bi-cart-plus fs-5"></i> Add to Cart
                        </button>
                    </div>
                </div>
            </div>

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
</body>
</html>
