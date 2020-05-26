package com.inviteonly.docs.entities;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import lombok.Data;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Data
@Inheritance(strategy = InheritanceType.JOINED)
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property = "type")
@JsonSubTypes({
		@JsonSubTypes.Type(value = IdBook.class, name = "idBook"),
		@JsonSubTypes.Type(value = IdCard.class, name = "idCard"),
		@JsonSubTypes.Type(value = DriversLicense.class, name = "driversLicense"),
		@JsonSubTypes.Type(value = Passport.class, name = "passport")
})
abstract public class IdDocument {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Nullable
	private String phoneNumber;

	@NotNull
	private String idNumber;
}
