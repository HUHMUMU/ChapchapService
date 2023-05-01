package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class ChapstorylikesDto {
    private int likeno; //PK
    private int chapNum; //FK
    private String userId; //FK
    public ChapstorylikesDto() {
    }
}
