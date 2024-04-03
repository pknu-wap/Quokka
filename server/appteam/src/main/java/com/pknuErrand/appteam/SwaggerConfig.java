package com.pknuErrand.appteam;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Swagger springdoc-ui 구성 파일
 */
@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI() {
        Info info = new Info()
                .title("2024-1 WAP APP1 API Document")
                .version("v0.0.1")
                .description("쿼카 API 문서입니다람쥐~");
        return new OpenAPI()
                .components(new Components())
                .info(info);
    }
}
