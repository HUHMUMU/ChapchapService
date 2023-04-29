package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class ChapstoryimgsDto {
    private int chsNum; //pk
    private int chapNum; //fk 게시글 번호
    private String img; // 게시글 이미지
}
