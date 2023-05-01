package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@JsonIgnoreProperties({"handler"})
public class ReviewsDto {
    private int reviewNum; //PK (auto increment) 리뷰 번호
    private String content; //리뷰 작성 내용
    private String comment; //리뷰 한줄평
    private String img; //리뷰 이미지
    private Date date; //리뷰 작성시간
    private int star;  //별점
    private String rrStatus; //신고상태 enum('공개', '심사', '비공개')
    private String userId; //FK 유저 아이디
    private int storeNum; //FK 가게 고유번호
    private int menuNum; //FK 메뉴 번호
    
    private String storeName; //가게 이름 끌어오기
    private String mainImg;// 가게 대표 사진 끌어오기
    private UserDto userInfo; //유저 정보 가져오기
    private int countReview; //유저별 리뷰수
    private ReviewRepliesDto rReplies; //리뷰의 사장님 댓글정보 가져오기
    private MenuManagesDto menuName; //메뉴 이름 가져오기
    private ReviewLikesDto countLike; //리뷰의 좋아요 싫어요
    private List<ReportsDto> reportReview; //리뷰 신고
    private List<ReviewLikesDto> reviewLikes; //리뷰의 좋아요들
    private float starAverage;
}
