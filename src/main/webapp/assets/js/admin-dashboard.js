window.addEventListener("load", () => {
    loadDashboardStats();
});

function loadDashboardStats() {
    Notiflix.Loading.pulse("Loading Dashboard...");
    fetch("../api/admin/dashboard-stats")
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
                populateStats(data);
                populateRecentOrders(data.recentOrders);
                populateLowStockAlerts(data.lowStockAlerts);
            } else {
                Notiflix.Notify.failure(data.message);
            }
        })
        .catch(err => {
            Notiflix.Loading.remove();
            console.error(err);
        });
}

function populateStats(data) {
    document.getElementById("stat-revenue").textContent = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(data.totalRevenue);
    document.getElementById("stat-orders").textContent = data.totalOrders;
    document.getElementById("stat-products").textContent = data.totalProducts;
    document.getElementById("stat-customers").textContent = data.totalCustomers;
}

function populateRecentOrders(orders) {
    const tbody = document.getElementById("recent-orders-tbody");
    tbody.innerHTML = "";
    
    if(!orders || orders.length === 0) {
        tbody.innerHTML = "<tr><td colspan='5' class='text-center'>No recent orders</td></tr>";
        return;
    }
    
    orders.forEach(order => {
        let statusPillClass = "pill-pending";
        if(order.invoiceStatus === "COMPLETED" || order.invoiceStatus === "DELIVERED") statusPillClass = "pill-delivered";
        else if(order.invoiceStatus === "SHIPPED") statusPillClass = "pill-shipped";
        else if(order.invoiceStatus === "PROCESSING") statusPillClass = "pill-processing";
        else if(order.invoiceStatus === "CANCELLED") statusPillClass = "pill-cancelled";
        
        let date = order.invoiceDate.substring(0, 10);
        let amount = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(order.shippingCharges);
        
        tbody.innerHTML += `
            <tr>
                <td class="td-order-id">${order.invoiceNo}</td>
                <td>${order.buyerName}</td>
                <td><span class="status-pill ${statusPillClass}">${order.invoiceStatus}</span></td>
                <td>${date}</td>
                <td class="td-total">${amount}</td>
            </tr>
        `;
    });
}

function populateLowStockAlerts(products) {
    const container = document.getElementById("low-stock-container");
    container.innerHTML = "";
    
    if(!products || products.length === 0) {
        container.innerHTML = "<p class='text-muted p-3'>All stocks are good.</p>";
        return;
    }
    
    products.forEach(p => {
        let img = (p.images && p.images.length > 0) ? "../" + p.images[0] : "https://placehold.co/100x100/ffe4e6/1e293b?text=Image";
        let statusText = p.qty === 0 ? "Out of Stock" : "Low Stock";
        let colorClass = p.qty === 0 ? "bg-rose" : "bg-peach";
        
        container.innerHTML += `
            <div class="alert-item">
                <div class="alert-img-wrapper ${colorClass}">
                    <img src="${img}" alt="Product">
                </div>
                <div class="alert-info">
                    <h4 class="alert-title text-truncate" style="max-width: 150px;" title="${p.title}">${p.title}</h4>
                    <p class="alert-id">ID: #PROD-${p.id}</p>
                </div>
                <div class="alert-status">
                    <p class="alert-qty text-danger fw-bold">${p.qty} Left</p>
                    <p class="alert-text">${statusText}</p>
                </div>
            </div>
        `;
    });
}
