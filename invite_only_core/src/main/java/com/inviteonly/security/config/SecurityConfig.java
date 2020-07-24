package com.inviteonly.security.config;

import com.inviteonly.security.filters.AuthFilter;
import com.inviteonly.security.services.FirebaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
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

	private final Environment environment;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable().addFilterBefore(new AuthFilter(firebaseService, environment), UsernamePasswordAuthenticationFilter.class);
	}
}
