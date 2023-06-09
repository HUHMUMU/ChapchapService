package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class StoreFilterDto {
    private Integer menuType; // 가게리스트에서 타입으로 필터하기위해 작성
    private String priceRange; // 가격대별로 필터하기위해
    private String detailArea; // 상세지역으로 필터하기위해 ex) 망원동 합정동
    private Integer parking; // 주차가능불가능으로 필터
    private String searchName; // 이름으로 검색할때 사용
    private String detailMenuName; // 메뉴(빅맥,안심돈까스) 등으로 검색할때 사용

    // 페이지네이션을 위한 필드
    private int pageNumber=1; // 페이지 번호를 나타내는 정수값
    private int pageSize=10; // 한 페이지에 몇개의 가게가 나올지

    enum DirectType{ // 내림차순,오름차순
        DESC,ASC
    }
    enum StoresListType {
        averageStar,review_count,jjim_count,distance
    }
    private StoresListType order= StoresListType.review_count;
    private DirectType direct=DirectType.DESC;
    private StoresListType searchField;
    private String searchValue;
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
