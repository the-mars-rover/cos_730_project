package com.inviteonly.security;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import com.inviteonly.users.entities.User;
import com.inviteonly.users.services.UserService;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
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
public class AuthFilter extends OncePerRequestFilter {
	@Autowired
	private UserService userService;

	@Override
	protected void doFilterInternal(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull FilterChain filterChain)
			throws IOException, ServletException {
		String token = getTokenFromRequest(request);
		try {
			FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(token);

			UserRecord userRecord = FirebaseAuth.getInstance().getUser(decodedToken.getUid());
			User savedUser = userService.findUser(userRecord.getPhoneNumber());
			UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
					savedUser, decodedToken, null);
			authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authentication);
		} catch (FirebaseAuthException e) {
			log.error("Firebase Exception:: ", e.getLocalizedMessage());
		}

		filterChain.doFilter(request, response);
	}

	private String getTokenFromRequest(HttpServletRequest request) {
		String token = null;
		Cookie cookieToken = WebUtils.getCookie(request, "token");
		if (cookieToken != null) {
			token = cookieToken.getValue();
		} else {
			String bearerToken = request.getHeader("Authorization");
			if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
				token = bearerToken.substring(7);
			}
		}
		return token;
	}
}