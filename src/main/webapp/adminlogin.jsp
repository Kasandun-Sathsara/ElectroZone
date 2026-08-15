<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroZone - Admin Login</title>
    
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
                
                <div class="brand mb-5 d-flex align-items-center">
                    <div class="brand-icon me-3 d-flex align-items-center justify-content-center shadow-sm">
                        <i class="bi bi-lightning-fill text-white fs-4"></i>
                    </div>
                    <h2 class="mb-0 fw-bold tracking-tight">ElectroZone Admin</h2>
                </div>

                
                <h1 class="display-4 fw-bolder mb-3 lh-sm mt-4">
                    Manage the<br>
                    <span class="text-electric">Platform</span> With<br>
                    Ease.
                </h1>

                
                <p class="text-light-muted mb-5 fs-5 pe-lg-5 fw-normal mt-4">
                    Join the community of forward-thinkers.<br>
                    Discover premium gadgets that redefine your<br>
                    digital lifestyle.
                </p>

                
                <div class="members-joined d-flex align-items-center mt-5 pt-4">
                    <div class="avatar-group me-3 d-flex">
                        <img src="https://ui-avatars.com/api/?name=O+D&background=e2e8f0&color=4a5568&rounded=true&size=40" alt="Avatar" class="avatar shadow-sm border-white">
                        <img src="https://ui-avatars.com/api/?name=L+M&background=edf2f7&color=2d3748&rounded=true&size=40" alt="Avatar" class="avatar shadow-sm border-white">
                        <img src="https://ui-avatars.com/api/?name=S+T&background=f7fafc&color=1a202c&rounded=true&size=40" alt="Avatar" class="avatar shadow-sm border-white">
                    </div>
                    <span class="fs-6 fw-medium"><span class="text-white fw-bold">10k+</span> members joined this week</span>
                </div>
            </div>
            
            <div class="glow-bg"></div>
        </div>

        
        <div class="col-md-6 col-lg-6 col-12 d-flex flex-column align-items-center justify-content-center right-panel position-relative py-5 bg-white min-vh-100">
            <div class="login-wrapper w-100 px-4 px-sm-5 custom-max-width">
                
                <div class="d-flex d-md-none align-items-center justify-content-center gap-2 mb-4">
                    <div class="brand-icon d-flex align-items-center justify-content-center shadow-sm" style="width: 40px; height: 40px; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); border-radius: 10px;">
                        <i class="bi bi-lightning-fill text-white fs-5"></i>
                    </div>
                    <span class="fw-bold fs-3 tracking-tight text-dark mb-0">Electro<span class="text-primary">Zone</span> <span class="badge bg-primary-subtle text-primary border fs-8 ms-1">Admin</span></span>
                </div>

                <div class="mb-4 mb-md-5 text-center text-md-start">
                    <h2 class="fw-bolder mb-2 text-dark fs-1">Admin Portal</h2>
                    <p class="text-muted fs-6">Enter your administrator credentials to login.</p>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger p-2 fs-7" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success p-2 fs-7" role="alert">
                            ${success}
                        </div>
                    </c:if>
                </div>

                <form onsubmit="event.preventDefault(); signIn();">
                    
                    <div class="form-group mb-3 position-relative input-wrapper">
                        <input type="email" class="form-control form-control-lg custom-input" id="email" name="email" placeholder="Email address" required>
                        <i class="bi bi-envelope-fill position-absolute icon-right text-muted pe-1"></i>
                    </div>

                    
                    <div class="form-group mb-4 position-relative input-wrapper">
                        <input type="password" class="form-control form-control-lg custom-input" id="password" name="password" placeholder="Password" required>
                        <i class="bi bi-eye-slash-fill position-absolute icon-right text-muted cursor-pointer pe-1" id="togglePassword"></i>
                    </div>

                    
                    <div class="row mb-5 align-items-center">
                        <div class="col-12">
                            <div class="form-check d-flex align-items-center gap-2">
                                <input class="form-check-input custom-checkbox mt-0" type="checkbox" id="rememberMe">
                                <label class="form-check-label text-muted fs-7 pt-1 fw-medium" for="rememberMe">
                                    Remember me
                                </label>
                            </div>
                        </div>
                    </div>

                    
                    <button type="submit" class="btn btn-primary btn-lg w-100 mb-4 rounded-3 fw-bold shadow-sm btn-signin text-white">Login to Dashboard</button>
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
<script>

    window.addEventListener("load", () => {
        if(localStorage.getItem("adminEmail")) {
            document.getElementById("email").value = localStorage.getItem("adminEmail");
            document.getElementById("password").value = localStorage.getItem("adminPassword");
            document.getElementById("rememberMe").checked = true;
        }
    });

    async function signIn() {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        
        const emailInput = document.getElementById("email").value;
        const passwordInput = document.getElementById("password").value;
        const rememberMe = document.getElementById("rememberMe").checked;
        
        const userLoginObj = {
            email: emailInput,
            password: passwordInput
        };

        try {
            const response = await fetch("api/users/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(userLoginObj)
            });

            if (response.ok) {
                const data = await response.json();
                if(data.status){
                    if(rememberMe) {
                        localStorage.setItem("adminEmail", emailInput);
                        localStorage.setItem("adminPassword", passwordInput);
                    } else {
                        localStorage.removeItem("adminEmail");
                        localStorage.removeItem("adminPassword");
                    }
                    Notiflix.Report.success(
                        'ElectroZone Admin',
                        'Login successful. Redirecting to dashboard...',
                        'Go',
                        () => { window.location = "admin/dashboard.jsp"; }
                    );
                } else {
                    Notiflix.Notify.failure(data.message, { position:'center-top' });
                }
            } else {
                Notiflix.Notify.failure("Login failed! Please try again", { position:'center-top' });
            }
        } catch (e) {
            Notiflix.Notify.failure(e.message, { position:'center-top' });
        } finally {
            Notiflix.Loading.remove();
        }
    }
</script>
<script>

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
