async function fetchAndRenderInvoice() {
    const params = new URLSearchParams(window.location.search);
    const orderId = params.get("orderId");
    if (!orderId) {
        console.error("No orderId found in URL parameters");
        return;
    }

    try {
        if (typeof Notiflix !== 'undefined' && Notiflix.Loading) {
            Notiflix.Loading.pulse("Loading Invoice...", { svgColor: '#2563eb' });
        }

        const response = await fetch("api/invoices/user-invoice?orderId=" + encodeURIComponent(orderId));
        if (!response.ok) {
            throw new Error("HTTP error " + response.status);
        }

        const data = await response.json();
        console.log("Invoice data received:", data);

        if (data.status && data.invoiceData) {
            const inv = data.invoiceData;
            
            // Populate header
            const invNoEl = document.getElementById("invoice-no");
            if (invNoEl) {
                invNoEl.textContent = inv.invoiceNo ? (inv.invoiceNo.startsWith("#") ? inv.invoiceNo : "#" + inv.invoiceNo) : "#" + orderId;
            }
            const invDateEl = document.getElementById("invoice-date");
            if (invDateEl) {
                invDateEl.textContent = inv.invoiceDate || new Date().toLocaleDateString();
            }
            const invStatusEl = document.getElementById("invoice-status");
            if (invStatusEl) {
                invStatusEl.textContent = inv.invoiceStatus || "PAID";
            }

            // Populate customer info
            const bName = document.getElementById("buyer-name");
            if (bName) bName.textContent = inv.buyerName || "Customer";

            const bAddr = document.getElementById("buyer-address");
            if (bAddr) bAddr.textContent = inv.address || "Address Provided";

            const cName = document.getElementById("city-name");
            if (cName) cName.textContent = inv.cityName || "Sri Lanka";

            const coName = document.getElementById("country-name");
            if (coName) coName.textContent = inv.countryName || "Sri Lanka";

            const bEmail = document.getElementById("buyer-email");
            if (bEmail) bEmail.textContent = inv.email || "";

            // Populate items
            const tbody = document.getElementById("item-tbody");
            if (tbody) {
                tbody.innerHTML = "";

                let subtotal = 0;
                if (inv.invoiceItemDTOList && inv.invoiceItemDTOList.length > 0) {
                    inv.invoiceItemDTOList.forEach(function(item, index) {
                        const lineTotal = (item.itemPrice || 0) * (item.itemQty || 1);
                        subtotal += lineTotal;

                        const tr = document.createElement("tr");
                        tr.innerHTML = 
                            '<td class="text-muted fw-bold">' + (index + 1) + '</td>' +
                            '<td><div class="fw-bold text-dark">' + (item.itemName || 'Product') + '</div></td>' +
                            '<td class="text-center fw-semibold">' + (item.itemQty || 1) + '</td>' +
                            '<td class="text-end">Rs. ' + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(item.itemPrice || 0) + '</td>' +
                            '<td class="text-end fw-bold text-dark">Rs. ' + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(lineTotal) + '</td>';
                        tbody.appendChild(tr);
                    });
                } else {
                    tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-3">No items found for this order.</td></tr>';
                }

                // Populate totals
                const shipping = inv.shippingCharges || 0;
                const grandTotal = subtotal + shipping;

                const subEl = document.getElementById("subtotal");
                if (subEl) subEl.textContent = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(subtotal);

                const shipEl = document.getElementById("shipping-charges");
                if (shipEl) shipEl.textContent = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(shipping);

                const totEl = document.getElementById("total");
                if (totEl) totEl.textContent = new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(grandTotal);
            }

        } else {
            if (typeof Notiflix !== 'undefined' && Notiflix.Notify) {
                Notiflix.Notify.failure(data.message || "Failed to load invoice details");
            }
            const tbody = document.getElementById("item-tbody");
            if (tbody) tbody.innerHTML = '<tr><td colspan="5" class="text-center text-danger py-3">' + (data.message || 'Invoice details not available') + '</td></tr>';
        }
    } catch (err) {
        console.error("Failed to load invoice:", err);
        if (typeof Notiflix !== 'undefined' && Notiflix.Notify) {
            Notiflix.Notify.failure("Network error loading invoice");
        }
        const tbody = document.getElementById("item-tbody");
        if (tbody) tbody.innerHTML = '<tr><td colspan="5" class="text-center text-danger py-3">Error loading invoice data. Please refresh.</td></tr>';
    } finally {
        if (typeof Notiflix !== 'undefined' && Notiflix.Loading) {
            Notiflix.Loading.remove();
        }
    }
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", fetchAndRenderInvoice);
} else {
    fetchAndRenderInvoice();
}
