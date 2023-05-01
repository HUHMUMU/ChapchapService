package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewRepliesDto;

public interface ReviewRepliesService {
    ReviewRepliesDto findRepliesByReview(int reviewNum); //리뷰 별 댓글
    int removeReply(int reviewNum); //리뷰 삭제시 댓글 삭제
}
