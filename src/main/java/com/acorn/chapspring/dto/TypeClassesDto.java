package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class TypeClassesDto {
    private int categoryNum; // pk (Generate Key)
    private String mainCategory;
    private String subCategory;
}
