package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class StoreManagesDto {
    private String storeId;
    private String pw;
    private String businessNum;
    private String storeCall;
    private String phone;
    private String email;
    private int storeNum;
}
