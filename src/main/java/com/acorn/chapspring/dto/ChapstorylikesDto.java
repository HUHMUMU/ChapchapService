package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class ChapstorylikesDto {
    private int likeno; //PK
    private int chapNum; //FK
    private String userId; //FK
    private int likeCheck; // 좋아요시 1 없으면 0

    public ChapstorylikesDto() {
    }
}
