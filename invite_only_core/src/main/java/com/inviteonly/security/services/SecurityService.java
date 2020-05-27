package com.inviteonly.security.services;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class SecurityService {
	public String authenticatedPhone() {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		Object principal = securityContext.getAuthentication().getPrincipal();

		if (principal instanceof String) {
			return (String) principal;
		}

		return null;
	}
}
