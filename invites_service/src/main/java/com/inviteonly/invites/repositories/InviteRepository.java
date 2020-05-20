package com.inviteonly.invites.repositories;

import com.inviteonly.invites.entities.Invite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InviteRepository extends JpaRepository<Invite, String> {
	@Query("SELECT i FROM Invite i " +
			"WHERE i.code = :inviteCode " +
			"AND i.spaceId = :spaceId " +
			"AND i.expiryDate >= current_date ")
	Invite findInvite(@Param("inviteCode") String inviteCode, @Param("spaceId") String spaceId);
}
