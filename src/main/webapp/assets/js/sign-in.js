// Load remembered credentials on page load
window.addEventListener("load", () => {
    if(localStorage.getItem("userEmail")) {
        const emailInput = document.getElementById("email");
        const passwordInput = document.getElementById("password");
        const rememberMeInput = document.getElementById("rememberMe");
        
        if (emailInput && passwordInput && rememberMeInput) {
            emailInput.value = localStorage.getItem("userEmail");
            passwordInput.value = localStorage.getItem("userPassword");
            rememberMeInput.checked = true;
        }
    }
});

async function signIn() {
    Notiflix.Loading.pulse("Wait...", {
        clickToClose: false,
        svgColor: '#0284c7'
    });

    let email = document.getElementById("email");
    let password = document.getElementById("password");
    let rememberMe = document.getElementById("rememberMe");

    const userLoginObj = {
        email: email.value,
        password: password.value
    }

    try {
        const response = await fetch("api/users/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(userLoginObj)
        });


        if (response.ok) {
            const data = await response.json();
            if(data.status){
                if (rememberMe && rememberMe.checked) {
                    localStorage.setItem("userEmail", email.value);
                    localStorage.setItem("userPassword", password.value);
                } else {
                    localStorage.removeItem("userEmail");
                    localStorage.removeItem("userPassword");
                }
                
                Notiflix.Report.success(
                    'ElectroZone',
                    data.message,
                    'Okay', // button title
                    () => {
                        window.location = "index.jsp"
                    },
                );

            }else{
                Notiflix.Notify.failure(data.message,{
                    position:'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Login failed! Please try again",{
                position:'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message,{
            position:'center-top'
        });
    }finally {
        Notiflix.Loading.remove(1000);
    }
}
