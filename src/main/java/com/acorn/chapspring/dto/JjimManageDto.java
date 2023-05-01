package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class JjimManageDto {
    private int jjimNum;
    private String jjStatus;
    private String userId;
    private int storeNum;
    private String storeName;//조인용 변수
    private String address;//조인용 변수
    private int listNum;//유저 리스트 번호 **데이터베이스어 없음!
}
