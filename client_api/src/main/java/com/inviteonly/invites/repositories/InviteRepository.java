package com.inviteonly.invites.repositories;

import com.inviteonly.invites.entities.Invite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InviteRepository extends JpaRepository<Invite, String> {
	@Query(value = "select i from Invite i " +
			"join Space s " +
			"where s.id = :spaceId " +
			"and  i.code = :inviteCode " +
			"and i.space = s " +
			"and i.expiryDate < CURRENT_TIMESTAMP ")
	Invite findSpaceInviteByCode(@Param("spaceId") String spaceId, @Param("inviteCode") String inviteCode);
}
