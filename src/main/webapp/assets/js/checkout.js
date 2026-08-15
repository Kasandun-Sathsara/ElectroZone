let checkoutData = null;

window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", { clickToClose: false, svgColor: '#0284c7' });
        await loadCheckoutData();
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadCheckoutData() {
    try {
        const response = await fetch("api/checkouts/user-checkout-data");
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                checkoutData = data;
                renderOrderSummary();
                populateAddressForm();
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
                if (data.message === "Please login first!") {
                    window.location.href = "login.jsp";
                }
            }
        }
    } catch (e) {
        console.error("Checkout data loading failed:", e);
    }
}

function renderOrderSummary() {
    const cartList = checkoutData.cartList;
    const sellerList = checkoutData.sellerList;
    const deliveryTypes = checkoutData.deliveryTypes;
    const userAddress = checkoutData.userPrimaryAddress;
    
    let subtotal = 0;
    let shipping = 0;
    let total = 0;

    let withinCityCost = deliveryTypes.find(d => d.name === "WITHIN_CITY")?.price || 0;
    let outOfCityCost = deliveryTypes.find(d => d.name === "OUT_OF_CITY")?.price || 0;

    const summaryContainer = document.getElementById("checkout-order-items");
    if (summaryContainer) {
        summaryContainer.innerHTML = "";
        cartList.forEach((cartItem, index) => {
            const seller = sellerList[index];
            let itemTotal = cartItem.price * cartItem.qty;
            subtotal += itemTotal;
            
            let itemShipping = 0;
            if (userAddress && seller.cityDTO) {
                if (userAddress.cityDTO.name === seller.cityDTO.name) {
                    itemShipping = withinCityCost;
                } else {
                    itemShipping = outOfCityCost;
                }
            }
            shipping += itemShipping;
            
            let imageSrc = cartItem.images && cartItem.images.length > 0 ? cartItem.images[0] : 'assets/img/default-product.png';
            
            summaryContainer.innerHTML += `
                <div class="d-flex align-items-center mb-4 pb-2 border-bottom border-light">
                    <div class="item-thumbnail me-3 position-relative">
                        <img src="${imageSrc}" alt="${cartItem.productTitle}" class="img-fluid mix-blend-multiply" style="max-height: 48px;">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary" style="font-size: 0.6rem;">${cartItem.qty}</span>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="fw-bold fs-7 mb-1" style="max-height: 2.4em; overflow: hidden;">${cartItem.productTitle}</h6>
                        <p class="text-muted fs-8 mb-0">Qty: ${cartItem.qty}</p>
                    </div>
                    <div class="fw-bold fs-7 text-dark text-end ms-2" style="min-width: 80px;">LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(itemTotal)}</div>
                </div>
            `;
        });
    }
    
    total = subtotal + shipping;
    
    document.getElementById("checkout-subtotal").textContent = `LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(subtotal)}`;
    document.getElementById("checkout-shipping").textContent = `LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(shipping)}`;
    document.getElementById("checkout-total").textContent = `${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(total)}`;
}

function populateAddressForm() {
    const address = checkoutData.userPrimaryAddress;
    if (address) {
        document.getElementById("firstName").value = address.firstName;
        document.getElementById("lastName").value = address.lastName;
        document.getElementById("mobile").value = address.mobile;
        document.getElementById("lineOne").value = address.lineOne;
        document.getElementById("lineTwo").value = address.lineTwo || "";
        document.getElementById("postalCode").value = address.postalCode;

        toggleAddressFields(true);
        document.getElementById("usePrimaryAddressCheckbox").checked = true;
    }
}

function toggleAddressFields(disabled) {
    document.getElementById("firstName").disabled = disabled;
    document.getElementById("lastName").disabled = disabled;
    document.getElementById("mobile").disabled = disabled;
    document.getElementById("lineOne").disabled = disabled;
    document.getElementById("lineTwo").disabled = disabled;
    document.getElementById("postalCode").disabled = disabled;
    document.getElementById("citySelect").disabled = disabled;
}

document.getElementById("usePrimaryAddressCheckbox")?.addEventListener("change", (e) => {
    toggleAddressFields(e.target.checked);
});

async function processCheckout() {
    try {
        const isCurrentAddress = document.getElementById("usePrimaryAddressCheckbox") ? document.getElementById("usePrimaryAddressCheckbox").checked : false;
        
        const requestData = {
            isCurrentAddress: isCurrentAddress,
            firstName: document.getElementById("firstName").value,
            lastName: document.getElementById("lastName").value,
            mobile: document.getElementById("mobile").value,
            lineOne: document.getElementById("lineOne").value,
            lineTwo: document.getElementById("lineTwo").value + (document.getElementById("districtSelect") && document.getElementById("districtSelect").value !== "0" ? ", " + document.getElementById("districtSelect").value : ""),
            postalCode: document.getElementById("postalCode").value,
            cityId: isCurrentAddress ? 0 : parseInt(document.getElementById("citySelect").value || "0")
        };
        
        if (!isCurrentAddress && requestData.cityId === 0) {
            Notiflix.Notify.warning("Please select a city", { position: 'center-top' });
            return;
        }

        Notiflix.Loading.pulse("Processing Order...", { clickToClose: false, svgColor: '#0284c7' });
        
        const response = await fetch("api/checkouts/user-checkout", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(requestData)
        });
        
        if (response.ok) {
            const data = await response.json();
            if (data.status) {

                payhere.onCompleted = async function onCompleted(orderId) {
                    Notiflix.Notify.success("Payment completed. OrderID:" + orderId, { position: 'center-top' });

                    try {
                        await fetch("api/payments/return?order_id=" + orderId);
                    } catch(e) { console.error("Return call error:", e); }
                    window.location.href = "invoice.jsp?orderId=" + orderId;
                };
                payhere.onDismissed = function onDismissed() {
                    Notiflix.Notify.info("Payment dismissed", { position: 'center-top' });
                };
                payhere.onError = function onError(error) {
                    Notiflix.Notify.failure("Payment Error: " + error, { position: 'center-top' });
                };
                
                payhere.startPayment(data.paymentDetails);
            } else {
                Notiflix.Notify.failure(data.message, { position: 'center-top' });
            }
        }
    } catch (e) {
        console.error("Checkout failed:", e);
        Notiflix.Notify.failure(e.message, { position: 'center-top' });
    } finally {
        Notiflix.Loading.remove();
    }
}
