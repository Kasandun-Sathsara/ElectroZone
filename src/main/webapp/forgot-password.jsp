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

                <h1 class="auth-title">Forgot your password?</h1>
                <p class="auth-subtitle">Don't worry, it happens. Enter the email address associated with your account and we'll send you a link to reset it.</p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger p-2 fs-7" role="alert">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success p-2 fs-7" role="alert">${success}</div>
                </c:if>

                <form class="auth-form" action="forgot-password" method="POST">
                    <div class="mb-3">
                        <label class="auth-label">Email Address</label>
                        <div class="auth-input-group">
                            <i class="bi bi-envelope-fill auth-input-icon"></i>
                            <input type="email" name="email" class="form-control auth-input" placeholder="name@example.com" required autofocus>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-auth-submit shadow-sm">
                        Send Reset Link <i class="bi bi-arrow-right"></i>
                    </button>
                </form>
                
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

</body>
</html>
