package com.mat.zip.boss.service.implementations;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mat.zip.boss.dao.boss_ReviewDAO;
import com.mat.zip.boss.service.boss_ReviewService;

import java.util.List;

@Service
public class boss_ReviewServiceImpl implements boss_ReviewService {
    @Autowired
    private boss_ReviewDAO reviewDAO;

    @Override
    public List<String> TotalReview(String storeId) {
        return reviewDAO.TotalReview(storeId);
    }
    
}
