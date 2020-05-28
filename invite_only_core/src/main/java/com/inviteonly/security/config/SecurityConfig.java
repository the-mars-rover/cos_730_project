package com.inviteonly.security.config;

import com.inviteonly.security.filters.AuthFilter;
import com.inviteonly.security.services.FirebaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, jsr250Enabled = true, prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	private final FirebaseService firebaseService;

	@Override
	protected void configure(HttpSecurity http) {
		http.addFilterBefore(new AuthFilter(firebaseService), UsernamePasswordAuthenticationFilter.class);
	}
}