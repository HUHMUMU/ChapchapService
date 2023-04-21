package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.EmailDto;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class EmailService {
    private JavaMailSender javaMailSender;

    public EmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
    public void sendMail (EmailDto emailDto) throws MessagingException {
        MimeMessage mimeMessage=javaMailSender.createMimeMessage(); //메일 보내려고 준비
        MimeMessageHelper mimeMessageHelper=new MimeMessageHelper(mimeMessage);
        mimeMessageHelper.setTo(emailDto.getTo());
        mimeMessageHelper.setSubject(emailDto.getTitle());
        mimeMessageHelper.setText(emailDto.getMessage(), true);
        javaMailSender.send(mimeMessage);
    }
}
