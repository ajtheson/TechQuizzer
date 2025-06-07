package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;

public class PasswordEncoder {
    private static final String SALT = "secretSalt";
    public static String encode(String str) {
        try {
            str = str + SALT;
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(str.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException("Hashing error", e);
        }
    }

    public static void main(String[] args) {
        System.out.println(encode("123456789"));
    }
}
