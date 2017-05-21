package com.growth.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.growth.service.UserService;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	
	@Autowired
	private UserService userService;
	
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder;
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/")
					  .antMatchers("/css/*")
					  .antMatchers("/fonts/*")
					  .antMatchers("/js/*")
					  .antMatchers("/img/*");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.csrf().disable()
			.authorizeRequests()
			.antMatchers("/").anonymous()
			.antMatchers("/auth/*.do").permitAll()
			.antMatchers("/**/*Write*.do").authenticated()
			.antMatchers("/**/*Edit*.do").authenticated()
			.antMatchers("/**/*Delete*.do").authenticated();
			
		http
			.logout()
			.logoutUrl("/auth/logout.do")
			.logoutSuccessUrl("/");
		
		http
			.formLogin()
			.usernameParameter("email")
			.passwordParameter("password")
			.loginPage("/auth/loginPage.do")
			.loginProcessingUrl("/auth/login.do")
			.defaultSuccessUrl("/")
			;

	}
	
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
 
		auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
		
		// In case of password encryption - for production site
		//auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
	}
	
}
