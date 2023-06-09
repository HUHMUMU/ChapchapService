package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.time.LocalTime;

@Data
@JsonIgnoreProperties({"handler"})
public class BreaktimesDto {
    private int restNum; // pk (auto increment)
    private LocalTime restStartTime; //휴식 시작 시간
    private LocalTime restEndTime; //휴식 끝 시간
    private int storeNum; // fk 가게 고유 번호
}
