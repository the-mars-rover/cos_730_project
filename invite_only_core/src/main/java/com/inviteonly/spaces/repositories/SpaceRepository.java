package com.inviteonly.spaces.repositories;

import com.inviteonly.spaces.entities.Space;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SpaceRepository extends JpaRepository<Space, Long> {

  List<Space> findDistinctByManagerPhonesOrInviterPhonesOrGuardPhones(
      String managerPhone, String guardPhone, String inviterPhone);
}
