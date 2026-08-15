<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top shadow-sm">
        <div class="container">
            
            <a class="navbar-brand d-flex align-items-center gap-2 text-decoration-none" href="index.jsp">
                <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 36px; height: 36px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 10px;">
                    <i class="bi bi-lightning-fill text-white fs-5"></i>
                </div>
                <span class="fw-bold fs-4 tracking-tight text-dark mb-0">Electro<span class="text-primary">Zone</span></span>
            </a>

            
            <div class="d-flex align-items-center gap-2 d-lg-none">
                <a href="cart.jsp" class="text-dark position-relative p-2"><i class="bi bi-cart3 fs-4"></i><span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-count-badge" style="font-size: 0.65rem;">0</span></a>
                <button class="navbar-toggler border-0 shadow-none p-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>

            
            <div class="collapse navbar-collapse mt-3 mt-lg-0" id="navbarContent">
                
                <form action="search.jsp" method="get" class="search-wrapper mx-lg-4 flex-grow-1 position-relative mb-3 mb-lg-0" style="max-width: 480px;">
                    <i class="bi bi-search"></i>
                    <input type="text" name="q" class="form-control rounded-pill search-input w-100" placeholder="Search for products, brands and more...">
                </form>

                
                <ul class="navbar-nav mb-3 mb-lg-0 fw-medium gap-1 gap-lg-2">
                    <li class="nav-item">
                        <a class="nav-link text-dark px-2 py-1 rounded" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark px-2 py-1 rounded" href="products.jsp">Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark px-2 py-1 rounded" href="deals.jsp">Deals</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark px-2 py-1 rounded" href="new-arrivals.jsp">New Arrivals</a>
                    </li>
                </ul>

                
                <div class="d-flex align-items-center gap-3 ms-lg-auto pt-3 pt-lg-0 border-top border-lg-0">
                    <a href="cart.jsp" class="text-dark position-relative d-none d-lg-block me-2" title="View Cart">
                        <i class="bi bi-cart3 fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-count-badge" id="cart-count" style="font-size: 0.6rem;">0</span>
                    </a>
                    <a href="wishlist.jsp" class="text-dark position-relative me-2" title="My Wishlist">
                        <i class="bi bi-heart fs-5"></i>
                    </a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center border" style="width: 40px; height: 40px;" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="fw-bold fs-6 text-dark">${sessionScope.user.fullName.substring(0,1).toUpperCase()}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 mt-2">
                                    <li><span class="dropdown-item-text fw-bold text-dark">${sessionScope.user.fullName}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="my-account.jsp"><i class="bi bi-person me-2"></i>My Profile</a></li>
                                    <li><a class="dropdown-item" href="orders.jsp"><i class="bi bi-box-seam me-2"></i>My Orders</a></li>
                                    <li><a class="dropdown-item" href="wishlist.jsp"><i class="bi bi-heart me-2"></i>Wishlist</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#" onclick="logout(); return false;"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="btn btn-primary px-3 py-1 rounded-pill d-flex align-items-center gap-1 fs-7 shadow-sm">
                                <i class="bi bi-person fs-6"></i> Sign In
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
