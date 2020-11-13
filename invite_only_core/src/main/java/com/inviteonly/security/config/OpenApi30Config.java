package com.inviteonly.security.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
    info = @Info(title = "Invite Only Core API", version = "v1",
        description =
            "The core API provided for the Invite Only platform. All endpoints provided by this "
                + "API "
                +
                "require a bearer token retrieved by authenticating a valid phone number."))
@SecurityScheme(
    name = "Phone Number Auth",
    type = SecuritySchemeType.HTTP,
    bearerFormat = "JWT",
    scheme = "bearer",
    description = "Supply the bearer token retrieved when authenticating a phone number"
)
public class OpenApi30Config {

}
