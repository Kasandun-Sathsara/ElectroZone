package lk.jiat.ElectroZone.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Env {
    private static final Properties APP_PROPERTIES = new Properties();

    static {
        try {
            InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("app.properties");
            if (inputStream == null) {
                inputStream = Env.class.getResourceAsStream("/app.properties");
            }
            if (inputStream != null) {
                APP_PROPERTIES.load(inputStream);
            } else {
                System.err.println("WARNING: app.properties not found in classpath!");
            }
        } catch (IOException e) {
            System.err.println("Application properties loading failed: " + e.getMessage());
        }
    }

    public static String get(String key){
        return APP_PROPERTIES.getProperty(key);
    }
    public static Properties getAppProperties(){
        return APP_PROPERTIES;
    }
}
