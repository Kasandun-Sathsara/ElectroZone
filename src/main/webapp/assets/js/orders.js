window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        await loadMyOrders();
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadMyOrders() {
    try {
        const response = await fetch("api/orders/my");
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                renderOrders(data.orders);
            } else if (data.status_code === 401) {
                window.location.href = "login.jsp";
            } else {
                document.getElementById("orders-container").innerHTML = `<div class="col-12 text-center text-muted p-5"><h5>Failed to load orders.</h5></div>`;
            }
        }
    } catch (e) {
        console.error("Orders loading failed:", e);
    }
}

function renderOrders(orders) {
    const container = document.getElementById("orders-container");
    if (!container) return;

    container.innerHTML = "";

    if (!orders || orders.length === 0) {
        container.innerHTML = `<div class="col-12 text-center text-muted p-5"><h5>You have no orders yet.</h5><a href="search.jsp" class="btn btn-outline-primary mt-3">Start Shopping</a></div>`;
        return;
    }

    orders.forEach(order => {
        let itemsHtml = "";
        order.items.forEach(item => {
            const formattedPrice = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(item.price);
            itemsHtml += `
                <div class="d-flex gap-3 mb-3">
                    <div class="order-item-img border rounded" style="width: 80px; height: 80px; background-color: #f8fafc; overflow: hidden; flex-shrink: 0;">
                        <img src="${item.image}" alt="${item.productTitle}" style="width: 100%; height: 100%; object-fit: contain; mix-blend-mode: multiply;">
                    </div>
                    <div>
                        <h6 class="fw-bold fs-7 mb-1 text-dark" style="max-height: 2.5rem; overflow: hidden;">${item.productTitle}</h6>
                        <p class="text-muted fs-8 mb-2">Quantity: ${item.qty} &middot; LKR ${formattedPrice}</p>
                    </div>
                </div>
            `;
        });

        let statusClass = "status-processing bg-warning text-dark px-2 py-1 rounded fs-8";
        let statusIcon = "bi-box-seam";
        if (order.status.toLowerCase() === "completed") {
            statusClass = "status-delivered bg-success text-white px-2 py-1 rounded fs-8";
            statusIcon = "bi-check-circle-fill";
        } else if (order.status.toLowerCase() === "rejected") {
            statusClass = "bg-danger text-white px-2 py-1 rounded fs-8";
            statusIcon = "bi-x-circle-fill";
        }

        const formattedTotal = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(order.total);

        container.innerHTML += `
            <div class="order-card shadow-sm mb-4 bg-white rounded-4 overflow-hidden border">
                <div class="order-header bg-light p-3 border-bottom">
                    <div class="d-flex gap-4 flex-wrap">
                        <div>
                            <div class="order-meta-label text-muted fs-8 text-uppercase">Order Placed</div>
                            <div class="order-meta-value fw-bold">${order.createdAt}</div>
                        </div>
                        <div>
                            <div class="order-meta-label text-muted fs-8 text-uppercase">Total</div>
                            <div class="order-meta-value fw-bold">LKR ${formattedTotal}</div>
                        </div>
                        <div>
                            <div class="order-meta-label text-muted fs-8 text-uppercase">Order ID</div>
                            <div class="order-meta-value fw-bold text-primary">#${order.id}</div>
                        </div>
                    </div>
                </div>
                <div class="order-body p-4">
                    <div class="d-flex align-items-center gap-3 mb-4">
                        <span class="status-badge ${statusClass} fw-semibold d-inline-flex align-items-center"><i class="bi ${statusIcon} me-1"></i> ${order.status}</span>
                    </div>

                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-4">
                        <div class="d-flex flex-column gap-2 flex-grow-1">
                            ${itemsHtml}
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}
