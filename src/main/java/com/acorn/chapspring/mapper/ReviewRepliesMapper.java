package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewRepliesDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewRepliesMapper {
    ReviewRepliesDto findByReview(int reviewNum); //리뷰에 달린 리플
    int deleteReply(int reviewNum);//사장님 댓글 삭제
}
