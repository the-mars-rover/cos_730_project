package com.inviteonly.docs.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.errors.DocOwnerException;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface DocsServiceInterface {

  /**
   * Find the list of user documents based on their phone number.
   *
   * @param ownerPhoneNumber the user's phone number.
   * @return the list of documents linked to the given owner phone number.
   */
  List<IdDocument> findUserDocuments(String ownerPhoneNumber);

  /**
   * Add a document to a user based on their phone number.
   *
   * @param phoneNumber the phone number of the user to add the document to.
   * @param idDocument  the ID Document to be added.
   * @return document as it has been stored.
   * @throws DocOwnerException if the document has already been saved by another user.
   */
  IdDocument addUserDocument(String phoneNumber, IdDocument idDocument) throws DocOwnerException;

  /**
   * Delete a document from a user based on the document ID.
   *
   * @param phoneNumber the phone number of the user to whom the document belongs.
   * @param documentId  the id of the document to be deleted.
   * @throws DocOwnerException    if the saved document does not belong to the user with the given
   *                              phone number.
   * @throws DocNotFoundException if no document with the given id could be found linked to the
   *                              user.
   */
  void deleteUserDocument(String phoneNumber, Long documentId)
      throws DocNotFoundException, DocOwnerException;
}
