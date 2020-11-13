package com.inviteonly.docs.repositories;

import com.inviteonly.docs.entities.IdDocument;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DocsRepository extends JpaRepository<IdDocument, Long> {

  List<IdDocument> findAllByPhoneNumber(String phoneNumber);
}
