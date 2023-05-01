package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class EmailDto {
    private String to;
    private String title;
    private String message;
}
