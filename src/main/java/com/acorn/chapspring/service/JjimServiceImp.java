package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.JjimManageDto;
import com.acorn.chapspring.mapper.JjimManageMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class JjimServiceImp implements JjimService{
    private JjimManageMapper jjimManageMapper;

    @Override//2.유저 찜목록 부분
    public List<JjimManageDto> jjimList(String userId){
        List<JjimManageDto> list=jjimManageMapper.findAllJjimByUserId(userId);
        List<JjimManageDto> userJjimList=new ArrayList<>(list.size());
        int listNum=0;
        for(JjimManageDto jjim : list){
            listNum++;
            jjim.setListNum(listNum);
            userJjimList.add(jjim);
        }
        return userJjimList;
    }

    @Override
    public int add(JjimManageDto jjim){
        int add=jjimManageMapper.insertOneByUserId(jjim);
        return add;
    }

    @Override
    public int delete(JjimManageDto jjim){
        int delete=jjimManageMapper.deleteOneByUserIdAndStoreNum(jjim);
        return delete;
    }

    @Override
    public JjimManageDto checkJjim(String userId,int storeNum){
        JjimManageDto jjim=jjimManageMapper.findOneByUserIdAndStoreNum(userId, storeNum);
        return  jjim;
    }
}
