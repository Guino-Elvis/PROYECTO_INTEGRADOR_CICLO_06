package com.example.inscripccion;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

@EnableFeignClients
@SpringBootApplication
public class InscripccionApplication {

	public static void main(String[] args) {
		SpringApplication.run(InscripccionApplication.class, args);
	}

	@Bean
	public OpenAPI custoOpenAPI() {
		return new OpenAPI().info(new Info()
				.title("OPEN API MICROSERVICIOS INSCRIPCCION")
				.version("0.0.1")
				.description("servicio web inscripccion")
				.termsOfService("http://swagger.io/terms")
				.license(new License().name("Apache 2.0").url("http://springdoc.org")));
	}

}
// juanitoooo