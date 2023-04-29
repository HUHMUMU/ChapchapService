package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class ChapstorylikesDto {
    private int likeno; //PK
    private int chapNum; //FK
    private String userId; //FK
    public ChapstorylikesDto() {
    }
}
