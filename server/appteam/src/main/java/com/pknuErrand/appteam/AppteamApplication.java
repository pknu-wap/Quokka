package com.pknuErrand.appteam;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AppteamApplication {


	public static void main(String[] args) {

		SpringApplication.run(AppteamApplication.class, args);

		System.out.println("develop - BE Branch");

	}

}