package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.VisitedStoreDto;
import com.acorn.chapspring.mapper.VisitedStoreMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
@AllArgsConstructor
public class VisitedStoreServiceImp implements VisitedStoreService{
    private VisitedStoreMapper visitedStoreMapper;

    @Override//1.유저 방문 가게 리스트 **유저 고유 리스트 번호 속성 추가
    public List<VisitedStoreDto> visited(String userId) {
//        userMapper.setLoginUserId(loginUserId);
        List<VisitedStoreDto> list=visitedStoreMapper.findAllVisitedByUserId(userId);
        List<VisitedStoreDto> userVisitedList=new ArrayList<>(list.size());
        int listNum=0;
        for(VisitedStoreDto visitedList : list){
            listNum++;
            visitedList.setListNum(listNum);
            userVisitedList.add(visitedList);
        }
        return userVisitedList;
    }
}
