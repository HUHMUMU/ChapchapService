package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class FollowDto {
    private int followId;
    private String fromId;
    private String toId;
    private Date followTime;

}
