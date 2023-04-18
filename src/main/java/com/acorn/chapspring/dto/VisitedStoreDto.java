package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class VisitedStoreDto {
    private int visitedStoreOrder;
    private Date visitedDate;
    private String userId;
    private String storeName;
    private String address;
}
