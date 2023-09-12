package com.mat.zip.boss.service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Base64;

@Service
public class PaymentService {
	
	
    public JsonObject processPayment(String paymentKey, int amount, String orderId) {
        String secretKey = "test_sk_ODnyRpQWGrNP2J6GZve3Kwv1M9EN"; 
        String encodedSecretKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost("https://api.tosspayments.com/v1/payments/confirm");
            httpPost.setHeader("Authorization", "Basic " + encodedSecretKey);
            httpPost.setHeader("Content-Type", "application/json");
            String json = "{\"paymentKey\":\"" + paymentKey + "\",\"amount\":" + amount + ",\"orderId\":\"" + orderId + "\"}";
            StringEntity entity = new StringEntity(json);
            httpPost.setEntity(entity);
            HttpResponse response = client.execute(httpPost);

            // 결제 처리 성공 시 JsonObject를 반환
            if (response.getStatusLine().getStatusCode() == 200) {
                HttpEntity responseEntity = response.getEntity();
                String responseBody = EntityUtils.toString(responseEntity);
                return JsonParser.parseString(responseBody).getAsJsonObject();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 결제 처리 실패 시 null을 반환
        return null;
    }
    
  
}


