package com.inviteonly.users.services;

import com.inviteonly.users.entities.User;
import org.springframework.stereotype.Service;

@Service
public interface IUserService {
	/**
	 * @param phoneNumber the user's phone number.
	 * @return the saved user with the given phone number or, if no saved user exists with the given phone number -
	 * a new user object with the given phone number.
	 */
	User findUser(String phoneNumber);

	/**
	 * @param phoneNumber the user's phone number.
	 * @param newUser a User object with the updated user details.
	 * @return the User object that has been saved/updated in the data store.
	 */
	User updateUser(String phoneNumber, User newUser);

	/**
	 * @param phoneNumber the user's phone number.
	 */
	void deleteUser(String phoneNumber);
}
