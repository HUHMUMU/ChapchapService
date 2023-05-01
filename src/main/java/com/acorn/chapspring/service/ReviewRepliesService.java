package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewRepliesDto;

public interface ReviewRepliesService {
    ReviewRepliesDto findRepliesByReview(int reviewNum);
    int removeReply(int reviewNum);
}
