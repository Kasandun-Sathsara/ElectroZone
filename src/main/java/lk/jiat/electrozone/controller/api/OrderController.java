package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Context;
import jakarta.servlet.http.HttpServletRequest;
import lk.jiat.ElectroZone.annotation.IsUser;
import lk.jiat.ElectroZone.service.OrderService;

@Path("/orders")
public class OrderController {
    private final OrderService orderService = new OrderService();

    @IsUser
    @Path("/my")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMyOrders(@Context HttpServletRequest request) {
        String responseJson = orderService.getUserOrders(request);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/verify-order")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response verifyOrder(@QueryParam("orderId")String orderId){
        String responseJson = orderService.verifyOrderDetails(orderId);
        return Response.ok().entity(responseJson).build();
    }
}

