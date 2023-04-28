package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstoryPageDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.mapper.ChapStoryMapper;
import com.acorn.chapspring.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class ChapStoryServiceImp implements ChapStoryService{
    private ChapStoryMapper chapStoryMapper;
    private UserMapper userMapper;
//    public ChapStoryServiceImp(ChapStoryMapper chapStoryMapper){this.chapStoryMapper=chapStoryMapper;}

    @Override
    public List<ChapstorysDto> list(ChapstoryPageDto pageDto) {
        PageHelper.startPage(pageDto.getPageNum(),pageDto.getPageSize(),pageDto.getOrderBy());
        List<ChapstorysDto> list=chapStoryMapper.findAll(pageDto);
        return list;
    }

    @Override
    public List<ChapstorysDto> bestList() {
        List<ChapstorysDto> bestList = chapStoryMapper.bestList();
        return bestList;
    }

    @Override
    public List<ChapstorysDto> bestListFindByUserId(String userId) {
        List<ChapstorysDto> bestListFindByUserId = chapStoryMapper.bestListFindByUserId(userId);
        return bestListFindByUserId;
    }

    @Override
    @Transactional
    public ChapstorysDto detail(int chapNum) {
        chapStoryMapper.updateIncrementViewCountChapNum(chapNum);
//        chapStoryMapper.updateIncrementLikeChapNum(chapNum);
        ChapstorysDto detail = chapStoryMapper.findByChapNum(chapNum);
        return detail;
    }

    @Override
    public List<ChapstorysDto> blogMain(String userId) {
        List<ChapstorysDto> blogmain = chapStoryMapper.findByUserId(userId);
        return blogmain;
    }

    @Override
    @Transactional
    public int register(ChapstorysDto chaps) {
        int register = chapStoryMapper.insertOne(chaps);
        return register;
    }

    @Override
    @Transactional
    public int modify(ChapstorysDto chaps) {
        int modify=chapStoryMapper.updateOne(chaps);
        return modify;
    }

    @Override
    public int remove(int chapNum) {
        int remove=chapStoryMapper.deleteByChapsNum(chapNum);
        return remove;
    }

}
