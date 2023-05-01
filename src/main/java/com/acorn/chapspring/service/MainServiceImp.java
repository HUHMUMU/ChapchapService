package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.mapper.MainSearchMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class MainServiceImp implements MainService{

    private MainSearchMapper mainSearchMapper;

    @Override
    public StoresDto getStoreByStoreReviews(String siAdd, String guAdd) {
        return mainSearchMapper.findByStoreReviewsOne(siAdd, guAdd);
    }

    @Override
    public StoresDto getStoreByCafeReviews(String siAdd, String guAdd) {
        return mainSearchMapper.findByCafeReviewsOne(siAdd, guAdd);
    }

    @Override
    public StoresDto getStoreByPubReviews(String siAdd, String guAdd) {
        return mainSearchMapper.findByPubReviewsOne(siAdd, guAdd);
    }
}