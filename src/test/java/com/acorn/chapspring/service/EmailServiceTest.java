package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.EmailDto;
import jakarta.mail.MessagingException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class EmailServiceTest {
    @Autowired
    private EmailService emailService;
    @Test
    void sendMail() throws MessagingException {
        EmailDto emailDto=new EmailDto();
        emailDto.setTo("fhrzl55040@gmail.com");
        emailDto.setTitle("이메일 보내기 테스트");
        emailDto.setMessage("<p>내용 입니다.<b>윤우상</b></p>");
        emailService.sendMail(emailDto);
    }
}
