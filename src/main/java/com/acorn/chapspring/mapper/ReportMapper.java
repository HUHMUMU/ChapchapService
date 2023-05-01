package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReportsDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper //session Factory 에서 생성 및 관리
@Repository //spring Container 의 dao 의 의미
public interface ReportMapper {
    List<ReportsDto> findReportByReview(int reviewNum); //리뷰별 신고 찾기
    int insertReportByReview(ReportsDto report); //리뷰 신고 하기
    int deleteReportByReviewNum(int reviewNum); //리뷰 지울때 신고도 지우기
    List<ReportsDto> findReportByChapstory(int chapNum); //챱스토리 게시글별 신고 찾기
    int insertReportByChapstory(ReportsDto report); // 챱스토리 신고하기
}
