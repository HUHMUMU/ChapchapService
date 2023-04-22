package com.acorn.chapspring.dto;

import lombok.Data;

import java.time.LocalTime;

@Data
public class BreaktimesDto {
    private int restNum; // pk
    private LocalTime restStartTime;
    private LocalTime restEndTime;
    private int storeNum; // fk
}
