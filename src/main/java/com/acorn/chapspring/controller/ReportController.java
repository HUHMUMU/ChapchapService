package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ReportsDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ReportService;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/store/report")
@Log4j2
public class ReportController {
    private ReportService reportService;

    @PostMapping("/reportReview.do")
    public String reportReview(@RequestParam int reviewNum,
                               @RequestParam String reportContent,
                               @SessionAttribute UserDto loginUser) {
        ReportsDto report = new ReportsDto();
        report.setReportUserId(String.valueOf(loginUser));
        report.setReportContent(reportContent);
        report.setReviewNum(reviewNum);
        reportService.registerReportByReview(report);
        return "redirect:/store/1/detail.do";
    }
}
