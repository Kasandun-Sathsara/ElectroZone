<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Forgot Password</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-page-body">

    <div class="container d-flex flex-column align-items-center">
        
        <div class="auth-card">
            <div class="auth-card-body">
                
                <a href="index.jsp" class="auth-brand">
                    <i class="bi bi-lightning-fill auth-brand-icon"></i>
                    <span class="auth-brand-text">ElectroZone</span>
                </a>

                <!-- Step 1: Request OTP -->
                <div id="step-1">
                    <h1 class="auth-title">Forgot your password?</h1>
                    <p class="auth-subtitle">Enter your email address and we'll send you an OTP to reset your password.</p>

                    <form id="form-send-otp" onsubmit="event.preventDefault(); sendOtp();">
                        <div class="mb-3">
                            <label class="auth-label">Email Address</label>
                            <div class="auth-input-group">
                                <i class="bi bi-envelope-fill auth-input-icon"></i>
                                <input type="email" id="email" class="form-control auth-input" placeholder="name@example.com" required autofocus>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-auth-submit shadow-sm" id="btn-send-otp">
                            Send OTP <i class="bi bi-arrow-right"></i>
                        </button>
                    </form>
                </div>

                <!-- Step 2: Verify OTP -->
                <div id="step-2" class="d-none">
                    <h1 class="auth-title">Verify OTP</h1>
                    <p class="auth-subtitle">We have sent a 6-digit OTP to your email address. Please enter it below.</p>

                    <form id="form-verify-otp" onsubmit="event.preventDefault(); verifyOtp();">
                        <div class="mb-3">
                            <label class="auth-label">One Time Password (OTP)</label>
                            <div class="auth-input-group">
                                <i class="bi bi-shield-lock-fill auth-input-icon"></i>
                                <input type="text" id="otp" class="form-control auth-input text-center fs-4 letter-spacing-2" placeholder="XXXXXX" maxlength="6" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-auth-submit shadow-sm" id="btn-verify-otp">
                            Verify OTP <i class="bi bi-check-circle"></i>
                        </button>
                    </form>
                </div>

                <!-- Step 3: Reset Password -->
                <div id="step-3" class="d-none">
                    <h1 class="auth-title">Reset Password</h1>
                    <p class="auth-subtitle">Please enter your new password below.</p>

                    <form id="form-reset-password" onsubmit="event.preventDefault(); resetPassword();">
                        <div class="mb-3">
                            <label class="auth-label">New Password</label>
                            <div class="auth-input-group">
                                <i class="bi bi-lock-fill auth-input-icon"></i>
                                <input type="password" id="new-password" class="form-control auth-input" placeholder="Enter new password" required>
                            </div>
                            <div class="form-text fs-8 mt-1 text-muted">Must be at least 8 characters with upper, lower, digit & special chars.</div>
                        </div>

                        <div class="mb-3">
                            <label class="auth-label">Confirm Password</label>
                            <div class="auth-input-group">
                                <i class="bi bi-lock-fill auth-input-icon"></i>
                                <input type="password" id="confirm-password" class="form-control auth-input" placeholder="Confirm new password" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-auth-submit shadow-sm" id="btn-reset-password">
                            Update Password <i class="bi bi-check2-all"></i>
                        </button>
                    </form>
                </div>
                
            </div>
            
            <div class="auth-card-footer">
                <a href="login.jsp" class="auth-link">
                    <i class="bi bi-arrow-left"></i> Back to Login
                </a>
            </div>
        </div>

        <div class="auth-help-text">
            Still having trouble? <a href="#" class="auth-help-link">Contact Support</a>
        </div>

    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
    <script src="assets/js/forgot-password.js"></script>
</body>
</html>
