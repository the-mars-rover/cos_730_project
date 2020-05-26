package com.inviteonly.docs.repositories;

import com.inviteonly.docs.entities.IdDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDocsRepository extends JpaRepository<IdDocument, Long> {
	List<IdDocument> findAllByPhoneNumber(String phoneNumber);
}
