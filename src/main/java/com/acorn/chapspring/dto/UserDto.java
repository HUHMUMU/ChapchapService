package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties({"handler"})
public class UserDto {
    public enum StatusType {
        공개,심사,비공개,휴면,탈퇴,이메일인증중
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
    private String profileImg;
    private String introduce;
    private String postnumber;
    private String emailCheckCode;
    private StatusType urStatus;
    private String chapbanner;

    //팔로우 구현
    private boolean following; //팔로잉 체크
    private List<UserDto> followings; //팔로우리스트
    private List<UserDto> followers; //팔로워 리스트
}
