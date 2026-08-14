<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-white py-3 border-bottom sticky-top shadow-sm">
        <div class="container">
            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="brand-icon me-2 d-flex align-items-center justify-content-center shadow-sm">
                    <i class="bi bi-lightning-fill text-white"></i>
                </div>
                <span class="fw-bold fs-4 tracking-tight text-dark">ElectroZone</span>
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Content -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <!-- Search Bar -->
                <form action="search" method="get" class="search-wrapper mx-lg-4 flex-grow-1 position-relative d-none d-lg-block" style="max-width: 400px;">
                    <i class="bi bi-search"></i>
                    <input type="text" name="q" class="form-control rounded-pill search-input w-100" placeholder="Search for products, brands and more">
                </form>

                <!-- Navigation Links -->
                <ul class="navbar-nav mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item mx-2">
                        <a class="nav-link text-dark" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link text-muted" href="products.jsp">Products</a>
                    </li>
                </ul>

                <!-- Icons -->
                <div class="d-flex align-items-center ms-lg-auto mt-3 mt-lg-0">
                    <a href="cart.jsp" class="text-dark position-relative me-3"><i class="bi bi-cart3 fs-5"></i><span id="cart-count" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">0</span></a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <a href="#" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center border" style="width: 40px; height: 40px;" data-bs-toggle="dropdown">
                                    <span class="fw-bold fs-6 text-dark">${sessionScope.user.fullName.substring(0,1)}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 mt-2">
                                    <li><a class="dropdown-item" href="my-account.jsp">My Profile</a></li>
                                    <li><a class="dropdown-item" href="orders.jsp">My Orders</a></li>
                                    <li><a class="dropdown-item" href="wishlist.jsp">Wishlist</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#" onclick="logout(); return false;">Logout</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center border" style="width: 40px; height: 40px;">
                                <i class="bi bi-person text-dark fs-5"></i>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
