package lk.jiat.ElectroZone.config;

import org.glassfish.jersey.server.ResourceConfig;
import jakarta.ws.rs.ApplicationPath;

@ApplicationPath("/api")
public class AppConfig extends ResourceConfig {
    public AppConfig() {
        packages("lk.jiat.ElectroZone.controller"); // For TestController
        packages("lk.jiat.ElectroZone.middleware"); // To register filters like @IsUser
        register(org.glassfish.jersey.media.multipart.MultiPartFeature.class);
    }
}
