package com.inviteonly.spaces.services;

import com.inviteonly.spaces.entities.Space;
import com.inviteonly.users.entities.User;
import org.springframework.stereotype.Service;

@Service
public interface ISpaceRepository {
	/**
	 * @param phoneNumber the phone number of the user creating this space. This user will be added as a manager of the
	 *                    space if they are not already.
	 * @param space the space that needs to be created.
	 * @return the space that has been created in the data store.
	 */
	Space createSpace(String phoneNumber, Space space);

	/**
	 * @param phoneNumber the user's phone number.
	 * @param newUser a User object with the updated user details.
	 * @return the User object that has been saved/updated in the data store.
	 */
	User updateSpace(String phoneNumber, User newUser);

	/**
	 * @param phoneNumber the user's phone number.
	 */
	void deleteUser(String phoneNumber);
}
