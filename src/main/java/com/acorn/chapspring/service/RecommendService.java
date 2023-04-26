package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.RecommendStoreDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface RecommendService {
    int add(RecommendStoreDto recommendStore);
    int delete(RecommendStoreDto recommendStore);
    List<RecommendStoreDto> recommendList(String userId);
}
