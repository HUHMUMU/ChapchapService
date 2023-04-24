package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.*;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface WaitingMapper {

    List<WaitingDto> getWaitingList();
    WaitingDto getWaiting(int id);
    int addWaiting(WaitingDto waitingDto);
    int modifyWaiting(WaitingDto waitingDto);
    int deleteWaiting(int id);

}
