package lk.jiat.ElectroZone.middleware;

import jakarta.annotation.Priority;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.Priorities;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.Provider;
import lk.jiat.ElectroZone.annotation.IsUser;
import lk.jiat.ElectroZone.util.Env;

import java.io.IOException;
import java.net.URI;

@Provider
@Priority(Priorities.AUTHENTICATION)
@IsUser
public class AuthFilter implements ContainerRequestFilter {
    @Context
    private HttpServletRequest request;

    @Override
    public void filter(ContainerRequestContext containerRequestContext) throws IOException {
        HttpSession httpSession = request.getSession(false);
        System.out.println(request.getContextPath());
        if (httpSession == null || httpSession.getAttribute("user") == null) {
            com.google.gson.JsonObject jsonObject = new com.google.gson.JsonObject();
            jsonObject.addProperty("message", "Please login first");
            containerRequestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED)
                    .entity(jsonObject.toString())
                    .type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON)
                    .build());
        }

    }
}
