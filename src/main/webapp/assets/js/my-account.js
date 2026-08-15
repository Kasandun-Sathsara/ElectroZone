window.addEventListener("load", async () => {
    Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
    try {
        await loadCities();
        await loadUserProfile();
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadCities() {
    try {
        const response = await fetch("api/data/cities");
        if (response.ok) {
            const data = await response.json();
            const citySelect = document.getElementById("cityId");
            data.cities.forEach(city => {
                let option = document.createElement("option");
                option.value = city.id;
                option.textContent = city.name;
                citySelect.appendChild(option);
            });
        }
    } catch (e) {
        console.error("Cities loading failed:", e);
    }
}

async function loadUserProfile() {
    try {
        const response = await fetch("api/profiles/user-profile");
        if (response.ok) {
            const data = await response.json();
            if (data.user) {

                document.getElementById("displayFullName").textContent = (data.user.firstName || "") + " " + (data.user.lastName || "");
                document.getElementById("displayEmail").textContent = data.user.email || "N/A";
                document.getElementById("displayJoinedDate").textContent = data.user.sinceAt || "Unknown";

                document.getElementById("firstName").value = data.user.firstName || "";
                document.getElementById("lastName").value = data.user.lastName || "";
                document.getElementById("lineOne").value = data.user.lineOne || "";
                document.getElementById("lineTwo").value = data.user.lineTwo || "";
                
                if (data.user.cityId && data.user.cityId > 0) {
                    document.getElementById("cityId").value = data.user.cityId;
                }
                
                document.getElementById("postalCode").value = data.user.postalCode || "";
                document.getElementById("mobile").value = data.user.mobile || "";
            } else if(response.status === 401 || data.message === "Please login first") {
                window.location.href = "login.jsp";
            }
        } else if (response.status === 401) {
            window.location.href = "login.jsp";
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    }
}

async function updateProfile() {
    Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
    
    const userDTO = {
        firstName: document.getElementById("firstName").value,
        lastName: document.getElementById("lastName").value,
        lineOne: document.getElementById("lineOne").value,
        lineTwo: document.getElementById("lineTwo").value,
        cityId: parseInt(document.getElementById("cityId").value) || 0,
        postalCode: document.getElementById("postalCode").value,
        mobile: document.getElementById("mobile").value,
        password: document.getElementById("password").value,
        newPassword: document.getElementById("newPassword").value,
        confirmPassword: document.getElementById("confirmPassword").value
    };

    try {
        const response = await fetch("api/profiles/update-profile", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(userDTO)
        });

        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                Notiflix.Notify.success(data.message, { position: 'center-top' });

                document.getElementById("password").value = "";
                document.getElementById("newPassword").value = "";
                document.getElementById("confirmPassword").value = "";
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        } else if (response.status === 401) {
            window.location.href = "login.jsp";
        } else {
            Notiflix.Notify.failure("Profile update failed!", { position: 'center-top' });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    } finally {
        Notiflix.Loading.remove();
    }
}

