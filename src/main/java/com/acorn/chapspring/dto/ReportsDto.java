package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class ReportsDto {
    private int reportNum;
    private String reportStoreId;
    private String reportUserId;
    private String reportContent;
    private int reviewNum;
    private String userId;
    private int chapNum;
    private int storeNum;
}
