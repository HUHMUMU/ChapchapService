package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.RecommendStoreDto;
import com.acorn.chapspring.mapper.RecommendStoreMapper;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class RecommendServiceImp implements RecommendService{

    private RecommendStoreMapper recommendStoreMapper;

    @Override
    public int add(RecommendStoreDto recommendStore){
        int add=recommendStoreMapper.insertOneByUserId(recommendStore);
        return add;
    }
    @Override
    public int delete(RecommendStoreDto recommendStore){
        int delete=recommendStoreMapper.deleteOneByUserIdAndStoreNum(recommendStore);
        return delete;
    }
    @Override//유저 추천가게 조회
    public List<RecommendStoreDto> recommendList(String userId){
        List<RecommendStoreDto> list=recommendStoreMapper.findAllRecommendstoreByUserId(userId);
        return list;
    }
}
