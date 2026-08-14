window.addEventListener("load", () => {
    loadCustomers();
});

let allCustomers = [];

function loadCustomers() {
    Notiflix.Loading.pulse("Loading Customers...");
    fetch("../api/admin/customers/all")
        .then(response => {
            if(response.status === 401 || response.status === 403) {
                window.location.href = "../index.jsp";
                throw new Error("Unauthorized");
            }
            return response.json();
        })
        .then(data => {
            Notiflix.Loading.remove();
            if (data.status) {
                allCustomers = data.customers;
                updateStatsCards();
                filterCustomers();
            } else {
                Notiflix.Notify.failure(data.message);
            }
        })
        .catch(err => {
            Notiflix.Loading.remove();
            console.error(err);
            Notiflix.Notify.failure("Error: " + err.message);
        });
}

function updateStatsCards() {
    const totalCustomers = allCustomers.length;
    const activeMembers = allCustomers.filter(c => c.status === "ACTIVE").length;
    
    const now = new Date();
    const currentMonth = now.getMonth();
    const currentYear = now.getFullYear();
    
    const newThisMonth = allCustomers.filter(c => {
        if (!c.sinceAt || c.sinceAt === "Unknown") return false;
        const joinDate = new Date(c.sinceAt);
        return joinDate.getMonth() === currentMonth && joinDate.getFullYear() === currentYear;
    }).length;
    
    document.getElementById("stat-total-customers").innerText = totalCustomers.toLocaleString();
    document.getElementById("stat-active-members").innerText = activeMembers.toLocaleString();
    document.getElementById("stat-new-this-month").innerText = "+" + newThisMonth.toLocaleString();
}

function filterCustomers() {
    const searchText = document.getElementById("customer-search-input").value.toLowerCase();
    const statusFilter = document.getElementById("customer-status-filter").value;
    
    let filteredCustomers = allCustomers;
    
    if (searchText) {
        filteredCustomers = filteredCustomers.filter(c => 
            c.fullName.toLowerCase().includes(searchText) || 
            c.email.toLowerCase().includes(searchText) ||
            (c.mobile && c.mobile.toLowerCase().includes(searchText))
        );
    }
    
    if (statusFilter) {
        filteredCustomers = filteredCustomers.filter(c => {
            if(statusFilter === "ACTIVE") return c.status === "ACTIVE";
            if(statusFilter === "BLOCKED") return c.status !== "ACTIVE" && c.status !== "UNKNOWN";
            return true;
        });
    }
    
    populateCustomersTable(filteredCustomers);
}

function populateCustomersTable(customers) {
    const tbody = document.getElementById("admin-customers-tbody");
    tbody.innerHTML = "";
    
    if(!customers || customers.length === 0) {
        tbody.innerHTML = "<tr><td colspan='6' class='text-center'>No customers found</td></tr>";
        return;
    }
    
    customers.forEach(customer => {
        let isBlocked = customer.status === "BLOCKED";
        let statusPillClass = isBlocked ? "pill-blocked" : "pill-active";
        let statusText = isBlocked ? "Blocked" : "Active";
        let actionBtnClass = isBlocked ? "unblock" : "";
        let actionBtnIcon = isBlocked ? "bi-check-circle-fill" : "bi-slash-circle-fill";
        let newStatusToSet = isBlocked ? "ACTIVE" : "BLOCKED";
        
        // Random avatar based on name
        let avatarUrl = `https://ui-avatars.com/api/?name=${encodeURIComponent(customer.fullName)}&background=1e293b&color=fff`;
        let date = customer.sinceAt ? customer.sinceAt.substring(0, 10) : "N/A";
        
        tbody.innerHTML += `
            <tr>
                <td>
                    <img src="${avatarUrl}" alt="Profile" class="customer-profile-img">
                </td>
                <td>
                    <p class="customer-name">${customer.fullName}</p>
                    <p class="customer-id">ID: #CUS-${String(customer.id).padStart(5, '0')}</p>
                </td>
                <td>
                    <div class="contact-line">
                        <i class="bi bi-envelope-fill"></i> ${customer.email}
                    </div>
                    <div class="contact-line">
                        <i class="bi bi-telephone-fill"></i> ${customer.mobile || "N/A"}
                    </div>
                </td>
                <td class="join-date">${date}</td>
                <td>
                    <span class="status-pill ${statusPillClass}"><span class="dot"></span> ${statusText}</span>
                </td>
                <td>
                    <div class="action-icons">
                        <button class="action-icon-btn ${actionBtnClass}" onclick="updateCustomerStatus(${customer.id}, '${newStatusToSet}')">
                            <i class="bi ${actionBtnIcon}"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });
}

function updateCustomerStatus(id, newStatus) {
    let actionText = newStatus === "ACTIVE" ? "Unblock" : "Block";
    
    Notiflix.Confirm.show(
        actionText + ' Customer',
        'Are you sure you want to ' + actionText.toLowerCase() + ' this customer?',
        'Yes',
        'No',
        function okCb() {
            Notiflix.Loading.pulse("Updating...");
            fetch("../api/admin/customers/" + id + "/status", {
                method: "PUT",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "status=" + newStatus
            })
            .then(response => {
                if(response.status === 401 || response.status === 403) throw new Error("Unauthorized");
                return response.json();
            })
            .then(data => {
                Notiflix.Loading.remove();
                if(data.status) {
                    Notiflix.Notify.success(data.message);
                    loadCustomers(); // reload
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            })
            .catch(err => {
                Notiflix.Loading.remove();
                console.error(err);
            });
        },
        function cancelCb() {},
    );
}
