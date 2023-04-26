package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class ChapstoryPageDto {
    enum BoardsType{
        chap_num, user_id, title, content, viewcount, post_time, likes, nickname
    }

    enum DirectType{
        DESC, ASC
    }
    private  int pageNum=1;
    private int pageSize=10;
    private BoardsType order=BoardsType.post_time;
    private DirectType direct=DirectType.DESC;

    private BoardsType searchField;
    private String searchValue;
    private String orderBy;

    public String getOrderBy() {
        //SELECT * FROM ~~ ORDER BY b_id DESC
        //SELECT * FROM ~~ ORDER BY b_idDESC
        //SELECT * FROM ~~ ORDER BY null null
        if(this.order!=null && this.direct!=null){
            return this.order+" "+this.direct;
        }else if(this.order!=null){
            this.direct=DirectType.ASC;
            return this.order+" "+this.direct;
        }
        return BoardsType.post_time+" "+DirectType.DESC;
    }
}
