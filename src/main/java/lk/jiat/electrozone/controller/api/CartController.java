package lk.jiat.ElectroZone.controller.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.CartService;

@Path("/carts")
public class CartController {
    private final CartService cartService = new CartService();

    @Path("/remove-cart/{cartId}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response removeCartItem(@PathParam("cartId") String cartId, @Context HttpServletRequest request) {
        String responseJson = cartService.deleteCartItem(cartId, request);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/all-carts")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadAllCarts(@Context HttpServletRequest request) {
        String responseJson = cartService.getAllUserCarts(request);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/add-to-cart")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response addToCart(@QueryParam("sId") String sId,
                              @QueryParam("qty") String qty,
                              @Context HttpServletRequest request) {
        String responseJson = cartService.addToCart(sId, qty, request);
        return Response.ok().entity(responseJson).build();
    }

}
