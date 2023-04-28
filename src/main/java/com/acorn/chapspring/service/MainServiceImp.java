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
    public StoresDto getStoreByAddressReviews(String siAdd, String guAdd) {
        return mainSearchMapper.findByAddressReviewsOne(siAdd, guAdd);
    }
}