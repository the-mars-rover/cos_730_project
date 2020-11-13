package com.inviteonly.invites.services;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InvitesRepository;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.repositories.SpaceRepository;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Random;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class InvitesService implements InvitesServiceInterface {

  private final SpaceRepository spaceRepository;
  private final InvitesRepository invitesRepository;

  @Override
  public Invite createInvite(String phoneNumber, Long spaceId)
      throws SpaceNotFoundException, SpaceAuthorizationException {
    Space savedSpace = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);

    if (!savedSpace.hasInviter(phoneNumber)) {
      throw new SpaceAuthorizationException(
          String.format(
              "%s does not have authorization to create invites for the space", phoneNumber));
    }

    Invite invite = new Invite();
    invite.setInviterPhone(phoneNumber);
    invite.setSpace(savedSpace);
    invite.setExpiryDate(LocalDateTime.now().plus(Duration.ofHours(48)));
    int randomNumber = new Random().nextInt(999999);
    String code = StringUtils.leftPad(Integer.toString(randomNumber), 6, '0');
    invite.setCode(code);

    return invitesRepository.save(invite);
  }
}
