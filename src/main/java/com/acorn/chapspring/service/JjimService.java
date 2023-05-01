package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.JjimManageDto;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface JjimService {
    List<JjimManageDto> jjimList(String userId);

    int add(JjimManageDto jjim);

    int delete(JjimManageDto jjim);

    JjimManageDto checkJjim(String userId,int storeNum);
}
