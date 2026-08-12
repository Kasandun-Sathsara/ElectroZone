package lk.jiat.ElectroZone.controller.api;

import com.google.gson.JsonObject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.AdvancedSearchService;
import lk.jiat.ElectroZone.util.AppUtil;

@Path("/advanced-search")
public class AdvancedSearchController {
    private final AdvancedSearchService advancedSearchService = new AdvancedSearchService();

    @Path("/get-by-brand")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadBrandSearchData(@QueryParam("brId")String brId, @QueryParam("brName")String brName){
        String responseJson = advancedSearchService.getBrandSearchData(brId, brName);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/search-data")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadAdvancedSearchData(String requestJson) {
        JsonObject requestObject = AppUtil.GSON.fromJson(requestJson, JsonObject.class);
        String responseJson = advancedSearchService.getAdvancedSearchData(requestObject);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/all-data")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadAdvancedSearchData() {
        String responseJson = advancedSearchService.getAllProductData();
        return Response.ok().entity(responseJson).build();
    }
}

