package com.inviteonly.invites.services;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import org.springframework.stereotype.Service;

@Service
public interface IInvitesService {
	/**
	 * @param phoneNumber the phone number of the user creating the invite.
	 * @param spaceId the space Id of the space for which the invite is being created.
	 * @return The invite object created in the data store.
	 * @throws SpaceNotFoundException if no space with the given spaceId exists.
	 * @throws SpaceAuthorizationException if the user is not a manager for the space with the given ID.
	 */
	Invite createInvite(String phoneNumber, Long spaceId) throws SpaceNotFoundException, SpaceAuthorizationException;
}
