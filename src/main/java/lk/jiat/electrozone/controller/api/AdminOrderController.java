package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.service.AdminService;

@Path("/admin/orders")
public class AdminOrderController {
    private final AdminService adminService = new AdminService();

    @IsAdmin
    @Path("/all")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllOrders() {
        String response = adminService.getAllOrders();
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/{id}/status")
    @PUT
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateOrderStatus(@PathParam("id") int id, @FormParam("status") String statusName) {
        String response = adminService.updateOrderStatus(id, statusName);
        return Response.ok().entity(response).build();
    }
}
