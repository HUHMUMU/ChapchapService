package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.ReportsDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ChapStoryService;
import com.acorn.chapspring.service.ReportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.print.attribute.standard.PresentationDirection;

@AllArgsConstructor
@Controller
@RequestMapping("/report.do")
@Log4j2
public class ChapstoryReportController {
    private ReportService reportService;
    private ChapStoryService chapStoryService;

    @GetMapping ("/report.do")
    public String report(
            Model model,
            @PathVariable int chapNum,
            @SessionAttribute UserDto loginUser){
        ChapstorysDto chaps = chapStoryService.detail(chapNum);
        model.addAttribute("c",chaps);
        return "chapstory/report.do";}

    @PostMapping("/reportChapstory.do")
    public String reportChapstory(
            @RequestParam int chapNum,
          @RequestParam String reportContent,
          @SessionAttribute UserDto loginUser,
          @ModelAttribute ReportsDto report){
//        ReportsDto report = new ReportsDto();
        int register=0;
        try{
            register=reportService.registerReportByChap(report);
            log.info(report);
        }catch (Exception e){
            log.error(e.getMessage());
        }
        if(register>0){
                return "redirect:/chapstory/list.do";
        }
//        report.setReportUserId(String.valueOf(loginUser));
//        report.setReportContent(reportContent);
//        report.setChapNum(chapNum);
//        reportService.registerReportByReview(report);
        return "redirect:/chapstory/list.do";
    }
}
