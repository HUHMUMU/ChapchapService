package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class StoreImgsDto {
    private int imgNum; // pk (Generate Key)
    private int storeNum; // fk stores.store_num
    private String storeImg;
}
