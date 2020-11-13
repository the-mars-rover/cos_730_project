package com.inviteonly.docs.entities;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.lang.Nullable;

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
public abstract class IdDocument {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  @Nullable
  private String phoneNumber;

  @NotNull
  private String idNumber;
}
