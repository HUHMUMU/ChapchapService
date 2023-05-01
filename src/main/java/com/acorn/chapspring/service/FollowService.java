package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.FollowDto;

public interface FollowService {
    int remove(FollowDto follow);
    int register(FollowDto follow);
}
