package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class MenuManagesDto {
    private int menuNum; // PK (auto increment)
    private String name; //메뉴이름
    private String img; //메뉴 이미지
    private int price; //메뉴 가격
    private String info; //메뉴 상세정보
    private String menuType; //메뉴 타입 enum('대표메뉴', '신메뉴', '일반메뉴')
    private boolean status; //메뉴 주문 가능 상태
    private int storeNum; // FK 가게 번호
}
