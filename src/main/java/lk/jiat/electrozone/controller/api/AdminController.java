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
}
