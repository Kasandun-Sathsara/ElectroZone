<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Verify Account</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-page-body">

<div class="container-fluid vh-100 p-0">
    <div class="row g-0 h-100">
        
        <div class="col-md-6 col-lg-6 d-none d-md-flex flex-column justify-content-center left-panel position-relative">
            <div class="content-wrapper p-4 p-xl-5 z-2">
                
                <div class="brand mb-5 d-flex align-items-center gap-2">
                    <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 44px; height: 44px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 12px;">
                        <i class="bi bi-lightning-fill text-white fs-4"></i>
                    </div>
                    <h2 class="mb-0 fw-bold tracking-tight text-white">Electro<span class="text-electric">Zone</span></h2>
                </div>

                
                <h1 class="display-4 fw-bolder mb-3 lh-sm mt-4">
                    Verify your<br>
                    <span class="text-electric">Account</span> to<br>
                    continue.
                </h1>

                
                <p class="text-light-muted mb-5 fs-5 pe-lg-5 fw-normal mt-4">
                    We have sent a verification code to your email.<br>
                    Please enter it here to activate your account.
                </p>
            </div>
            
            <div class="glow-bg"></div>
        </div>

        
        <div class="col-md-6 col-lg-6 col-12 d-flex flex-column align-items-center justify-content-center right-panel position-relative py-5 bg-white min-vh-100">
            <div class="login-wrapper w-100 px-4 px-sm-5 custom-max-width">
                
                <div class="d-flex d-md-none align-items-center justify-content-center gap-2 mb-4">
                    <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 40px; height: 40px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 10px;">
                        <i class="bi bi-lightning-fill text-white fs-5"></i>
                    </div>
                    <span class="fw-bold fs-3 tracking-tight text-dark mb-0">Electro<span class="text-primary">Zone</span></span>
                </div>

                <div class="mb-4 mb-md-5 text-center text-md-start">
                    <h2 class="fw-bolder mb-2 text-dark fs-1">Verify Account</h2>
                    <p class="text-muted fs-6">Enter the code sent to your email.</p>
                </div>

                <form onsubmit="event.preventDefault(); verifyAccount();">
                    
                    <div class="form-group mb-4 position-relative input-wrapper">
                        <input type="text" class="form-control form-control-lg custom-input" id="verificationCode" name="verificationCode" placeholder="Verification Code" required>
                        <i class="bi bi-shield-lock-fill position-absolute icon-right text-muted pe-1"></i>
                    </div>

                    
                    <button type="submit" class="btn btn-primary btn-lg w-100 mb-4 rounded-3 fw-bold shadow-sm btn-signin text-white">Verify Account</button>
                    
                    <div class="text-center mt-2">
                        <p class="text-muted fs-7 fw-medium"><a href="login.jsp" class="text-decoration-none fw-bold link-primary">Back to Login</a></p>
                    </div>
                </form>
            </div>
            
             
             <div class="position-absolute bottom-0 w-100 text-center pb-4 text-muted fs-8 fw-medium">
                 &copy; 2023 ElectroZone Inc. &nbsp; Privacy &bull; Terms
             </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/notiflix-aio-3.2.8.min.js"></script>
<script src="assets/js/verify-account.js"></script>
</body>
</html>
