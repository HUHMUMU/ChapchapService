package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReportsDto;

import java.util.List;

public interface ReportService {
    int registerReportByReview(ReportsDto reports); //신고등록
    int removeReportByReview(int reviewNum); //리뷰 삭제시 신고삭제
}
