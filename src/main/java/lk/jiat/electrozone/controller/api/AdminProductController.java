package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.service.AdminService;

@Path("/admin/products")
public class AdminProductController {
    private final AdminService adminService = new AdminService();

    @IsAdmin
    @Path("/all")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllProducts() {
        String response = adminService.getAllProducts();
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/{id}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteProduct(@PathParam("id") int id) {
        String response = adminService.deleteProduct(id);
        return Response.ok().entity(response).build();
    }
}
