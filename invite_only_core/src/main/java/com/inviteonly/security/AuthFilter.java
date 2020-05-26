package com.inviteonly.security;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.http.HttpStatus;
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
@RequiredArgsConstructor
public class AuthFilter extends OncePerRequestFilter {
	@Override
	protected void doFilterInternal(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull FilterChain filterChain)
			throws IOException, ServletException {
		try {
			String token = getTokenFromRequest(request);
			FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(token);

			UserRecord userRecord = FirebaseAuth.getInstance().getUser(decodedToken.getUid());
			UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
					userRecord.getPhoneNumber(), decodedToken, null);
			authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authentication);

			filterChain.doFilter(request, response);
		} catch (FirebaseAuthException e) {
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.getWriter().write("Unauthorized");
		}
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