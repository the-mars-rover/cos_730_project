package com.inviteonly.invites.services;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.IInvitesRepository;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.repositories.ISpaceRepository;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class InvitesService implements IInvitesService {
	private final ISpaceRepository spaceRepository;
	private final IInvitesRepository invitesRepository;

	@Override
	public Invite createInvite(String phoneNumber, Long spaceId) throws SpaceNotFoundException, SpaceAuthorizationException {
		Space savedSpace = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);

		if (!savedSpace.hasInviter(phoneNumber)) {
			throw new SpaceAuthorizationException(
					String.format("%s does not have authorization to create invites for the space", phoneNumber));
		}

		Invite invite = new Invite();
		invite.setInviterPhone(phoneNumber);
		invite.setSpace(savedSpace);
		invite.setExpiryDate(LocalDateTime.now().plus(Duration.ofHours(48)));
		int randomNumber =  new Random().nextInt(999999);
		String code = StringUtils.leftPad(Integer.toString(randomNumber), 6, '0');
		invite.setCode(code);

		return invitesRepository.save(invite);
	}
}
