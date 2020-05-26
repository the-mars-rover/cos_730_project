package com.inviteonly.spaces.repositories;

import com.inviteonly.spaces.entities.Space;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISpaceRepository extends JpaRepository<Space, Long> {
	List<Space> findDistinctByManagerPhonesOrInviterPhonesOrGuardPhones(
			String managerPhone, String guardPhone, String inviterPhone);
}
