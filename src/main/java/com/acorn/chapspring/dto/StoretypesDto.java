package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class StoretypesDto {
    private int storetypeId; // pk (Generate Key)
    private int storeNum; // fk stores.store_num
    private int categoryNum; // fk type_classes.category_num
    
    private TypeClassesDto typeByStore; //가게의 업종
}
