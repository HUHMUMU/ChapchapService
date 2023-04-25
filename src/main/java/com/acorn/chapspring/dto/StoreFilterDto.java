package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class StoreFilterDto {
    private Integer menuType; // 가게리스트에서 타입으로 필터하기위해 작성
    private String priceRange; // 가격대별로 필터하기위해
    private String detailArea; // 상세지역으로 필터하기위해 ex) 망원동 합정동
    private Integer parking; // 주차가능불가능으로 필터

    // 정렬 조건을 위한 필드 // 이제 사용안함
    private String sortBy; // 거리순,별점순,리뷰순,찜순 을 포함

    // 페이지네이션을 위한 필드
    private int pageNumber=1; // 페이지 번호를 나타내는 정수값
    private int pageSize=10; // 한 페이지에 몇개의 가게가 나올지

    enum DirectType{ // 내림차순,오름차순
        DESC,ASC
    }
    enum StoresListType {
        recommend_count,review_count,jjim_count,distance
    }
    private StoresListType order= StoresListType.review_count;
    private DirectType direct=DirectType.DESC;
    private StoresListType searchField;

    private String orderBy;
    public String getOrderBy(){
        if(this.order!=null && this.direct!=null){
            return this.order+" "+this.direct;
        } else if (this.order!=null){
            this.direct=DirectType.ASC;
            return this.order+" "+this.direct;
        }
        return StoresListType.review_count+" "+DirectType.DESC;
    }

}
