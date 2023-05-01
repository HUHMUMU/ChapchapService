package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReportsDto;
import com.acorn.chapspring.mapper.ReportMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ReportServiceImp implements ReportService{
    private ReportMapper reportMapper;

    @Override
    public int registerReportByReview(ReportsDto reports) {
        int register=reportMapper.insertReportByReview(reports);
        return register;
    }

    @Override
    public int registerReportByChap(ReportsDto reports) {
        int registerReport=reportMapper.insertReportByChapstory(reports);
        return registerReport;
    }
}
