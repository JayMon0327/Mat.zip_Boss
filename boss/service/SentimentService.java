package com.mat.zip.boss.service;

import java.nio.charset.StandardCharsets;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class SentimentService {
    public JSONObject analyze(String requestBody) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        headers.set("X-NCP-APIGW-API-KEY-ID", "3uzmdwnb3e");
        headers.set("X-NCP-APIGW-API-KEY", "cfeIcnHDzQ5A9vq2Bj7ulYNqDnr7sLVw6MsxTBzO");
        headers.setContentType(new MediaType("application", "json", StandardCharsets.UTF_8)); //인코딩 형태는 고정. 

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        String url = "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze";
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        String responseBody = response.getBody();
        
        // 클라이언트에 응답 보내기전 UTF-8로 리턴해주기
        try {
            responseBody = new String(responseBody.getBytes("ISO-8859-1"), "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new JSONObject(responseBody);
    }
}



