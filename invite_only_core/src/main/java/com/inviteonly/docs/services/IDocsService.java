package com.inviteonly.docs.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocOwnerException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IDocsService {
	/**
	 * @param ownerPhoneNumber the user's phone number.
	 * @return the list of documents linked to the given owner phone number.
	 */
	List<IdDocument> findUserDocuments(String ownerPhoneNumber);

	/**
	 * @param phoneNumber the phone number of the user to add the document to.
	 * @param idDocument the ID Document to be added.
	 * @return document as it has been stored.
	 * @throws DocOwnerException if the document has already been saved by another user.
	 */
	IdDocument addUserDocument(String phoneNumber, IdDocument idDocument) throws DocOwnerException;
}
