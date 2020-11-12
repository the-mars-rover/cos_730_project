package com.inviteonly.security.filters;

import com.inviteonly.security.errors.AuthenticationException;
import com.inviteonly.security.services.SecurityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.WebUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@Slf4j
@RequiredArgsConstructor
public class AuthFilter extends OncePerRequestFilter {
	private final SecurityService securityService;

	@Override
	protected void doFilterInternal(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response,
	                                @NotNull FilterChain filterChain)
			throws IOException, ServletException {
		try {
			// Get token and validate it with Firebase
			Cookie cookieToken = WebUtils.getCookie(request, "token");
			String token = cookieToken == null ? request.getHeader(HttpHeaders.AUTHORIZATION).substring(7) :
					cookieToken.getValue();
			String phoneNumber = securityService.phoneNumberForToken(token);

			// Set authentication details
			UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(phoneNumber,
					token, null);
			authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authentication);

			// Apply the filter
			filterChain.doFilter(request, response);
		} catch (NullPointerException | IndexOutOfBoundsException | AuthenticationException e) {
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
		}
	}

	@Override
	protected boolean shouldNotFilter(HttpServletRequest request) {
		String path = request.getRequestURI().substring(request.getContextPath().length());
		boolean requiresPhoneAuth;
		requiresPhoneAuth = path.startsWith("/docs")
				|| path.startsWith("/spaces");
		return !requiresPhoneAuth;
	}
}