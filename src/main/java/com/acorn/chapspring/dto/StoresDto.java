package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties({"handler"})
public class StoresDto {
    private int storeNum; //PK
    private String storeName; //가게 이름
    private String detailInfo; //가게 상세설명
    private String shortInfo; //가게 한줄설명
    private String madein; //원산지
    private String address; //가게 주소
    private String mainImg; //가게 메인이미지
    private String opentime; //영업시간 00:00-00:00
    private String lastorder; //주문마감시간
    private String waitingClosetime; //웨이팅 마감 시간
    private String blogurl; //블로그 링크
    private String youtubeurl; //유튜브 링크
    private String facebookurl; //페이스북 링크
    private String instaurl; //인스타 링크
    private String tvshow; //tv출연 정보
    private String sRstatus; //enum('공개','심사','비공개')
    private boolean parking; //주차장 여부
    private boolean wifi; //와이파이 여부
    private boolean toilet; //화장실 여부
    private boolean smokingroom; //흡연실 여부
    private boolean babychair; //아기의자 여부

    private List<MenuManagesDto> menuList; //메뉴들 가져오기
    private List<ChapDealDto> chapDealList; //챱딜 이벤트 가져오기
    private List<ReviewsDto> reviewList; //리뷰들 가져오기
    private List<BreaktimesDto> breaktimes; //브레이크타임 가져오기
    private StoreManagesDto storeCall; //가게 전화번호 가져오기
    private StoretypesDto storeType; //가게 업종 가져오기
    private List<HolidaysDto> holiday; //휴무일 가져오기
    private List<StoreImgsDto> storeImgs; //가게 이미지 가져오기
    private ReviewsDto starAvg; //평균 별점
    private UsersWaitingDto waitingTeamNum; //웨이팅 대기 팀 수

    private StoresWaitingDto waiting;
    private int categoryNum; // 카테고리 번호
    private int jjimCount; // 찜 갯수
    private int reviewCount; // 리뷰 갯수
    private double averageStar; // 평균 별점

}
