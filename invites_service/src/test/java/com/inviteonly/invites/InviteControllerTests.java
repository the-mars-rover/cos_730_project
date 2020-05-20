package com.inviteonly.invites;

import com.inviteonly.invites.controllers.InviteController;
import com.inviteonly.invites.controllers.InviteResourceAssembler;
import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.services.InviteService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.hateoas.Resource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {InviteController.class})
public class InviteControllerTests {
	@Autowired
	private InviteController inviteController;

	@MockBean
    private InviteService inviteService;

	@MockBean
	InviteResourceAssembler assembler;

	@Test
	public void whenCreateInvite_thenReturnInvite() {
		// given
		Invite invite = new Invite();
		invite.setCode("000000");
		invite.setSpaceId("0");
		invite.setExpiryDate(new Timestamp(System.currentTimeMillis() + 100000));
		invite.setInviterPhoneNumber("+27824449999");
		when(inviteService.createInvite(invite)).thenReturn(invite);
		when(assembler.toResource(invite)).thenReturn(new Resource<>(invite));

		//when
		Resource<Invite> resource = inviteController.createInvite(invite);

		//then
		assertEquals("000000", resource.getContent().getCode());
		assertEquals("0", resource.getContent().getSpaceId());
		assertEquals("+27824449999", resource.getContent().getInviterPhoneNumber());
	}

	@Test
	public void whenGetValidInvite_thenReturnInvite() {
		// given
		Invite invite = new Invite();
		invite.setCode("000000");
		invite.setSpaceId("0");
		invite.setExpiryDate(new Timestamp(System.currentTimeMillis() + 100000));
		invite.setInviterPhoneNumber("+27824449999");
		when(inviteService.findInvite("000000", "0")).thenReturn(invite);
		when(assembler.toResource(invite)).thenReturn(new Resource<>(invite));

		// when
		Resource<Invite> resource = inviteController.readInvite("000000", "0");

		// then
		assertEquals("000000", resource.getContent().getCode());
		assertEquals("0", resource.getContent().getSpaceId());
		assertEquals("+27824449999", resource.getContent().getInviterPhoneNumber());
	}

	@Test
	public void whenGetInvalidInvite_thenNotFound() {
		// given
		when(inviteService.findInvite("000000", "0")).thenReturn(null);

		try {
			// when
			inviteController.readInvite("000000", "0");
		} catch (ResponseStatusException e) {
			// then
			assertEquals(404, e.getStatus().value());
		}
	}
}
