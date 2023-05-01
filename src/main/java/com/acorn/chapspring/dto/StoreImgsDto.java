package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class StoreImgsDto {
    private int imgNum; // pk (Generate Key)
    private int storeNum; // fk stores.store_num
    private String storeImg;
}
