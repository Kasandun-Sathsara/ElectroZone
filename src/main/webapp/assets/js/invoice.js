const params = new URLSearchParams(window.location.search);
const orderId = params.get("orderId");
window.addEventListener("load", async () => {
    if (orderId) {
        await loadInvoiceData(orderId);
    }
})

async function loadInvoiceData(orderId) {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });

        const response = await fetch(`api/invoices/user-invoice?orderId=${orderId}`);
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                console.log(data);
                const invoice = data.invoiceData;
                document.getElementById("invoice-no").innerHTML = `#${invoice.invoiceNo}`;
                document.getElementById("invoice-date").innerHTML = invoice.invoiceDate;
                document.getElementById("invoice-status").innerHTML = invoice.invoiceStatus;
                document.getElementById("buyer-name").innerHTML = invoice.buyerName;
                document.getElementById("buyer-address").innerHTML = invoice.address;
                document.getElementById("city-name").innerHTML = invoice.cityName;
                document.getElementById("country-name").innerHTML = invoice.countryName;
                document.getElementById("buyer-email").innerHTML = invoice.email;
                let itemBody = document.getElementById("item-tbody");
                let subtotal = 0;
                invoice.invoiceItemDTOList.forEach((item, index) => {
                    let totalItemPrice = item.itemPrice * item.itemQty;
                    itemBody.innerHTML += `<tr>
                        <th scope="row">${index + 1}</th>
                        <td>${item.itemName}</td>
                        <td class="text-center">${item.itemQty}</td>
                        <td class="text-end">Rs. ${new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2
                    }).format(item.itemPrice)}</td>
                        <td class="text-end">Rs. ${new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2
                    }).format(totalItemPrice)}</td>
                    </tr>`;
                    subtotal += totalItemPrice;
                });
                document.getElementById("subtotal").innerHTML = new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2
                }).format(subtotal);
                document.getElementById("shipping-charges").innerHTML = new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2
                }).format(invoice.shippingCharges);
                document.getElementById("total").innerHTML = new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2
                }).format(invoice.shippingCharges + subtotal);

            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Invoice Data loading failed!", {
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
