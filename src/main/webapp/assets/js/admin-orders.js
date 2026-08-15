window.addEventListener("load", () => {
    loadOrders();
});

let allOrders = [];

function loadOrders() {
    Notiflix.Loading.pulse("Loading Orders...");
    fetch("../api/admin/orders/all")
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
                allOrders = data.orders;
                filterOrders();
            } else {
                Notiflix.Notify.failure(data.message);
            }
        })
        .catch(err => {
            Notiflix.Loading.remove();
            console.error(err);
        });
}

function filterOrders() {
    const searchText = document.getElementById("order-search-input").value.toLowerCase();
    const statusFilter = document.getElementById("order-status-filter").value;
    
    let filteredOrders = allOrders;
    
    if (searchText) {
        filteredOrders = filteredOrders.filter(o => 
            o.invoiceNo.toLowerCase().includes(searchText) || 
            o.buyerName.toLowerCase().includes(searchText)
        );
    }
    
    if (statusFilter) {
        filteredOrders = filteredOrders.filter(o => o.invoiceStatus === statusFilter);
    }
    
    populateOrdersTable(filteredOrders);
}

function populateOrdersTable(orders) {
    const tbody = document.getElementById("admin-orders-tbody");
    tbody.innerHTML = "";
    
    if(!orders || orders.length === 0) {
        tbody.innerHTML = "<tr><td colspan='6' class='text-center'>No orders found</td></tr>";
        return;
    }
    
    orders.forEach(order => {
        let statusPillClass = "pill-pending";
        if(order.invoiceStatus === "COMPLETED" || order.invoiceStatus === "DELIVERED") statusPillClass = "pill-delivered";
        else if(order.invoiceStatus === "PACKING") statusPillClass = "pill-processing";
        else if(order.invoiceStatus === "CANCELED") statusPillClass = "pill-cancelled";
        
        let date = order.invoiceDate.substring(0, 10);
        let amount = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(order.shippingCharges);
        let rawId = order.email; 
        
        tbody.innerHTML += `
            <tr>
                <td class="fw-bold">${order.invoiceNo}</td>
                <td>${order.buyerName}</td>
                <td>${date}</td>
                <td class="fw-bold text-dark">${amount}</td>
                <td><span class="status-pill ${statusPillClass}">${order.invoiceStatus}</span></td>
                <td>
                    <select class="form-select form-select-sm d-inline-block w-auto" onchange="updateOrderStatus(${rawId}, this.value)">
                        <option value="" selected disabled>Change Status</option>
                        <option value="PACKING">Packing</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="DELIVERED">Delivered</option>
                        <option value="CANCELED">Canceled</option>
                    </select>
                </td>
            </tr>
        `;
    });
}

function updateOrderStatus(id, newStatus) {
    if(!newStatus) return;
    
    Notiflix.Confirm.show(
        'Update Status',
        'Update order to ' + newStatus + '?',
        'Yes',
        'No',
        function okCb() {
            Notiflix.Loading.pulse("Updating...");
            fetch("../api/admin/orders/" + id + "/status", {
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
                    loadOrders(); 
                } else {
                    Notiflix.Notify.failure(data.message);
                }
            })
            .catch(err => {
                Notiflix.Loading.remove();
                console.error(err);
            });
        },
        function cancelCb() {
            loadOrders(); 
        },
    );
}
