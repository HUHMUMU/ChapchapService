package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class HolidaysDto {
    private int holiNum; // pk
    private int storeNum; // fk
    private String week;
    private Date date;
    private int regular;
}
