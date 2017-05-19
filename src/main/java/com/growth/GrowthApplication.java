package com.growth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan
@EnableAutoConfiguration
public class GrowthApplication {

	public static void main(String[] args) {
		SpringApplication.run(GrowthApplication.class, args);
	}
}
