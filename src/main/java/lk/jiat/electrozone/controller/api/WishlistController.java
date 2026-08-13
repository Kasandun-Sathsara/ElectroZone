package lk.jiat.ElectroZone.controller.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.annotation.IsUser;
import lk.jiat.ElectroZone.service.WishlistService;

@Path("/wishlist")
public class WishlistController {
    
    @IsUser
    @Path("/add")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response addToWishlist(@QueryParam("sId") String sId, @Context HttpServletRequest request) {
        String responseJson = new WishlistService().addToWishlist(sId, request);
        return Response.ok().entity(responseJson).build();
    }

    @IsUser
    @Path("/all")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadWishlist(@Context HttpServletRequest request) {
        String responseJson = new WishlistService().loadWishlist(request);
        return Response.ok().entity(responseJson).build();
    }

    @IsUser
    @Path("/remove/{id}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response removeWishlist(@PathParam("id") String id, @Context HttpServletRequest request) {
        String responseJson = new WishlistService().removeWishlist(id, request);
        return Response.ok().entity(responseJson).build();
    }
    
    @IsUser
    @Path("/clear")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response clearWishlist(@Context HttpServletRequest request) {
        String responseJson = new WishlistService().clearWishlist(request);
        return Response.ok().entity(responseJson).build();
    }
}
