package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReportsDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReportMapperTest {
    @Autowired
    private ReportMapper reportMapper;
    @Test
    void findReportByReview() {
        ReportsDto report=new ReportsDto();
        report.setReportStoreId("store001");
        report.setReportContent("신고 테스트");
        report.setReviewNum(1);
        int registerOne=reportMapper.insertReportByReview(report);
        System.out.println("registerOne = " + registerOne);
    }
}