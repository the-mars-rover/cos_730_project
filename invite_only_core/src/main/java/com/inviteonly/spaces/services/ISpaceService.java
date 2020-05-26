package com.inviteonly.spaces.services;

import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ISpaceService {
	/**
	 * @param space the space that needs to be created.
	 * @return the space that has been created in the data store.
	 */
	Space createSpace(Space space);

	/**
	 * @param phoneNumber the phone number of the user creating/updating this space. This phone number will be added as a
	 *                    to the manager phone numbers of the space if it is not already.
	 * @param space the space that needs to be created or updated.
	 * @return the space that has been created or updated in the data store.
	 *
	 * @throws SpaceAuthorizationException if the space already exists and the given phone number is not one of the
	 * currently saved space's manager phone numbers.
	 */
	Space updateSpace(String phoneNumber, Space space) throws SpaceNotFoundException, SpaceAuthorizationException;

	/**
	 * @param phoneNumber the phone number of the user deleting the space.
	 * @param spaceId the id of the space being deleted.
	 *
	 * @throws SpaceAuthorizationException if the given phone number is not one of the currently saved space's manager
	 * phone numbers.
	 */
	void deleteSpace(String phoneNumber, Long spaceId) throws SpaceNotFoundException, SpaceAuthorizationException;

	/**
	 * @param phoneNumber the phone number of the user to get a list of spaces for.
	 * @return a list of spaces for which the given phone number is part of the space's manager, guard or inviter phones.
	 */
	List<Space> findUserSpaces(String phoneNumber);
}
