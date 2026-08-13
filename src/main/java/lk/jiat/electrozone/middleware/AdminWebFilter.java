package lk.jiat.ElectroZone.middleware;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.ElectroZone.entity.User;
import lk.jiat.ElectroZone.util.Env;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminWebFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            User user = (User) httpSession.getAttribute("user");
            // Simple check: Admin email is from Env app.mail or hardcoded admin@electro.zone
            String adminEmail = Env.get("app.mail");
            if(adminEmail == null) adminEmail = "admin@electrozone.lk";
            
            if (user.getEmail().equals(adminEmail) || user.getEmail().equals("admin@electro.zone")) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
        
        // Not admin or not logged in, redirect to index
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
