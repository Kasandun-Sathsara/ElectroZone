package lk.jiat.ElectroZone.config;

import org.glassfish.jersey.server.ResourceConfig;
import jakarta.ws.rs.ApplicationPath;

@ApplicationPath("/api")
public class AppConfig extends ResourceConfig {
    public AppConfig() {
        packages("lk.jiat.ElectroZone.controller"); 
        packages("lk.jiat.ElectroZone.middleware"); 
        register(org.glassfish.jersey.media.multipart.MultiPartFeature.class);
    }
}
