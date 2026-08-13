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
import lk.jiat.ElectroZone.annotation.IsAdmin;
import lk.jiat.ElectroZone.entity.User;
import lk.jiat.ElectroZone.util.Env;

import java.io.IOException;

@Provider
@Priority(Priorities.AUTHORIZATION)
@IsAdmin
public class AdminAuthFilter implements ContainerRequestFilter {
    @Context
    private HttpServletRequest request;

    @Override
    public void filter(ContainerRequestContext containerRequestContext) throws IOException {
        HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("user") == null) {
            containerRequestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).build());
            return;
        }

        User user = (User) httpSession.getAttribute("user");
        String adminEmail = Env.get("app.mail");
        if(adminEmail == null) adminEmail = "admin@electrozone.lk";

        if (!user.getEmail().equals(adminEmail) && !user.getEmail().equals("admin@electro.zone")) {
            containerRequestContext.abortWith(Response.status(Response.Status.FORBIDDEN).build());
        }
    }
}
