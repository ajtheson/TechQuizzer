package util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class EmailValidator {

    private static final String API_KEY = "ac027509bd624a7db667429a46316344";

    public static boolean isEmailValid(String email) {
        try {
            String apiUrl = "https://emailvalidation.abstractapi.com/v1/?api_key=" + API_KEY + "&email=" + email;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;

            while ((line = in.readLine()) != null) {
                response.append(line);
            }
            in.close();

            // Parse JSON với Jackson
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(response.toString());

            String deliverability = rootNode.path("deliverability").asText();

            return "DELIVERABLE".equalsIgnoreCase(deliverability);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
