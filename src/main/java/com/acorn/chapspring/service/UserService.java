package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {
    UserDto login(UserDto user);//로그인
    UserDto detail(String userId);//상세정보
    int modify(UserDto user);//수정
    int signup(UserDto user);//회원가입
    int dropout(UserDto user);//회원탈퇴
    List<VisitedStoreDto> visited(String userId);//유저 방문조회
    List<ReviewsDto> reviewed(String userId);//유저 리뷰조회
    List<UserDto> userList();
    List<RecommendStoreDto> recommendList(String userId);
    List<JjimManageDto> jjimList(String userId);

    int idCheck(String userId) throws Exception; //아이디 중복 체크
    int nickName_Check(String nickname) throws Exception; //닉네임 중복 체크
    int email_Check(String email) throws Exception;
    //이메일 인증
    int modifyEmailCheck(UserDto user);
}

