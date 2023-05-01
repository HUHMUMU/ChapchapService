package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.Date;

@Data
@JsonIgnoreProperties({"handler"})
public class FollowDto {
    private int followId;
    private String fromId;
    private String toId;
    private Date followTime;

}
