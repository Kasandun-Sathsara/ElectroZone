package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.service.AdminService;

@Path("/admin/customers")
public class AdminCustomerController {

    private final AdminService adminService = new AdminService();

    @IsAdmin
    @Path("/all")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllCustomers() {
        String response = adminService.getAllCustomers();
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/{id}/status")
    @PUT
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateCustomerStatus(@PathParam("id") int id, @FormParam("status") String statusName) {
        String response = adminService.updateCustomerStatus(id, statusName);
        return Response.ok().entity(response).build();
    }
}
