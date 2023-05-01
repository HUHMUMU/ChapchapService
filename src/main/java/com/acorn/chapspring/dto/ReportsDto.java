package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
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
