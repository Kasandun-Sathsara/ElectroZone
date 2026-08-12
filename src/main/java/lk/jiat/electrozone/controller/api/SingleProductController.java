package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.SingleProductService;

@Path("/single-products")
public class SingleProductController {
    private final SingleProductService singleProductService = new SingleProductService();

    @Path("/similar-products")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadSimilarProducts(@QueryParam("productId") String sId) {
        String responseJson = singleProductService.getSimilarProducts(sId);
        return Response.ok().entity(responseJson).build();
    }

    @Path("/product")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response loadSingleProduct(@QueryParam("productId") String productId) {
        String responseJson = singleProductService.getSingleProduct(productId);
        return Response.ok().entity(responseJson).build();
    }
}
