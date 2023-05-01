package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReportsDto;

import java.util.List;

public interface ReportService {
    int registerReportByReview(ReportsDto reports);
    int registerReportByChap(ReportsDto reports);
}
