package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ReportsDto;
import com.acorn.chapspring.service.ReportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@AllArgsConstructor
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/report")
@Log4j2
public class ReportController {
    private ReportService reportService;

    @PostMapping("/registerByReview")
    public int registerReportByReview(@RequestBody ReportsDto reports) {
        return reportService.registerReportByReview(reports);
    }
}
