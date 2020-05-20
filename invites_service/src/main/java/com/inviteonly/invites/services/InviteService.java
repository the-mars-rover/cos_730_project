package com.inviteonly.invites.services;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InviteRepository;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class InviteService {
	private final InviteRepository inviteRepository;

	public Invite createInvite(Invite invite) {
		int randomNumber =  new Random().nextInt(999999);
		String code = StringUtils.leftPad(Integer.toString(randomNumber), 6, '0');
		invite.setCode(code);
		invite.setExpiryDate(Timestamp.from(Instant.now().plus(Duration.ofHours(48))));
		return inviteRepository.save(invite);
	}

	public Invite findInvite(String inviteCode, String spaceId) {
		return inviteRepository.findInvite(inviteCode, spaceId);
	}
}
