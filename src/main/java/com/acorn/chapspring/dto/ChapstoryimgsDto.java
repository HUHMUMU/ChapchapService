package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class ChapstoryimgsDto {
    private int chsNum; //pk
    private int chapNum; //fk 게시글 번호
    private String img; // 게시글 이미지
}
