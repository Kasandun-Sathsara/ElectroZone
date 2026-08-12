package lk.jiat.ElectroZone.controller;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/test")
public class TestController {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String test() {
        return "ElectroZone JAX-RS API is working!";
    }
}
