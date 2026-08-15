package lk.jiat.ElectroZone.util;

import jakarta.ws.rs.core.MultivaluedMap;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Locale;

public class PayHereUtil {
    private static final String MERCHANT_ID = Env.get("payhere.merchant.id");
    private static final String MERCHANT_SECRET = Env.get("payhere.merchant.secret");
    public static final String APP_CURRENCY = "LKR";
    public static final String APP_COUNTRY = "Sri Lanka";
    public static final int PAYMENT_SUCCESS = 2;

    public static String getMerchantId() {
        return MERCHANT_ID;
    }

    public static String generateHash(String orderId, double amount) {
        String formattedAmount = String.format(Locale.US, "%.2f", amount);
        String secretHash = md5(PayHereUtil.MERCHANT_SECRET).toUpperCase();
        String raw = PayHereUtil.MERCHANT_ID +
                orderId +
                formattedAmount +
                PayHereUtil.APP_CURRENCY +
                secretHash;
        return md5(raw).toUpperCase();
    }

    public static boolean validateNotify(MultivaluedMap<String, String> form) {

        String merchantId = form.getFirst("merchant_id");
        String orderId = form.getFirst("order_id");
        String payHereAmount = form.getFirst("payhere_amount");
        String payHereCurrency = form.getFirst("payhere_currency");
        String statusCode = form.getFirst("status_code");
        String md5Sig = form.getFirst("md5sig");
        String localSignature = md5(merchantId +
                orderId +
                payHereAmount +
                payHereCurrency +
                statusCode +
                md5(PayHereUtil.MERCHANT_SECRET).toUpperCase()).toUpperCase();
        return localSignature.equals(md5Sig) && Integer.parseInt(statusCode) == PayHereUtil.PAYMENT_SUCCESS;
    }

    private static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("md5");
            byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b)); 
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 ERROR: " + e);
        }
    }

}
