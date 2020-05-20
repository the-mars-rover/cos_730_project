package com.inviteonly.invites;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InviteRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.context.junit4.SpringRunner;

import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

@RunWith(SpringRunner.class)
@DataJpaTest
public class InviteRepositoryTests {
	@Autowired
	private TestEntityManager entityManager;

	@Autowired
	private InviteRepository inviteRepository;

	@Test
	public void whenFindValidInvite_thenReturnInvite() {
		// given
		Invite invite = new Invite();
		invite.setCode("000000");
		invite.setSpaceId("0");
		invite.setExpiryDate(new Timestamp(System.currentTimeMillis() + 100000));
		invite.setInviterPhoneNumber("+27824449999");
		entityManager.persist(invite);
		entityManager.flush();

		// when
		Invite found = inviteRepository.findInvite("000000", "0");

		// then
		assertEquals("000000", found.getCode());
		assertEquals("0", found.getSpaceId());
		assertEquals("+27824449999", found.getInviterPhoneNumber());
	}

	@Test
	public void whenFindExpiredInvite_thenReturnNull() {
		// given
		Invite invite = new Invite();
		invite.setCode("000000");
		invite.setSpaceId("0");
		invite.setExpiryDate(new Timestamp(System.currentTimeMillis() - 100000));
		invite.setInviterPhoneNumber("+27824449999");
		entityManager.persist(invite);
		entityManager.flush();

		// when
		Invite found = inviteRepository.findInvite("111111", "0");

		// then
		assertNull(found);
	}
}
