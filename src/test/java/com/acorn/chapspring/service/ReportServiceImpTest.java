package com.acorn.chapspring.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class ReportServiceImpTest {
    @Autowired
    private ReportService reportService;

    @Test
    void removeReportByReview() {
        int remove=reportService.removeReportByReview(5);
        System.out.println("remove = " + remove);
    }
}