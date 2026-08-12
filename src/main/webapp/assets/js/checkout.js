window.addEventListener("load", async () => {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });
        await loadCities();
        await loadCheckoutData();
    } finally {
        Notiflix.Loading.remove();
    }
});

async function loadCheckoutData() {
    try {
        const response = await fetch("api/checkouts/user-checkout-data")
        if (response.redirected) {
            Notiflix.Report.info(
                'Checkout Info Message',
                'Please login first!',
                'Ok',
                () => {
                    window.location = "sign-in.jsp";
                }
            );
            return;
        }
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                console.log(data);
                fillUserCurrentAddress(data.userPrimaryAddress);
                makeOrderSummary(data);
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Checkout data loading failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    }
}

function makeOrderSummary(data) {
    const cartList = data.cartList;
    const deliveryTypes = data.deliveryTypes;
    const sellerList = data.sellerList;

    let tableBody = document.getElementById("st-tbody");
    let itemRow = document.getElementById("st-item-tr");
    let subtotalRow = document.getElementById("st-subtotal-tr");
    let orderShippingRow = document.getElementById("st-order-shipping-tr");
    let orderTotalRow = document.getElementById("st-order-total-tr");

    tableBody.innerHTML = "";
    let total = 0;
    let itemCount = 0;
    cartList.forEach((item) => {
        let itemRowClone = itemRow.cloneNode(true);
        itemRowClone.querySelector("#st-product-title").textContent = item.productTitle;
        itemRowClone.querySelector("#st-product-qty").textContent = item.qty;
        let subTotal = parseFloat(item.price) * parseInt(item.qty);

        itemRowClone.querySelector("#st-product-price").textContent = new Intl.NumberFormat("en-US", {
            minimumFractionDigits: 2
        }).format(subTotal);
        tableBody.appendChild(itemRowClone);
        total += subTotal;
        itemCount += item.qty;
    });

    subtotalRow.querySelector("#st-product-total-amount").textContent = new Intl.NumberFormat("en-US", {
        minimumFractionDigits: 2
    }).format(total);

    let citySelect = document.getElementById("city-select");
    citySelect.addEventListener("change", () => {
        let shippingCharges = 0;
        let cityName = citySelect.options[citySelect.selectedIndex]?.text || "";
        sellerList.forEach((seller) => {
            if (cityName === seller.cityDTO.name) {
                // Within city
                shippingCharges += deliveryTypes[0].price;
            } else {
                // out of city
                shippingCharges += deliveryTypes[1].price;
            }
        });
        orderShippingRow.querySelector("#st-product-shipping-charges").textContent = new Intl.NumberFormat("en-US", {
            minimumFractionDigits: 2
        }).format(shippingCharges);
        orderTotalRow.querySelector("#st-order-total-amount").textContent = new Intl.NumberFormat("en-US", {
            minimumFractionDigits: 2
        }).format(total + shippingCharges);
    });
    tableBody.appendChild(subtotalRow);
    tableBody.appendChild(orderShippingRow);
    tableBody.appendChild(orderTotalRow);
}

function fillUserCurrentAddress(address) {
    const currentAddressTick = document.getElementById("checkbox1");
    currentAddressTick.addEventListener("change", () => {
        let firstName = document.getElementById("first-name");
        let lastName = document.getElementById("last-name");
        let city = document.getElementById("city-select");
        let lineOne = document.getElementById("line-one");
        let lineTwo = document.getElementById("line-two");
        let postalCode = document.getElementById("postal-code");
        let mobile = document.getElementById("mobile");
        if (currentAddressTick.checked) {
            firstName.value = address.firstName;
            lastName.value = address.lastName;
            city.value = address.cityDTO.id;
            lineOne.value = address.lineOne;
            lineTwo.value = address.lineTwo;
            postalCode.value = address.postalCode;
            mobile.value = address.mobile;
            city.disabled = true;
            city.dispatchEvent(new Event("change"));
        } else {
            firstName.value = "";
            lastName.value = "";
            city.value = 0;
            lineOne.value = "";
            lineTwo.value = "";
            postalCode.value = "";
            mobile.value = "";
            city.disabled = false;
            city.dispatchEvent(new Event("change"));
        }
    });
}

async function loadCities() {
    try {
        const response = await fetch("api/data/cities");
        if (response.ok) {
            const data = await response.json();
            let citySelect = document.getElementById("city-select");
            citySelect.innerHTML = `<option value="0">Select</option>`;
            data.cities.forEach((city) => {
                let option = document.createElement("option");
                option.value = city.id;
                option.innerHTML = city.name;
                citySelect.appendChild(option);
            })
        } else {
            Notiflix.Notify.failure("City data loading failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    }
}

async function checkout() {
    let firstName = document.getElementById("first-name");
    let lastName = document.getElementById("last-name");
    let city = document.getElementById("city-select");
    let lineOne = document.getElementById("line-one");
    let lineTwo = document.getElementById("line-two");
    let postalCode = document.getElementById("postal-code");
    let mobile = document.getElementById("mobile");
    let currentAddressTick = document.getElementById("checkbox1");

    const checkoutData = {
        isCurrentAddress: currentAddressTick.checked,
        firstName: firstName.value,
        lastName: lastName.value,
        cityId: city.value,
        lineOne: lineOne.value,
        lineTwo: lineTwo.value,
        postalCode: postalCode.value,
        mobile: mobile.value,
    }
    const checkoutDataJSON = JSON.stringify(checkoutData);

    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });

        const response = await fetch("api/checkouts/user-checkout", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: checkoutDataJSON
        })
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                // console.log(data);
                payhere.startPayment(data.paymentDetails);
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Checkout process failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    } finally {
        Notiflix.Loading.remove();
    }
}

// Payment completed. It can be a successful failure.
payhere.onCompleted = async function onCompleted(orderId) {
    console.log("Payment completed. OrderID:" + orderId);
    // Note: validate the payment and show success or failure page to the customer
    await verifyOrder(orderId);
};

// Payment window closed
payhere.onDismissed = function onDismissed() {
    // Note: Prompt user to pay again or show an error page
    console.log("Payment dismissed");
};

// Error occurred
payhere.onError = function onError(error) {
    // Note: show an error page
    console.log("Error:" + error);
};

async function verifyOrder(orderId) {
    try {
        const response = await fetch(`api/orders/verify-order?orderId=${orderId}`);
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                window.location = `invoice.jsp?orderId=${orderId}`;
            } else {
                // redirect to failed page
            }

        } else {
            Notiflix.Notify.failure("Order verifying failed!", {
                position: 'center-top'
            });
        }
    } catch (e) {
        Notiflix.Notify.failure(e.message, {
            position: 'center-top'
        });
    }
}
