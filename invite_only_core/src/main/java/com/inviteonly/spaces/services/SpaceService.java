package com.inviteonly.spaces.services;

import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.repositories.ISpaceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SpaceService implements ISpaceService {
	private final ISpaceRepository spaceRepository;

	@Override
	public Space createSpace(Space space) {
		return spaceRepository.save(space);
	}

	@Override
	public Space updateSpace(String phoneNumber, Space space) throws SpaceNotFoundException, SpaceAuthorizationException {
		Space savedSpace = spaceRepository.findById(space.getId()).orElseThrow(SpaceNotFoundException::new);

		if (!savedSpace.hasManager(phoneNumber)) {
			throw new SpaceAuthorizationException(
					String.format("%s does not have authorization to update the existing space", phoneNumber));
		}

		return spaceRepository.save(space);
	}

	@Override
	public void deleteSpace(String phoneNumber, Long spaceId) throws SpaceNotFoundException, SpaceAuthorizationException {
		Space savedSpace = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);

		if (!savedSpace.hasManager(phoneNumber)) {
			throw new SpaceAuthorizationException(
					String.format("%s does not have authorization to delete the existing space", phoneNumber));
		}

		spaceRepository.deleteById(spaceId);
	}

	@Override
	public List<Space> findUserSpaces(String phoneNumber) {
		return spaceRepository.findDistinctByManagerPhonesOrInviterPhonesOrGuardPhones(
				phoneNumber, phoneNumber, phoneNumber);
	}
}
