package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class UserDto {
    public enum StatusType {
        공개,심사,비공개,휴먼,탈퇴
    }
    private String userId;
    private String nickname;
    private String pw;
    private String name;
    private String birth;
    private String gender;
    private String address;
    private String detailAddress;
    private String email;
    private String instaUrl;
    private String faceUrl;
    private String youtubeUrl;
    private String profileimg;
    private String introduce;
    private String postnumber;
    private String emailCheckCode;
    private StatusType urStatus;

}
