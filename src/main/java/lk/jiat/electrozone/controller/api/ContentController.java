package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.CityService;
import lk.jiat.ElectroZone.service.ContentService;

@Path("/data")
public class ContentController {

    @Path("/new-arrivals")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadNewArrivals() {
        String responseJson = new ContentService().loadNewArrivalProducts();
        return Response.ok().entity(responseJson).build();
    }

    @Path("/deals")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadDeals() {
        String responseJson = new ContentService().loadDealsProducts();
        return Response.ok().entity(responseJson).build();
    }

    @Path("/cities")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadCities() {
        String loadAllCities = new CityService().loadAllCities();
        return Response.ok().entity(loadAllCities).build();
    }

    @Path("/categories")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadCategories() {
        String responseJson = new ContentService().loadCategories();
        return Response.ok().entity(responseJson).build();
    }

    @Path("/brands")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadBrands() {
        String responseJson = new ContentService().loadBrandDetails();
        return Response.ok().entity(responseJson).build();
    }

    @Path("/{brandId}/models")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadModels(@PathParam("brandId") int id) {
        String responseJson = new ContentService().loadModelDetails(id);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/specifications")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadSpecifications() {
        String responseJson = new ContentService().loadProductSpecifications();
        return Response.ok().entity(responseJson).build();
    }
}
