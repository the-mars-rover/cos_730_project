package com.inviteonly.entries.services;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.repositories.IDocsRepository;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.repositories.IEntryRepository;
import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.invites.repositories.IInvitesRepository;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.repositories.ISpaceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class EntryService implements IEntryService {
	private final ISpaceRepository spaceRepository;
	private final IDocsRepository docsRepository;
	private final IEntryRepository entryRepository;
	private final IInvitesRepository invitesRepository;

	@Override
	public SpaceEntry addResidentEntry(String phoneNumber, Long spaceId, IdDocument idDocument) throws DocNotFoundException, SpaceNotFoundException, SpaceAuthorizationException {
		Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);
		if (!space.hasGuard(phoneNumber)) {
			throw new SpaceAuthorizationException(
					String.format("%s is not authorized to grant entry to this space", phoneNumber));
		}

		IdDocument storedDoc = docsRepository.findOne(Example.of(idDocument)).orElseThrow(DocNotFoundException::new);
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
	public SpaceEntry addVisitorEntry(String phoneNumber, Long spaceId, IdDocument idDocument, String inviteCode)
			throws SpaceNotFoundException, SpaceAuthorizationException, InvalidInviteCode {
		Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);
		if (!space.hasGuard(phoneNumber)) {
			throw new SpaceAuthorizationException(
					String.format("%s is not authorized to grant entry to this space", phoneNumber));
		}

		idDocument = docsRepository.findOne(Example.of(idDocument)).orElse(idDocument);
		Invite invite = invitesRepository.findBySpaceIdAndInviteCode(
				spaceId, inviteCode, LocalDateTime.now()).orElseThrow(InvalidInviteCode::new);

		SpaceEntry entry = new SpaceEntry();
		entry.setGuardPhone(phoneNumber);
		entry.setEntryDate(LocalDateTime.now());
		entry.setSpace(space);
		entry.setIdDocument(idDocument);
		entry.setInvite(invite);

		return entryRepository.save(entry);
	}

	@Override
	public Page<SpaceEntry> findEntries(String phoneNumber, Long spaceId, Pageable pageable) throws SpaceNotFoundException {
		Space space = spaceRepository.findById(spaceId).orElseThrow(SpaceNotFoundException::new);
		if (space.hasManager(phoneNumber)) {
			return entryRepository.findAllBySpaceId(spaceId, pageable);
		}

		return entryRepository.findAllBySpaceIdAndPhoneNumber(spaceId, phoneNumber, pageable);
	}
}
