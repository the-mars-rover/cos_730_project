package com.inviteonly.accesses.repositories;

import com.inviteonly.accesses.entities.Access;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccessRepository extends JpaRepository<Access, String> {
}
