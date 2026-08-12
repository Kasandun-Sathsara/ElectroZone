package lk.jiat.ElectroZone.util;

import com.google.gson.Gson;

import java.security.SecureRandom;

public class AppUtil {
    public static final Gson GSON = new Gson();
    public static final int DEFAULT_SELECTOR_VALUE = 0;
    public static final int FIRST_RESULT_VALUE = 0;
    public static final int MAX_RESULT_VALUE = 10;
    public static final int DEFAULT_RATING_VALUE = 0;

    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    public static String generateCode() {
        int randomNumber = SECURE_RANDOM.nextInt(1_000_000);
        return String.format("%6d", randomNumber);
    }
}
