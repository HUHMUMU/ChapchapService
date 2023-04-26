package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class TypeClassesDto {
    private int categoryNum; // pk (Generate Key)
    private String mainCategory; //대분류 enum('음식점', '카페', '술집')
    private String subCategory; //소분류
}
