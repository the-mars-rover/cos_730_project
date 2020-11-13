package com.inviteonly.security.errors;

public class AuthenticationException
    extends org.springframework.security.core.AuthenticationException {

  public AuthenticationException(String msg, Throwable throwable) {
    super(msg, throwable);
  }

  public AuthenticationException(String msg) {
    super(msg);
  }
}
