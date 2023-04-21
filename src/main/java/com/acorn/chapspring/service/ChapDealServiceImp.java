package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapDealDto;
import com.acorn.chapspring.mapper.ChapDealMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@AllArgsConstructor
public class ChapDealServiceImp implements ChapDealService {
    private ChapDealMapper chapDealMapper;

    //모든 가게의 모든 이벤트
    @Override
    public List<ChapDealDto> list() {
        List<ChapDealDto> list=chapDealMapper.findAll();
        return list;
    }

}
