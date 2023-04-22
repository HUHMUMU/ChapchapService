package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class StoreFilterDto {
    private String menuType; // 가게리스트에서 타입으로 필터하기위해 작성
    private String priceRange; // 가격대별로 필터하기위해
    private String detailArea; // 상세지역으로 필터하기위해 ex) 망원동 합정동
    private boolean parking; // 주차가능불가능으로 필터

    // 정렬 조건을 위한 필드
    private String sortBy; // 거리순,별점순,리뷰순,좋아요순 등을 포함

    // 페이지네이션을 위한 필드
    private int pageNumber; // 페이지 번호를 나타내는 정수값
    private int pageSize; // 한 페이지에 몇개의 가게가 나올지
}
