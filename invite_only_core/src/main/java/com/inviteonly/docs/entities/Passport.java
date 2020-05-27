package com.inviteonly.docs.entities;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class Passport extends IdDocument {
	//TODO: Provide support for passports
}
