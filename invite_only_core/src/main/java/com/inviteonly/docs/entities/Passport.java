package com.inviteonly.docs.entities;

import javax.persistence.Entity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class Passport extends IdDocument {
  // TODO: Provide support for passports
}
