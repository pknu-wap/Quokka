package com.pknuErrand.appteam;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.Status;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.Timestamp;

@SpringBootApplication
public class AppteamApplication {

	public static void main(String[] args) {

		SpringApplication.run(AppteamApplication.class, args);
	}

}
