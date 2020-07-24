package com.inviteonly.entries.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;

public interface IEntryService {
	/**
	 * @param phoneNumber the phone number of the user granting the entry
	 * @param spaceId the space id of the space that the entry is being granted for
	 * @param idDocument the id document of the resident being granted access to
	 * @return the entry object that has been added
	 * @throws DocNotFoundException if the no document could be found matching the given document
	 * @throws SpaceNotFoundException if no space with the given ID could be found
	 * @throws SpaceAuthorizationException if the given phone number is not allowed to grant entry or the person
	 * linked to the given document is not allowed entry to the space
	 * with the given id.
	 */
	SpaceEntry addResidentEntry(String phoneNumber, Long spaceId, IdDocument idDocument)
			throws DocNotFoundException, SpaceNotFoundException, SpaceAuthorizationException;

	/**
	 * @param phoneNumber the phone number of the user granting the entry
	 * @param spaceId the space id of the space that the entry is being granted for
	 * @param inviteCode the invite code provided by the visitor
	 * @return the entry object that has been added
	 * @throws SpaceNotFoundException if no space with the given ID could be found
	 * @throws SpaceAuthorizationException if the given phone number is not allowed to grant entry
	 * @throws InvalidInviteCode if the invite code is not valid
	 */
	SpaceEntry addVisitorEntry(String phoneNumber, Long spaceId, IdDocument idDocument, String inviteCode)
			throws SpaceNotFoundException, SpaceAuthorizationException, InvalidInviteCode;

	/**
	 * @param phoneNumber the phone number of the manager or inviter retrieving entries for the space
	 * @param spaceId the space id of the space to retrieve entries for
	 * @param pageable a list of relevant entries
	 * @return a page of entries that have relevance to the given phone number, or an empty list.
	 * @throws SpaceNotFoundException if the space with the given ID could not be found
	 */
	Page<SpaceEntry> findEntries(String phoneNumber, Long spaceId, LocalDateTime from, LocalDateTime to, Pageable pageable) throws SpaceNotFoundException;
}
