package com.inviteonly.invites.repositories;

import com.inviteonly.invites.entities.Invite;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InvitesRepository extends JpaRepository<Invite, Long> {

  @Query(
      "select i from Invite i "
          + "left join i.entry e "
          + "where e is null "
          + "and i.space.id = :spaceId "
          + "and i.code = :inviteCode "
          + "and i.expiryDate > :current")
  Optional<Invite> findBySpaceIdAndInviteCode(
      @Param("spaceId") Long spaceId,
      @Param("inviteCode") String inviteCode,
      @Param("current") LocalDateTime current);
}
