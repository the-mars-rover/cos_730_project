package com.inviteonly.docs.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocOwnerException;
import com.inviteonly.docs.repositories.IDocsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DocsService implements IDocsService {
	private final IDocsRepository docsRepository;


	@Override
	public List<IdDocument> findUserDocuments(String phoneNumber) {
		return docsRepository.findAllByPhoneNumber(phoneNumber);
	}

	@Override
	public IdDocument addUserDocument(String phoneNumber, IdDocument idDocument) throws DocOwnerException {
		idDocument.setPhoneNumber(null);
		IdDocument storedDocument = docsRepository.findOne(Example.of(idDocument)).orElse(null);

		if (storedDocument == null) {
			idDocument.setPhoneNumber(phoneNumber);
			return docsRepository.save(idDocument);
		}

		String currentOwner = storedDocument.getPhoneNumber();
		if (currentOwner != null && !currentOwner.equals(phoneNumber)) {
			throw new DocOwnerException();
		}

		storedDocument.setPhoneNumber(phoneNumber);
		return docsRepository.save(idDocument);
	}
}
