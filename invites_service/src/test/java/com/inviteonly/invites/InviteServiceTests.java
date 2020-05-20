package com.inviteonly.invites;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InviteRepository;
import com.inviteonly.invites.services.InviteService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.sql.Timestamp;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {InviteService.class})
public class InviteServiceTests {
	@Autowired
	private InviteService inviteService;

	@MockBean
	private InviteRepository inviteRepository;

	@Before
	public void setUp() {
		Invite invite = new Invite();
		invite.setCode("000000");
		invite.setSpaceId("0");
		invite.setExpiryDate(new Timestamp(System.currentTimeMillis() + 100000));
		invite.setInviterPhoneNumber("+27824449999");

		Mockito.when(inviteRepository.findInvite("000000", "0"))
				.thenReturn(invite);
	}

	@Test
	public void findInvite_whenValidInvite_thenReturnInvite() {
		// given
		String inviteCode = "000000";
		String spaceId = "0";

		// when
		Invite found = inviteService.findInvite(inviteCode, spaceId);

		// then
		assertEquals("000000", found.getCode());
		assertEquals("0", found.getSpaceId());
		assertEquals("+27824449999", found.getInviterPhoneNumber());
	}

	@Test
	public void findInvite_whenInvalidInvite_thenReturnNull() {
		// given
		String inviteCode = "111111";
		String spaceId = "0";

		// when
		Invite found = inviteService.findInvite(inviteCode, spaceId);

		// then
		assertNull(found);
	}

	@Test
	public void createInvite_whenCreateInvite_thenInviteCreatedWithSixDigitCode() {
		// given
		Invite invite = new Invite();
		invite.setSpaceId("1");
		invite.setInviterPhoneNumber("+27824449999");

		// when
		Mockito.when(inviteRepository.save(invite)).thenReturn(invite);
		Invite created = inviteService.createInvite(invite);

		// then
		assertEquals("1", created.getSpaceId());
		assertEquals("+27824449999", created.getInviterPhoneNumber());
		assertTrue(created.getCode().matches("\\d{6}"));
	}
}
