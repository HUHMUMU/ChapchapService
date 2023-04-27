package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ReviewLikeMapper {
    ReviewLikesDto countLikeByReview(int reviewNum);
}
