package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoresDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MainService {
    StoreServiceImp findByReviewsCount(String storeName);


}
