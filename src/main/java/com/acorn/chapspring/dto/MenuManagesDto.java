package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class MenuManagesDto {
    private int menuNum; // PK
    private String name;
    private String img;
    private int price;
    private String info;
    private String menuType;
    private String status;
    private int storeNum; // FK
}
