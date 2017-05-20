package com.growth;

import java.util.Locale;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@ComponentScan
@EnableAutoConfiguration
public class GrowthApplication {

	public static void main(String[] args) {
		SpringApplication.run(GrowthApplication.class, args);
	}
	
	 @Bean
	    public LocaleResolver localeResolver() {
	        SessionLocaleResolver slr = new SessionLocaleResolver();
	        slr.setDefaultLocale(Locale.KOREA);
	        return slr;
	    }
	    @Bean
	    public ReloadableResourceBundleMessageSource messageSource() {
	        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
	        messageSource.setDefaultEncoding("utf-8");
	        messageSource.setBasename("classpath:locale/message");
	        messageSource.setCacheSeconds(3600); //refresh cache once per hour
	        return messageSource;
	    }
}
