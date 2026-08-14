package lk.jiat.ElectroZone.controller.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.service.AdminService;

@Path("/admin")
public class AdminController {
    private final AdminService adminService = new AdminService();

    @IsAdmin
    @Path("/dashboard-stats")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getDashboardStats(@Context HttpServletRequest request) {
        String response = adminService.getDashboardStats();
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/customers/all")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllCustomers() {
        String response = adminService.getAllCustomers();
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/customers/{id}/status")
    @jakarta.ws.rs.PUT
    @jakarta.ws.rs.Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateCustomerStatus(@jakarta.ws.rs.PathParam("id") int id, @jakarta.ws.rs.FormParam("status") String statusName) {
        String response = adminService.updateCustomerStatus(id, statusName);
        return Response.ok().entity(response).build();
    }
}
