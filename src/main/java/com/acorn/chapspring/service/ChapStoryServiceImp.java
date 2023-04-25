package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.mapper.ChapStoryMapper;
import com.acorn.chapspring.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChapStoryServiceImp implements ChapStoryService{
    private ChapStoryMapper chapStoryMapper;
    private UserMapper userMapper;
    public ChapStoryServiceImp(ChapStoryMapper chapStoryMapper){this.chapStoryMapper=chapStoryMapper;}

    @Override
    public List<ChapstorysDto> list() {
        List<ChapstorysDto> list=chapStoryMapper.findAll();
        return list;
    }

    @Override
    public ChapstorysDto detail(int chapNum) {
        ChapstorysDto detail = chapStoryMapper.findByChapNum(chapNum);
        return detail;
    }

    @Override
    public List<ChapstorysDto> blogMain(String userId) {
        List<ChapstorysDto> blogmain = chapStoryMapper.findByUserId(userId);
        return blogmain;
    }

    @Override
    public int register(ChapstorysDto chaps) {
        return 0;
    }

    @Override
    public int modify(ChapstorysDto chaps) {
        return 0;
    }

    @Override
    public int remove() {
        return 0;
    }

}
