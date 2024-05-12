package com.pknuErrand.appteam.service.mail;

import com.pknuErrand.appteam.domain.Mail.VerificationCode;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.repository.mail.MailMemoryRepository;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.Map;

@Service
@Transactional
public class MailService {
    private final MemberRepository memberRepository;
    private final MailMemoryRepository mailMemoryRepository;
    private JavaMailSender mailSender;
    @Autowired
    MailService(MemberRepository memberRepository, MailMemoryRepository mailMemoryRepository, JavaMailSender mailSender) {
        this.memberRepository = memberRepository;
        this.mailMemoryRepository = mailMemoryRepository;
        this.mailSender = mailSender;
    }

    public void sendMail(String mail) throws MessagingException, UnsupportedEncodingException {
        if(!isValidMailFormat(mail))
            throw new CustomException(ErrorCode.INVALID_FORMAT, "이메일 포맷은 \"@pukyong.ac.kr\" 이어야 합니다.");
        if(isDuplicateEmail(mail))
            throw new CustomException(ErrorCode.DUPLICATE_DATA, "이미 존재하는 이메일입니다.");

        VerificationCode code = new VerificationCode();
        mailMemoryRepository.save(mail, code);
        MimeMessage mimeMessage = createMail(mail, code.getCode());
        mailSender.send(mimeMessage);
    }

    public void checkCode(String mail, String code) {
        if(!mailMemoryRepository.isContainsMail(mail))
            throw new CustomException(ErrorCode.MAIL_NOT_FOUND, "해당 mail을 찾을 수 없습니다.");
        VerificationCode verificationCode = mailMemoryRepository.findByMail(mail).orElseThrow(() -> new CustomException(ErrorCode.SERVER_ERROR, "저장소에 key(mail)은 저장되어있지만 value(code)가 저장되어있지 않습니다. 백엔드팀에 보고바람."));
        if(!verificationCode.getCode().equals(code))
            throw new CustomException(ErrorCode.INVALID_VALUE, "인증번호가 틀립니다.");

        /** 유효시간 over or 인증완료 이므로 삭제 **/
        mailMemoryRepository.remove(mail);

        if(verificationCode.getExpiredTime().isBefore(LocalDateTime.now())) {
            throw new CustomException(ErrorCode.EXPIRED_TIME, "유효시간 5분이 지났습니다.");
        }
    }
    public void clearExpiredEntryInMemoryStorage() {
        Map<String, VerificationCode> map = mailMemoryRepository.getStorage();
        for(Map.Entry<String, VerificationCode> entry : map.entrySet()) {
            if(entry.getValue().getExpiredTime().isBefore(LocalDateTime.now()))
                mailMemoryRepository.remove(entry.getKey());
        }
    }

    public Boolean isValidMailFormat(String email) {
        return email.split("@")[1].equals("pukyong.ac.kr");
    }
    public Boolean isDuplicateEmail(String mail) {
        return memberRepository.existsByMail(mail);
    }
    public MimeMessage createMail(String mail, String code) throws MessagingException, UnsupportedEncodingException {
        String setFrom = "ruddbs2410@naver.com";
        String toEmail = mail;
        String title = "커카 회원가입 인증번호";

        MimeMessage message = mailSender.createMimeMessage();
        message.setText("UTF-8", "html");
        message.addRecipients(MimeMessage.RecipientType.TO, toEmail);
        message.setSubject(title);

        // 메일 내용
        String msgOfEmail="";
        msgOfEmail += "<div style='margin:20px;'>";
        msgOfEmail += "<h1> 안녕하세요 커카입니커카~ </h1>";
        msgOfEmail += "<br>";
        msgOfEmail += "<p>아래 코드를 입력해주세요<p>";
        msgOfEmail += "<br>";
        msgOfEmail += "<p>감사합니다.<p>";
        msgOfEmail += "<br>";
        msgOfEmail += "<div align='center' style='border:1px solid black; font-family:verdana';>";
        msgOfEmail += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
        msgOfEmail += "<div style='font-size:130%'>";
        msgOfEmail += "CODE : <strong>";
        msgOfEmail += code + "</strong><div><br/> ";
        msgOfEmail += "</div>";

        message.setFrom(setFrom);
        message.setText(msgOfEmail, "utf-8", "html");

        return message;
    }
}
