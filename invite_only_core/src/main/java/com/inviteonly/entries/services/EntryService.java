package com.inviteonly.entries.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.repositories.DocsRepository;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.repositories.EntryRepository;
import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.invites.repositories.InvitesRepository;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.repositories.SpaceRepository;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EntryService implements EntryServiceInterface {

  private final SpaceRepository spaceRepository;
  private final DocsRepository docsRepository;
  private final EntryRepository entryRepository;
  private final InvitesRepository invitesRepository;

  @Override
  public SpaceEntry addResidentEntry(String phoneNumber, Long spaceId, IdDocument idDocument)
      throws DocNotFoundException, SpaceNotFoundException, SpaceAuthorizationException {
    Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);
    if (!space.hasGuard(phoneNumber)) {
      throw new SpaceAuthorizationException(
          String.format("%s is not authorized to grant entry to this space", phoneNumber));
    }

    IdDocument storedDoc =
        docsRepository.findOne(Example.of(idDocument)).orElseThrow(DocNotFoundException::new);
    if (!space.hasResident(storedDoc.getPhoneNumber())) {
      throw new SpaceAuthorizationException(
          String.format("%s is not authorized to enter this space", phoneNumber));
    }

    SpaceEntry entry = new SpaceEntry();
    entry.setGuardPhone(phoneNumber);
    entry.setEntryDate(LocalDateTime.now());
    entry.setSpace(space);
    entry.setIdDocument(storedDoc);

    return entryRepository.save(entry);
  }

  @Override
  public SpaceEntry addVisitorEntry(
      String phoneNumber, Long spaceId, IdDocument idDocument, String inviteCode)
      throws SpaceNotFoundException, SpaceAuthorizationException, InvalidInviteCode {
    Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);
    if (!space.hasGuard(phoneNumber)) {
      throw new SpaceAuthorizationException(
          String.format("%s is not authorized to grant entry to this space", phoneNumber));
    }

    idDocument = docsRepository.findOne(Example.of(idDocument)).orElse(idDocument);
    Invite invite =
        invitesRepository
            .findBySpaceIdAndInviteCode(spaceId, inviteCode, LocalDateTime.now())
            .orElseThrow(InvalidInviteCode::new);

    SpaceEntry entry = new SpaceEntry();
    entry.setGuardPhone(phoneNumber);
    entry.setEntryDate(LocalDateTime.now());
    entry.setSpace(space);
    entry.setIdDocument(idDocument);
    entry.setInvite(invite);

    return entryRepository.save(entry);
  }

  @Override
  public Page<SpaceEntry> findEntries(
      String phoneNumber, Long spaceId, LocalDateTime from, LocalDateTime to, Pageable pageable)
      throws SpaceNotFoundException {
    Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);

    if (from == null) {
      // would prefer to use LocalDateTime.MIN but causes problem in SQL query. See
      // https://stackoverflow.com/questions/60884477/spring-boot-data-jpa-query-doesnt-work-with
      // -localdatetime-max
      from = LocalDateTime.of(2000, 1, 1, 0, 0, 0);
    }

    if (to == null) {
      // would prefer to use LocalDateTime.MAX but causes problem in SQL query. See
      // https://stackoverflow.com/questions/60884477/spring-boot-data-jpa-query-doesnt-work-with
      // -localdatetime-max
      to = LocalDateTime.of(3000, 1, 1, 0, 0, 0);
    }

    if (space.hasManager(phoneNumber)) {
      return entryRepository.findAllBySpaceId(spaceId, from, to, pageable);
    }

    return entryRepository.findAllBySpaceIdAndPhoneNumber(spaceId, phoneNumber, from, to, pageable);
  }
}
