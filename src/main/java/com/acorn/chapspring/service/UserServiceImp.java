package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.mapper.*;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class UserServiceImp implements UserService{
    private UserMapper userMapper;
    private RecommendStoreMapper recommendStoreMapper;
    private VisitedStoreMapper visitedStoreMapper;
    private ReviewMapper reviewMapper;
    private JjimManageMapper jjimManageMapper;

    public UserServiceImp(
            UserMapper userMapper, RecommendStoreMapper recommendStoreMapper,
            VisitedStoreMapper visitedStoreMapper, ReviewMapper reviewMapper,
            JjimManageMapper jjimManageMapper
    ){
        this.userMapper=userMapper;
        this.recommendStoreMapper=recommendStoreMapper;
        this.visitedStoreMapper=visitedStoreMapper;
        this.reviewMapper=reviewMapper;
        this.jjimManageMapper=jjimManageMapper;
    }
    //로그인,가입,탈퇴,수정 부분----------------------------------------------------------------
    @Override//로그인
    public UserDto login(UserDto user) {//로그인
        return userMapper.findByUserIdAndPw(user);
    }

    @Override//회원가입
    public int signup(UserDto user) {
        return userMapper.insertOne(user);
    }

    @Override//회원탈퇴
    public int dropout(UserDto user) {
        return userMapper.deleteByUserIdAndPw(user);
    }

    @Override//정보 수정
    public int modify(UserDto user){
        return userMapper.updateOne(user);
    }
    //---------------------------------------------------------------------------------
    @Override
    public int nickName_Check(String nickname) throws Exception {
        return userMapper.nickName_Check(nickname);
    }

    @Override
    public int email_Check(String email) throws Exception {
        return userMapper.email_Check(email);
    }

    @Override
    public int modifyEmailCheck(UserDto user) {
        int modifyEmailCheck=userMapper.updateStatusByUidAndEmailCheckCode(user);
        return modifyEmailCheck;
    }
    @Override
    public int idCheck(String userId) throws Exception {
        return userMapper.idCheck(userId);
    }
    //유저 마이페이지 정보 조회 부분---------------------------------------------------------------
    @Override//유저 정보
    public UserDto detail(String userId) {
        return userMapper.findByUserId(userId);
    }

    @Override//유저 방문 가게 리스트
    public List<VisitedStoreDto> visited(String loginUserId) {
        userMapper.setLoginUserId(loginUserId);
        List<VisitedStoreDto> list=visitedStoreMapper.findAllVisited(loginUserId);
        return list;
    }

    @Override//유저 작성 리뷰 리스트
    public List<ReviewsDto> reviewed(String loginUserId){
        userMapper.setLoginUserId(loginUserId);
        List<ReviewsDto> list=reviewMapper.findAllReviewed(loginUserId);
        return list;
    }
    @Override//유저 상세페이지 링크 임시 구현 부분
    public List<UserDto> userList(){
        List<UserDto> list=userMapper.findAllUsers();
        return list;
    }
    @Override//유저 추천가게 부분
    public List<RecommendStoreDto> recommendList(String userId){
        List<RecommendStoreDto> list=recommendStoreMapper.findAllRecommend(userId);
        return list;
    }
    @Override//유저 찜목록 부분
    public  List<JjimManageDto> jjimList(String userId){
        List<JjimManageDto> list=jjimManageMapper.findAllJjim(userId);
        return list;
    }
}
