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

    @Test
    void testFindReportByReview() {
        List<ReportsDto> reports=reportMapper.findReportByReview(1);
        System.out.println("reports = " + reports);
    }
    
    @Test
    void findReportByChapstory() {
        List<ReportsDto> reports=reportMapper.findReportByChapstory(1);
        System.out.println("reports = " + reports);
    }

    @Test
    void insertReportByChapstory() {
        ReportsDto report=new ReportsDto();
        report.setReportUserId("user01");
        report.setReportContent("신고 테스트");
        report.setChapNum(1);
        int registerOne=reportMapper.insertReportByChapstory(report);
        System.out.println("registerOne = " + registerOne);
    }
}