package com.inviteonly.entries.repositories;

import com.inviteonly.entries.entities.SpaceEntry;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IEntryRepository extends JpaRepository<SpaceEntry, Long> {
	Page<SpaceEntry> findAllBySpaceId(Long spaceId, Pageable pageable);

	@Query("select e from SpaceEntry e " +
			"where e.id = :spaceId " +
			"and (e.idDocument.phoneNumber = :phoneNumber " +
			"or e.guardPhone = :phoneNumber " +
			"or e.invite.inviterPhone = :phoneNumber)" +
			"order by e.entryDate desc")
	Page<SpaceEntry> findAllBySpaceIdAndPhoneNumber(
			@Param("spaceId") Long spaceId,
			@Param("phoneNumber") String phoneNumber,
			Pageable pageable
	);
}