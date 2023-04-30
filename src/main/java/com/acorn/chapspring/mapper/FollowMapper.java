package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FollowMapper {
    List<UserDto> findByFromId(String uId);//팔로우
    List<UserDto> findByToId(String uId);//팔로워
    int deleteByFromIdAndToId(FollowDto followDto);
    int insertOne(FollowDto followDto);

    boolean findByToIdAndFromIdIsLoginUserId(String uId);
}
