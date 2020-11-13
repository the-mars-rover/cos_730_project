package com.inviteonly.docs.entities;

import java.time.LocalDate;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class IdBook extends IdDocument {

  @NotNull
  private String gender;

  @NotNull
  private LocalDate birthDate;

  @NotNull
  private String citizenshipStatus;
}
