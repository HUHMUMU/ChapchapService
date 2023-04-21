package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.*;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserMapperTest {
    @Autowired

    private UserMapper userMapper;
    private static VisitedStoreDto visited;
    private static UserDto user;
    private static ReviewDto reviewer;
    private static RecommendStoreDto recommendstore;
    private static JjimManageDto jjim;
    @Test
    @Order(1)
    void findByUserId() {
//        user=new UserDto();//user 데이터를 UserDto에서 조회라는 느낌
//        user.setUserId("user01");
//        UserDto findUser=userMapper.findByUserId(user.getUserId());

        reviewer=new ReviewDto();
        reviewer.setUserId("user01");
        UserDto findUser=userMapper.findByUserId(reviewer.getUserId());
        System.out.println("findUser : "+findUser);
        assertNotNull(findUser);
    }


    @Test
    @Order(2)
    void findByUserIdAndPw() {
        user=new UserDto();
        user.setUserId("user01");
        user.setPw("password123");
        UserDto findUser=userMapper.findByUserIdAndPw(user);
        System.out.println("findUser : "+findUser);
        assertNotNull(findUser);
    }

    @Test
    @Order(3)
    void findByUserIdByEmailAndName() {
        user=new UserDto();
        user.setName("김철수");
        user.setEmail("chulsoo@example.com");
        String userId=userMapper.findByUserIdByEmailAndName(user);
        System.out.println("Id : "+userId);

    }

    @Test
    @Order(4)
    void updateOne() {
        user=new UserDto();
        user.setUserId("user01");
        user.setNickname("철");
        user.setPw("password111");
        user.setAddress("서울특별시");
        user.setDetailAddress("송파구");
        user.setEmail("chul@gmail.com");
        user.setBirth("1996-04-04");
        user.setGender("MALE");
        int update= userMapper.updateOne(user);
        UserMapperTest.user=userMapper.findByUserId(user.getUserId());
        System.out.println("수정된 유저 정보 :"+UserMapperTest.user);
        assertEquals(update,1);
    }

    @Test
    void insertOne() {
        user=new UserDto();
        user.setUserId("user21");
        user.setPw("password222");
        user.setName("강석정");
        user.setNickname("밀다라심경");
        user.setBirth("1996-04-04");
        user.setGender("MALE");
        user.setAddress("서울특별시");
        user.setDetailAddress("송파구");
        user.setEmail("tlssua6985@gmail.com");
        int insert=userMapper.insertOne(user);
        UserMapperTest.user=userMapper.findByUserId(user.getUserId());
        System.out.println("등록된 유저 정보 : "+UserMapperTest.user);
        assertEquals(insert,1);
    }

    @Test
    void deleteByUserIdAndPw() {
        user=new UserDto();
        user.setUserId("user21");
        user.setPw("password222");
        int delete= userMapper.deleteByUserIdAndPw(user);
        assertEquals(delete,1);
    }
    @Test
    void findAll() {
        visited=new VisitedStoreDto();
        visited.setUserId("admin");
        List<VisitedStoreDto> find=userMapper.findAllVisited(visited.getUserId());
        System.out.println(find);
    }
    @Test
    void findAllUsers(){

        List<UserDto> list=userMapper.findAllUsers();
        System.out.println("firstUser : "+list.get(0).getUserId());
        int userNumber=0;
        for(UserDto userList : list){
            System.out.println("userNumber"+userNumber+" : "+userList.getUserId());
            userNumber++;
        }

    }

    @Test
    void findAllRecommend() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("user01");
        List<RecommendStoreDto> list=userMapper.findAllRecommend(recommendstore.getUserId());
        int listNum=0;
        for (RecommendStoreDto recommendList : list){
            listNum++;
            System.out.println("number"+listNum+" : "+recommendList);
        }
    }

    @Test
    void insertOneByUserId() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("admin");
        recommendstore.setComment("맛있어요!");
        recommendstore.setStoreNum(8);
        //---------------------------------------------------

        List<RecommendStoreDto> list=userMapper.findAllRecommend(recommendstore.getUserId());
        System.out.println(recommendstore.getUserId()+"'s list number : " +list.size());

        if(list.size()<3){
            int insert= userMapper.insertOneByUserId(recommendstore);//성공하면 1 반환
            assertEquals(insert,1);
            list=userMapper.findAllRecommend(recommendstore.getUserId());
            int listNum=1;
            for (RecommendStoreDto recommendList : list){
                System.out.println("number"+listNum+" : "+recommendList);
                listNum++;
            }
        }else{
            System.out.println("store can't recommend over 3!");
        }
//-------------------------------------------------------------------

//        int insert= userMapper.insertOneByUserId(recommendstore);//성공하면 1 반환
//        assertEquals(insert,1);

        //--------------------------------------------------------------------------

//        List<RecommendStoreDto> list=userMapper.findAllRecommend(recommendstore.getUserId());
//        int listNum=0;
//        for (RecommendStoreDto recommendList : list){
//            listNum++;
//            System.out.println("number"+listNum+" : "+recommendList);
//        }

    }

    @Test
    void deleteOneByUserIdAndStoreNum() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setStoreNum(8);
        recommendstore.setUserId("admin");
        int delete=userMapper.deleteOneByUserIdAndStoreNum(recommendstore);
        assertEquals(delete,1);
        List<RecommendStoreDto> list=userMapper.findAllRecommend(recommendstore.getUserId());
        int listNum=0;
        for (RecommendStoreDto recommendList : list){
            listNum++;
            System.out.println("number"+listNum+" : "+recommendList);
        }
    }

    @Test
    void findAllJjim(){
        jjim=new JjimManageDto();
        jjim.setUserId("user01");
        List<JjimManageDto> list=userMapper.findAllJjim(jjim.getUserId());
        int listnum=0;
        for(JjimManageDto jjimlist : list){
            System.out.println("number"+listnum+" : "+jjimlist);
            listnum++;
        }

    }
}