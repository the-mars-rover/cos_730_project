package com.inviteonly.security.services;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SecurityService {
	private final Environment environment;

	public String authenticatedPhone() {
		if (environment.getActiveProfiles().length > 0 && environment.getActiveProfiles()[0].equals("dev")) {
			return "+27823456789";
		}

		SecurityContext securityContext = SecurityContextHolder.getContext();
		Object principal = securityContext.getAuthentication().getPrincipal();

		if (principal instanceof String) {
			return (String) principal;
		}

		return null;
	}
}
