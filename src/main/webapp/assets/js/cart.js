async function addToCart(stockId, qty) {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });
        const response = await fetch(`api/carts/add-to-cart?sId=${stockId}&qty=${qty}`);
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                Notiflix.Notify.success(data.message, {
                    position: 'center-top'
                });
                await loadCartItems();
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Add to cart process failed!", {
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

async function loadCartItems() {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });

        const response = await fetch("api/carts/all-carts");
        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                console.log(data);
                Notiflix.Notify.success(data.message, {
                    position: 'center-top'
                });
                renderingMainPanel(data.cartItems);
                renderingSidePanel(data.cartItems);
            } else {
                Notiflix.Notify.info(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Cart items loading failed!", {
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

function renderingMainPanel(cartItems) {
    const cartItemContainer = document.getElementById("cart-item-container");
    if (cartItemContainer) {
        cartItemContainer.innerHTML = "";

        let total = 0;
        let totalQty = 0;

        cartItems.forEach((cart) => {
            let itemsTotal = parseFloat(cart.price) * parseInt(cart.qty);
            total += itemsTotal;
            totalQty += parseInt(cart.qty);
            cartItemContainer.innerHTML += `
                <div class="card border-0 shadow-sm rounded-4 mb-3 p-3 position-relative">
                    <div class="row align-items-center gy-3">
                        <div class="col-12 col-md-5 d-flex align-items-center gap-3">
                            <div class="bg-light rounded-3 p-2 d-flex align-items-center justify-content-center mix-blend-multiply" style="width: 90px; height: 90px; flex-shrink: 0;">
                                <img src="${cart.images[0]}" alt="${cart.productTitle}" class="img-fluid" style="max-height: 100%;">
                            </div>
                            <div>
                                <h6 class="fw-bold fs-6 mb-1">${cart.productTitle}</h6>
                            </div>
                        </div>
                        
                        <div class="col-6 col-md-3 text-md-center">
                            <span class="d-md-none text-muted fs-7 me-2">Price:</span>
                            <span class="fw-medium text-dark">LKR ${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(cart.price)}</span>
                        </div>
                        
                        <div class="col-6 col-md-2 d-flex justify-content-md-center justify-content-end">
                            <div class="qty-selector-pill d-flex align-items-center bg-light rounded-pill px-2 py-1 border">
                                <span class="fw-bold mx-3 fs-7">${cart.qty}</span>
                            </div>
                        </div>
                        
                        <div class="col-12 col-md-2 text-md-end text-center mt-3 mt-md-0 d-flex flex-column align-items-md-end align-items-center">
                            <div class="mb-1">
                                <span class="text-dark fw-bold fs-8">LKR</span><br class="d-none d-md-block">
                                <span class="fw-bold fs-6">${new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(itemsTotal)}</span>
                            </div>
                            <button class="btn text-muted p-0 mt-2 hover-danger" onclick="removeCartItem(${cart.cartId});"><i class="bi bi-trash-fill fs-5"></i></button>
                        </div>
                    </div>
                </div>`;
        });
        
        let qtyEl = document.getElementById("order-total-quantity");
        if(qtyEl) qtyEl.innerHTML = totalQty;
        
        let amountEl = document.getElementById("order-total-amount");
        if(amountEl) amountEl.innerHTML = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(total);
        
        let finalEl = document.getElementById("order-final-amount");
        if(finalEl) finalEl.innerHTML = "LKR " + new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(total);
    }
}

function renderingSidePanel(cartItems) {
    const side_panel_cart_item_list = document.getElementById("side-panal-cart-item-list");
    if (side_panel_cart_item_list) {
        side_panel_cart_item_list.innerHTML = "";
        let total = 0;
        let totalQty = 0;
        cartItems.forEach(cart => {
            let productSubTotal = cart.price * cart.qty;
            total += productSubTotal;
            totalQty += cart.qty;
            let cartItem = `<li class="cart-item">
                    <div class="item-img">
                        <a href="single-product.jsp?productId=${cart.stockId}">
                        <img src="${cart.images[0]}" alt=""></a>
                        <button class="close-btn" onclick="removeCartItem(${cart.cartId});"><i class="fas fa-times"></i></button>
                    </div>
                    <div class="item-content">
                        <h3 class="item-title"><a href="#">${cart.productTitle}</a></h3>
                        <div class="item-price"><span class="currency-symbol">Rs. </span>${new Intl.NumberFormat(
                "en-US",
                {minimumFractionDigits: 2})
                .format(cart.price)}</div>
                        <div class="pro-qty item-quantity">
                            <input type="number" class="quantity-input" value="${cart.qty}">
                        </div>
                    </div>
                </li>`;
            side_panel_cart_item_list.innerHTML += cartItem;
        });
        document.getElementById("side-panel-cart-sub-total").innerHTML = new Intl.NumberFormat("en-US",
            {minimumFractionDigits: 2})
            .format(total);
        document.getElementById("cart-count").innerHTML = totalQty;
    }
}

async function removeCartItem(cartId) {
    try {
        Notiflix.Loading.pulse("Wait...", {
            clickToClose: false,
            svgColor: '#0284c7'
        });

        const response = await fetch(`api/carts/remove-cart/${cartId}`, {
            method: "DELETE"
        });

        if (response.ok) {
            const data = await response.json();
            if (data.status) {
                Notiflix.Notify.success(data.message, {
                    position: 'center-top'
                });
                window.location.reload();
            } else {
                Notiflix.Notify.failure(data.message, {
                    position: 'center-top'
                });
            }
        } else {
            Notiflix.Notify.failure("Cart item removing failed!", {
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
