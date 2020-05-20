package com.inviteonly.invites;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InviteRepository;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;

import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT, classes = InvitesApplication.class)
@AutoConfigureMockMvc
//@TestPropertySource(locations = "classpath:application-test.properties")
@AutoConfigureTestDatabase
public class IntegrationTests {
	@Autowired
	private MockMvc mvc;

	@Autowired
	private InviteRepository inviteRepository;

	@Before
	public void setUp() {
		Invite validInvite = new Invite();
		validInvite.setCode("000001");
		validInvite.setSpaceId("0");
		validInvite.setExpiryDate(Timestamp.from(Instant.now().plus(Duration.ofHours(48))));
		validInvite.setInviterPhoneNumber("+27823334444");

		Invite expiredInvite = new Invite();
		expiredInvite.setCode("000002");
		expiredInvite.setSpaceId("1");
		expiredInvite.setExpiryDate(Timestamp.from(Instant.now().minus(Duration.ofHours(48))));
		expiredInvite.setInviterPhoneNumber("+27823334444");

		inviteRepository.saveAndFlush(validInvite);
		inviteRepository.saveAndFlush(expiredInvite);
	}

	@After
	public void tearDown() {
		inviteRepository.deleteAll();
	}

	@Test
	public void whenPostInvite_thenRespondWithInvite() throws Exception {
		// given
		Invite invite = new Invite();
		invite.setInviterPhoneNumber("+27819991111");
		invite.setSpaceId("2");
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, false);
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String requestJson = ow.writeValueAsString(invite);

		// when
		mvc.perform(MockMvcRequestBuilders.post("/invites")
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestJson))
				// then
				.andExpect(status().isCreated())
				.andExpect(content().contentType("application/hal+json;charset=UTF-8"))
				.andExpect(jsonPath("$.code").exists())
				.andExpect(jsonPath("$.spaceId").value("2"))
				.andExpect(jsonPath("$.inviterPhoneNumber").value("+27819991111"))
				.andExpect(jsonPath("$._links.self.href").exists());
	}

	@Test
	public void whenGetValidInvite_thenRespondWithInvite() throws Exception {
		// when
		mvc.perform(MockMvcRequestBuilders.get("/invites")
				.param("inviteCode", "000001")
				.param("spaceId", "0"))
				.andDo(print())
				// then
				.andExpect(status().isOk())
				.andExpect(content().contentType("application/hal+json;charset=UTF-8"))
				.andExpect(jsonPath("$.code").value("000001"))
				.andExpect(jsonPath("$.spaceId").value("0"))
				.andExpect(jsonPath("$.inviterPhoneNumber").value("+27823334444"))
				.andExpect(jsonPath("$._links.self.href", is("http://localhost/invites?inviteCode=000001&spaceId=0")));
	}

	@Test
	public void whenGetExpiredInvite_thenRespondWithNotFound() throws Exception {
		// when
		mvc.perform(MockMvcRequestBuilders.get("/invites")
				.param("inviteCode", "000002")
				.param("spaceId", "1"))
				.andDo(print())
				// then
				.andExpect(status().isNotFound());
	}
}
