package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.OrderService;

@Path("/orders")
public class OrderController {
    private final OrderService orderService = new OrderService();
    @Path("/verify-order")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response verifyOrder(@QueryParam("orderId")String orderId){
        String responseJson = orderService.verifyOrderDetails(orderId);
        return Response.ok().entity(responseJson).build();
    }
}

