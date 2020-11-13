package com.inviteonly.entries.repositories;

import com.inviteonly.entries.entities.SpaceEntry;
import java.time.LocalDateTime;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface EntryRepository extends JpaRepository<SpaceEntry, Long> {

  @Query(
      "select e from SpaceEntry e "
          + "where e.space.id = :spaceId "
          + "and e.entryDate > :from "
          + "and e.entryDate < :to")
  Page<SpaceEntry> findAllBySpaceId(
      @Param("spaceId") Long spaceId,
      @Param("from") LocalDateTime from,
      @Param("to") LocalDateTime to,
      Pageable pageable);

  @Query(
      "select e from SpaceEntry e "
          + "where e.space.id = :spaceId "
          + "and (e.idDocument.phoneNumber = :phoneNumber "
          + "or e.guardPhone = :phoneNumber "
          + "or e.invite.inviterPhone = :phoneNumber) "
          + "and e.entryDate > :from "
          + "and e.entryDate < :to")
  Page<SpaceEntry> findAllBySpaceIdAndPhoneNumber(
      @Param("spaceId") Long spaceId,
      @Param("phoneNumber") String phoneNumber,
      @Param("from") LocalDateTime from,
      @Param("to") LocalDateTime to,
      Pageable pageable);
}
