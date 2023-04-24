package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.*;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface WaitingMapper {

    List<WaitingDto> getWaitingList();
    WaitingDto getWaiting(int id);
    void insertWaiting(WaitingDto waitingDto);
    void updateWaiting(WaitingDto waitingDto);
    void deleteWaiting(int id);

}


// 보완 수정해야함
