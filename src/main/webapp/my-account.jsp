<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - My Account</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    
    <jsp:include page="include/header.jsp"/>

    
    <main class="container py-5">
        <div class="row g-5">
            
            <aside class="col-lg-3 d-none d-lg-block">
                <nav class="sticky-top" style="top: 100px;">
                    <a href="my-account.jsp" class="account-sidebar-link active">
                        <i class="bi bi-grid"></i> Account Overview
                    </a>
                    <a href="orders.jsp" class="account-sidebar-link">
                        <i class="bi bi-box-seam"></i> My Orders
                    </a>
                    <a href="wishlist.jsp" class="account-sidebar-link">
                        <i class="bi bi-heart"></i> Wishlist
                    </a>
                    <a href="#" class="account-sidebar-link text-danger mt-5" onclick="logout()">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </nav>
            </aside>

            
            <div class="col-lg-9">
                <div class="mb-4">
                    <h1 class="fw-bolder display-6 mb-1 text-dark">My Profile</h1>
                    <p class="text-muted fs-6 mb-0">Manage your personal information, address, and security.</p>
                </div>

                
                <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 text-white" style="background: linear-gradient(135deg, #0284c7 0%, #38bdf8 100%);">
                    <div class="d-flex align-items-center gap-4">
                        <div class="d-flex align-items-center justify-content-center bg-white text-primary rounded-circle shadow-sm" style="width: 80px; height: 80px; flex-shrink: 0;">
                            <i class="bi bi-person-fill fs-1"></i>
                        </div>
                        <div>
                            <h3 class="fw-bold mb-1" id="displayFullName">Loading...</h3>
                            <p class="mb-1 text-white-50"><i class="bi bi-envelope-fill me-2"></i><span id="displayEmail" class="text-white">Loading...</span></p>
                            <p class="mb-0 text-white-50 fs-7"><i class="bi bi-calendar3 me-2"></i>Member Since <span id="displayJoinedDate" class="fw-semibold text-white">Loading...</span></p>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4 p-4 mb-5 bg-white">
                    <form onsubmit="event.preventDefault(); updateProfile();">
                        <h5 class="fw-bold mb-4 border-bottom pb-2">Personal Information</h5>
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold fs-7 text-dark">First Name</label>
                                <input type="text" class="form-control" id="firstName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold fs-7 text-dark">Last Name</label>
                                <input type="text" class="form-control" id="lastName" required>
                            </div>
                        </div>

                        <h5 class="fw-bold mb-4 border-bottom pb-2 mt-5">Address Information</h5>
                        <div class="row g-4 mb-4">
                            <div class="col-md-12">
                                <label class="form-label fw-bold fs-7 text-dark">Line 1</label>
                                <input type="text" class="form-control" id="lineOne" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-bold fs-7 text-dark">Line 2 (Optional)</label>
                                <input type="text" class="form-control" id="lineTwo">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold fs-7 text-dark">City</label>
                                <select class="form-select" id="cityId" required>
                                    <option value="">Select City</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold fs-7 text-dark">Postal Code</label>
                                <input type="text" class="form-control" id="postalCode" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold fs-7 text-dark">Mobile Number</label>
                                <input type="text" class="form-control" id="mobile" required>
                            </div>
                        </div>

                        <h5 class="fw-bold mb-4 border-bottom pb-2 mt-5">Security</h5>
                        <div class="row g-4 mb-4">
                            <div class="col-md-12">
                                <label class="form-label fw-bold fs-7 text-dark">Current Password (Required for updates)</label>
                                <input type="password" class="form-control" id="password" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold fs-7 text-dark">New Password</label>
                                <input type="password" class="form-control" id="newPassword">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold fs-7 text-dark">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword">
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold shadow-sm px-5">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center">
            <p class="text-muted fs-8 mb-3 mb-md-0">&copy; 2024 ElectroZone. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/my-account.js"></script>
    <script src="assets/js/cart.js?v=2"></script>
</body>
</html>
