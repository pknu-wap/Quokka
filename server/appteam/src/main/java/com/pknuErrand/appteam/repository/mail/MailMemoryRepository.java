package com.pknuErrand.appteam.repository.mail;

import com.pknuErrand.appteam.domain.Mail.VerificationCode;
import lombok.Getter;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Getter
@Repository
public class MailMemoryRepository {

    private Map<String, VerificationCode> storage = new HashMap<>();

    public void save(String mail, VerificationCode code) {
        storage.put(mail, code);
    }

    public Boolean isContainsMail(String mail){
        return storage.containsKey(mail);
    }

    public Optional<VerificationCode> findByMail(String mail) {
        return Optional.ofNullable(storage.get(mail));
    }

    public void remove(String mail) {
        storage.remove(mail);
    }
}
