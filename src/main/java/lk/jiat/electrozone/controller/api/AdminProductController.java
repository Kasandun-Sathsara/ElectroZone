package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Context;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.service.AdminService;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.dto.ProductDTO;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import org.glassfish.jersey.media.multipart.BodyPart;

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

    @IsAdmin
    @Path("/save-product")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response saveAdminProduct(
            @FormDataParam("product") String productJson,
            @FormDataParam("images[]") FormDataBodyPart dummyBodyPart,
            @Context ServletContext context,
            @Context HttpServletRequest request) {
        
        ProductDTO productDTO = AppUtil.GSON.fromJson(productJson, ProductDTO.class);

        List<BodyPart> imageParts = new ArrayList<>();
        if (dummyBodyPart != null && dummyBodyPart.getParent() != null) {
            imageParts = dummyBodyPart.getParent().getBodyParts().stream()
                .filter(part -> {
                    String cdName = part.getContentDisposition().getParameters().get("name");
                    return "images[]".equals(cdName) && part.getContentDisposition().getFileName() != null;
                })
                .collect(Collectors.toList());
        }
        
        String responseJson = adminService.addNewProductAdmin(productDTO, imageParts, context);
        return Response.ok().entity(responseJson).build();
    }

    @IsAdmin
    @Path("/update-product")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateAdminProduct(
            @FormDataParam("product") String productJson,
            @FormDataParam("images[]") FormDataBodyPart dummyBodyPart,
            @Context ServletContext context,
            @Context HttpServletRequest request) {
        
        ProductDTO productDTO = AppUtil.GSON.fromJson(productJson, ProductDTO.class);
        
        List<BodyPart> imageParts = new ArrayList<>();
        if (dummyBodyPart != null && dummyBodyPart.getParent() != null) {
            imageParts = dummyBodyPart.getParent().getBodyParts().stream()
                .filter(part -> {
                    String cdName = part.getContentDisposition().getParameters().get("name");
                    return "images[]".equals(cdName) && part.getContentDisposition().getFileName() != null && !part.getContentDisposition().getFileName().isEmpty();
                })
                .collect(Collectors.toList());
        }
        
        String responseJson = adminService.updateProductAdmin(productDTO, imageParts, context);
        return Response.ok().entity(responseJson).build();
    }

    @IsAdmin
    @Path("/add-brand")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addBrand(@FormDataParam("name") String name) {
        String response = adminService.addNewBrand(name);
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/add-model")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addModel(@FormDataParam("name") String name, @FormDataParam("brandId") int brandId) {
        String response = adminService.addNewModel(name, brandId);
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/add-storage")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addStorage(@FormDataParam("value") String value) {
        String response = adminService.addNewStorage(value);
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/add-color")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addColor(@FormDataParam("value") String value) {
        String response = adminService.addNewColor(value);
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/add-quality")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addQuality(@FormDataParam("value") String value) {
        String response = adminService.addNewQuality(value);
        return Response.ok().entity(response).build();
    }

    @IsAdmin
    @Path("/add-category")
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addCategory(@FormDataParam("name") String name) {
        String response = adminService.addNewCategory(name);
        return Response.ok().entity(response).build();
    }
}
