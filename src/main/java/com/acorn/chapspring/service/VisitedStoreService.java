package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.VisitedStoreDto;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface VisitedStoreService {
    List<VisitedStoreDto> visited(String userId);//유저 방문조회
}
