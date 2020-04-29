package com.inviteonly.users.services;

import com.inviteonly.users.entities.User;
import com.inviteonly.users.repositories.IUserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService implements IUserService {
	private final IUserRepository repository;

	public UserService(IUserRepository repository) {
		this.repository = repository;
	}

	@Override
	public User findUser(String phoneNumber) {
		return repository.findById(phoneNumber).orElse(User.newUser(phoneNumber));
	}

	@Override
	public User updateUser(String phoneNumber, User newUser) {
		return repository.findById(phoneNumber)
				.map(user -> {
					user.setIdCard(newUser.getIdCard());
					user.setIdBook(newUser.getIdBook());
					user.setDriversLicense(newUser.getDriversLicense());
					user.setPassport(newUser.getPassport());
					return repository.save(user);
				})
				.orElseGet(() -> {
					newUser.setPhoneNumber(phoneNumber);
					return repository.save(newUser);
				});
	}

	@Override
	public void deleteUser(String phoneNumber) {
		repository.deleteById(phoneNumber);
	}
}
