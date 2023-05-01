package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoresDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MainService {
    StoresDto getStoreByStoreReviews(String siAdd,String guAdd);
    StoresDto getStoreByCafeReviews(String siAdd,String guAdd);
    StoresDto getStoreByPubReviews(String siAdd,String guAdd);
}
