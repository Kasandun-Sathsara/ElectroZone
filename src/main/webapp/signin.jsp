<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ElectroZone - Create Account</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

    <body class="auth-page-body">

        <div class="container-fluid vh-100 p-0">
            <div class="row g-0 h-100">
                <!-- Left Panel (Hidden on extra small devices) -->
                <div
                    class="col-md-6 col-lg-6 d-none d-md-flex flex-column justify-content-center left-panel position-relative">
                    <div class="content-wrapper p-4 p-xl-5 z-2">
                        <!-- Brand -->
                        <div class="brand mb-5 d-flex align-items-center">
                            <div class="brand-icon me-3 d-flex align-items-center justify-content-center shadow-sm">
                                <i class="bi bi-lightning-fill text-white fs-4"></i>
                            </div>
                        </div>

                        <!-- Main Text -->
                        <h1 class="display-4 fw-bolder mb-3 lh-sm mt-4">
                            Future of Tech<br>
                            Starts Here.
                        </h1>

                        <!-- Sub Description -->
                        <p class="text-light-muted mb-5 fs-5 pe-lg-5 fw-normal mt-4">
                            Join ElectroZone today. Access exclusive deals,<br>
                            track your orders in real-time, and experience<br>
                            the next generation of electronics shopping.
                        </p>

                        <!-- Members Joined -->
                        <div class="members-joined d-flex align-items-center mt-5 pt-4">
                            <div class="avatar-group me-3 d-flex">
                                <img src="https://ui-avatars.com/api/?name=O+D&background=e2e8f0&color=4a5568&rounded=true&size=40"
                                    alt="Avatar" class="avatar shadow-sm border-white">
                                <img src="https://ui-avatars.com/api/?name=L+M&background=edf2f7&color=2d3748&rounded=true&size=40"
                                    alt="Avatar" class="avatar shadow-sm border-white">
                                <div
                                    class="avatar shadow-sm border-white d-flex align-items-center justify-content-center bg-dark text-white fw-bold fs-8">
                                    +2k</div>
                            </div>
                            <div class="d-flex flex-column">
                                <div class="stars mb-1">
                                    <i class="bi bi-star-fill text-warning fs-7"></i>
                                    <i class="bi bi-star-fill text-warning fs-7"></i>
                                    <i class="bi bi-star-fill text-warning fs-7"></i>
                                    <i class="bi bi-star-fill text-warning fs-7"></i>
                                    <i class="bi bi-star-fill text-warning fs-7"></i>
                                </div>
                                <span class="fs-7 fw-medium text-light-muted">Join our happy community</span>
                            </div>
                        </div>
                    </div>
                    <!-- Gradient Overlay / Decors -->
                    <div class="glow-bg"></div>
                </div>

                <!-- Right Panel (Sign Up Form) -->
                <div
                    class="col-md-6 col-lg-6 col-12 d-flex flex-column align-items-center justify-content-center right-panel position-relative pt-5 pt-md-0 bg-white">
                    <div class="login-wrapper w-100 px-4 px-sm-5 custom-max-width">
                        <div class="mb-4 text-center text-md-start mt-4">
                            <h2 class="fw-bolder mb-2 text-dark fs-1">Create Account</h2>
                            <p class="text-muted fs-6">Enter your details to get started.</p>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger p-2 fs-7" role="alert">
                                    ${error}
                                </div>
                            </c:if>
                        </div>

                        <form action="register" method="post">
                            <!-- Full Name Input -->
                            <div class="mb-3">
                                <label for="fullName" class="form-label fw-bold fs-7 text-dark mb-1">Full Name</label>
                                <div class="form-group position-relative input-wrapper">
                                    <i class="bi bi-person-fill position-absolute icon-left pe-none"></i>
                                    <input type="text" class="form-control form-control-lg custom-input has-icon-left"
                                        id="fullName" name="fullName" placeholder="John Doe" required>
                                </div>
                            </div>

                            <!-- Email Input -->
                            <div class="mb-3">
                                <label for="email" class="form-label fw-bold fs-7 text-dark mb-1">Email Address</label>
                                <div class="form-group position-relative input-wrapper">
                                    <i class="bi bi-envelope-fill position-absolute icon-left pe-none"></i>
                                    <input type="email" class="form-control form-control-lg custom-input has-icon-left"
                                        id="email" name="email" placeholder="name@example.com" required>
                                </div>
                            </div>

                            <!-- Password Input -->
                            <div class="mb-3">
                                <label for="password" class="form-label fw-bold fs-7 text-dark mb-1">Password</label>
                                <div class="form-group position-relative input-wrapper">
                                    <i class="bi bi-lock-fill position-absolute icon-left pe-none"></i>
                                    <input type="password"
                                        class="form-control form-control-lg custom-input has-icon-left" id="password"
                                        name="password" placeholder="Create a strong password" required>
                                    <i class="bi bi-eye-slash-fill position-absolute icon-right text-muted cursor-pointer pe-1"
                                        id="togglePassword"></i>
                                </div>
                                <div class="form-text fs-8 mt-1 text-muted">Must be at least 8 characters.</div>
                            </div>

                            <!-- Checkbox Options -->
                            <div class="mb-4 mt-4">
                                <div class="form-check d-flex align-items-center gap-2">
                                    <input class="form-check-input custom-checkbox mt-0 bg-light" type="checkbox"
                                        id="agreeTerms" required>
                                    <label class="form-check-label text-muted fs-7 pt-1 fw-medium" for="agreeTerms">
                                        I agree to the <a href="#" class="text-decoration-none link-primary">Terms</a>
                                        and <a href="#" class="text-decoration-none link-primary">Privacy Policy</a>
                                    </label>
                                </div>
                            </div>

                            <!-- Sign Up Button -->
                            <button type="submit"
                                class="btn btn-primary btn-lg w-100 mb-4 rounded-3 fw-bold shadow-sm btn-signin text-white">Create
                                Account</button>

                            <!-- Divider -->
                            <div class="divider d-flex align-items-center mb-4 mt-2">
                                <hr class="flex-grow-1 border-secondary opacity-25">
                                <span class="mx-3 text-muted fs-7 fw-medium">Or register with</span>
                                <hr class="flex-grow-1 border-secondary opacity-25">
                            </div>

                            <!-- Google & Apple Sign In Options -->
                            <div class="row g-3 mb-4">
                                <div class="col-6">
                                    <button type="button"
                                        class="btn btn-outline-light text-dark btn-lg w-100 rounded-3 custom-border fw-bold d-flex justify-content-center align-items-center btn-google">
                                        <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google"
                                            width="20" class="me-2"> Google
                                    </button>
                                </div>
                                <div class="col-6">
                                    <button type="button"
                                        class="btn btn-outline-light text-dark btn-lg w-100 rounded-3 custom-border fw-bold d-flex justify-content-center align-items-center btn-google">
                                        <i class="bi bi-apple fs-5 me-2"></i> Apple
                                    </button>
                                </div>
                            </div>

                            <!-- Sign In link -->
                            <div class="text-center mt-2 mb-4">
                                <p class="text-muted fs-7 fw-medium">Already have an account? <a href="login.jsp"
                                        class="text-decoration-none fw-bold link-primary ms-1">Sign In</a></p>
                            </div>
                        </form>
                    </div>

                    <!-- Footer -->
                    <div class="position-absolute bottom-0 w-100 text-center pb-4 text-muted fs-8 fw-medium">
                        &copy; 2023 ElectroZone Inc. All rights reserved.
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Password toggle
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');

            togglePassword.addEventListener('click', function (e) {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('bi-eye-slash-fill');
                this.classList.toggle('bi-eye-fill');
            });
        </script>
    </body>

    </html>
