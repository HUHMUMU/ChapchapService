package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.lib.AESEncryption;
import com.acorn.chapspring.service.EmailService;
import com.acorn.chapspring.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.security.SecureRandom;
import java.util.Base64;


@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/user")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
//**System.out.print() => 휘발성 로그 (콘솔에 출력만 가능!)
public class UserController {
    // "/user/login.do" 동적페이지 정의

    private UserService userService;
    private EmailService emailService;


    @GetMapping("/dropout.do")
    public String dropoutForm(
            @SessionAttribute UserDto loginUser){
        return "/user/dropout";
    }
    @PostMapping("/dropout.do")
    public String dropoutAction(
            @ModelAttribute UserDto user,
            @SessionAttribute UserDto loginUser,
            RedirectAttributes redirectAttributes,
            HttpSession session){
        String msg="회원 탈퇴 실패 (비밀번호 확인)";
        String redirectPage="redirect:/user/dropout.do";
        int dropout=0;
        try {
            dropout=userService.dropout(user);
        }catch (Exception e){
            log.error(e.getMessage());
            msg+=" 에러 :"+e.getMessage();
        }
        if(dropout>0){
            msg="이용해 주셔서 감사합니다.(회원탈퇴 성공)";
            redirectPage="redirect:/";
            session.removeAttribute("loginUser");
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPage;
    }

    @GetMapping("/{userId}/modify.do")
    public String modifyForm(
            @PathVariable String userId,
            @SessionAttribute UserDto loginUser,
            Model model){//렌더할 뷰에 바로 객체 전달
        UserDto user=userService.detail(userId);
        model.addAttribute("user",user);
        return "/user/modify";
    }
    @PostMapping("/modify.do")
    public String modifyAction(
            @SessionAttribute UserDto loginUser,
            @ModelAttribute UserDto user,
            RedirectAttributes redirectAttributes){
        int modify=0;
        String msg="수정 실패";
        String redirectPage="redirect:/user/"+user.getUserId()+"/modify.do";
        try {
            modify= userService.modify(user);
        }catch (Exception e){
            log.error(e.getMessage());
            msg+=" 에러 :"+e.getMessage();
        }
        if(modify>0){
            redirectPage="redirect:/user/"+user.getUserId()+"/detail.do";
            msg="수정 성공";
        }

        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPage;
    }



    //filter(interceptor) : 해당페이지를 요청하기 전에 로그인 했는지 검사
    //controller : 해당페이지에서 로그인 했는지 검사
    @GetMapping("/{userId}/detail.do")
    public ModelAndView detail(
            @SessionAttribute(required = false) UserDto loginUser,
            // UserDto loginUser=(UserDto)session.getAttribute("loginUser")
            // 세션 객체를 파라미터 취급(required=true)해서 없으면 400 에러
            @PathVariable String userId,
            ModelAndView modelAndView,
            RedirectAttributes redirectAttributes
    ){ //ModelAndView : 렌더하는 뷰 설정 및 전달할 객체 설정
        if(loginUser==null){
            redirectAttributes.addFlashAttribute("msg","로그인 하셔야 이용할 수 있는 페이지 입니다.");
            modelAndView.setViewName("redirect:/user/login.do");
            return modelAndView;
        }

        UserDto user=userService.detail(userId);
        List<VisitedStoreDto> visited=userService.visited(userId);
        List<ReviewsDto> reviewed=userService.reviewed(userId);
        List<UserDto> list=userService.userList();
        List<RecommendStoreDto> recommend=userService.recommendList(userId);
        List<JjimManageDto> jjim=userService.jjimList(userId);


        modelAndView.setViewName("/user/detail");
        modelAndView.addObject("user",user);
        modelAndView.addObject("visited",visited);
        modelAndView.addObject("reviewed",reviewed);
        modelAndView.addObject("list",list);
        modelAndView.addObject("recommend",recommend);
        modelAndView.addObject("jjim",jjim);

        return  modelAndView;
    }


    @GetMapping("/signup.do")
    public void signupForm() {}
    //아이디 중복 체크

    @GetMapping(value = "/memberIdChk.do")
    public @ResponseBody String memberIdChkPOST(String memberId) throws Exception {

//        logger.info("memberIdChkPOST() 진입");

        log.info("memberIdChkPOST() 진입");
        int result=userService.idCheck(memberId);

        log.info("결과값 = " + result);

        if (result!=0) {
            return "fail"; //중복 아이디 있음
        } else {
            return "success"; //중복 아이디 없음
        }
    }

    //닉네임 중복 체크
    @GetMapping(value = "/nickNameChk.do")
    public @ResponseBody String nickNameChkPOST(String nickNameId) throws Exception {

//        logger.info("memberIdChkPOST() 진입");

        log.info("nickNameChkPOST() 진입");
        int result=userService.nickName_Check(nickNameId);

        log.info("결과값 = " + result);

        if (result!=0) {
            return "fail"; //중복 아이디 있음
        } else {
            return "success"; //중복 아이디 없음
        }
    }

    @GetMapping(value = "/emailChk.do")
    public @ResponseBody String emailChkPOST(String emailId) throws Exception {

        log.info("memberIdChkPOST() 진입");

        log.info("nickNameChkPOST() 진입");
        int result=userService.email_Check(emailId);

        log.info("결과값 = " + result);

        if (result!=0) {
            return "fail"; //중복 아이디 있음
        } else {
            return "success"; //중복 아이디 없음
        }
    }

    @GetMapping("/emailCheck.do")
    public void emailCheckForm(@RequestParam String userId){}

    @PostMapping ("/emailCheck.do")
    public String emailCheckAction(
            UserDto user,
            RedirectAttributes redirectAttributes){
        String msg="";
        String redirectPath="";
        int emailCheck=0;
        try {
            user.setUrStatus(UserDto.StatusType.공개);
            emailCheck=userService.modifyEmailCheck(user);
        } catch (Exception e) {
            log.error(e.getMessage());
        }

        if (emailCheck>0) { //보낸 코드와 생성된 코드가 같은 경우
            msg="이메일이 확인되었습니다.(회원가입 완료) 로그인 하세요";
            redirectPath="redirect:/user/login.do";
        } else {
            msg="이메일로 보낸 코드를 다시 확인 하세요";
            redirectPath="redirect:/user/emailCheck.do";
            redirectAttributes.addAttribute("userId",user.getUserId());
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;
    }


    @PostMapping("/signup.do")
    public String signupAction(
            @ModelAttribute UserDto user,
            RedirectAttributes redirectAttributes) {
        int signup=0;
        String errorMsg=null;
        try {
            SecureRandom random=new SecureRandom();
            byte[] bytes=new byte[6];
            random.nextBytes(bytes);
            String emailCheckCode= Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
            user.setEmailCheckCode(emailCheckCode);
            user.setUrStatus(UserDto.StatusType.심사);
            signup=userService.signup(user);
            if (signup>0) {
                EmailDto emailDto=new EmailDto();
                emailDto.setTo(user.getEmail());
                emailDto.setTitle("이메일 확인 코드 입니다.");
                emailDto.setMessage("해당 코드를 입력하세요" + emailCheckCode);
                emailService.sendMail(emailDto);
                redirectAttributes.addFlashAttribute("msg", "이메일을 확인해야 회원가입이 성공합니다.");
                //return "redirect:/user/emailCheck.do?uId"+user.getUId();
                redirectAttributes.addAttribute("userId", user.getUserId());
                return "redirect:/user/emailCheck.do";
            }
        } catch (Exception e) {
            log.error(e);
            errorMsg=e.getMessage();
        }
        redirectAttributes.addFlashAttribute("msg","회원가입 실패 에러"+errorMsg);
        return "redirect:/user/signup.do";
    }

    @GetMapping("/logout.do")
    public String logoutAction(
            HttpSession session,
            RedirectAttributes redirectAttributes,
            @CookieValue(value = "SPRING_LOGIN_ID",required = false) String loginIdVal,
            @CookieValue(value = "SPRING_LOGIN_PW",required = false) String loginPwVal,
            HttpServletResponse resp
    ){
        if(loginIdVal!=null || loginPwVal!=null){
            Cookie loginId=new Cookie("SPRING_LOGIN_ID","");
            Cookie loginPw=new Cookie("SPRING_LOGIN_PW","");
            loginId.setMaxAge(0);
            loginPw.setMaxAge(0);
            loginId.setPath("/");
            loginPw.setPath("/");
            resp.addCookie(loginId);
            resp.addCookie(loginPw);
        }
        session.removeAttribute("loginUser");
        redirectAttributes.addFlashAttribute("msg","로그아웃 되었습니다.");
        return "redirect:/";
    }

    @GetMapping("/login.do")
    public String loginForm(){

        return "/user/loginForm"; //렌더할 뷰
    }
    @PostMapping("/login.do")
    public String loginAction(
            UserDto user,
            Integer autoLogin,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            @SessionAttribute(required = false) String redirectPage,
            HttpServletResponse resp) throws Exception {
        UserDto loginUser=null;
        try {
            loginUser=userService.login(user);
        }catch (Exception e){
            log.error(e.getMessage());
        }
        if(loginUser!=null){
            if(autoLogin!=null && autoLogin==1){
                String encryptIdValue = AESEncryption.encryptValue(loginUser.getUserId());
                String encryptPwValue = AESEncryption.encryptValue(loginUser.getPw());
                Cookie loginId=new Cookie("SPRING_LOGIN_ID",encryptIdValue);
                Cookie loginPw=new Cookie("SPRING_LOGIN_PW",encryptPwValue);
                loginId.setPath("/");
                loginPw.setPath("/");
                loginId.setMaxAge(7*24*60*60);
                loginPw.setMaxAge(7*24*60*60);
                resp.addCookie(loginId);
                resp.addCookie(loginPw);
            }
            redirectAttributes.addFlashAttribute("msg","로그인 성공");
            session.setAttribute("loginUser",loginUser);
            if(redirectPage!=null){
                session.removeAttribute("redirectPage");
                return "redirect:"+redirectPage;
            }
            return "redirect:/";
        }else{
            redirectAttributes.addFlashAttribute("msg","아이디나 패스워드를 확인하세요!");
            return "redirect:/user/login.do";
        }
    }
    //아이디 찾기
    @GetMapping("/findId.do")
    public String findIdForm() {
        return "/user/findIdForm";
    }
    @PostMapping("/findId.do")
    public @ResponseBody String findIdAction(UserDto userDto, Model model,RedirectAttributes redirectAttributes) {
        UserDto user=userService.findUserIdByEmail(userDto);
        if (user==null) {
            model.addAttribute("check",1);
            return "redirect:/user/findId.do";
        } else {
            model.addAttribute("check",2);
            model.addAttribute("userId",user.getUserId());
            redirectAttributes.addFlashAttribute("findUserId",user.getUserId());
            return "";
        }
    }
    //ResponseBody : 모달, 텍스트 등으로 받을때 사용한다.
}