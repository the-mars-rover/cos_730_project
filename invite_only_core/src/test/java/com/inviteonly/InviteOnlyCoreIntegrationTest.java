package com.inviteonly;

import com.google.firebase.auth.FirebaseAuthException;
import com.inviteonly.docs.entities.IdBook;
import com.inviteonly.docs.entities.IdCard;
import com.inviteonly.docs.repositories.IDocsRepository;
import com.inviteonly.entries.repositories.IEntryRepository;
import com.inviteonly.invites.repositories.IInvitesRepository;
import com.inviteonly.security.services.FirebaseService;
import com.inviteonly.spaces.repositories.ISpaceRepository;
import org.json.JSONObject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT, classes = InviteOnlyCore.class)
@TestPropertySource(locations = "classpath:application-test.properties")
@AutoConfigureMockMvc
@AutoConfigureTestDatabase
public class InviteOnlyCoreIntegrationTest {
	static final String VALID_TOKEN = "token";
	static final String INVALID_TOKEN = "invalidToken";
	static final String PHONE = "+27824445555";

	@Autowired
	private MockMvc mvc;

	@Autowired
	private IDocsRepository docsRepository;

	@Autowired
	private IInvitesRepository invitesRepository;

	@Autowired
	private ISpaceRepository spaceRepository;

	@Autowired
	private IEntryRepository entryRepository;

	// Unfortunately, even though the this class serves an integration test, we need to mock firebase
	// because there are no means to perform test interactions with the interface.
	@MockBean
	FirebaseService firebaseService;

	@Before
	public void setUp() throws FirebaseAuthException {
		MockitoAnnotations.initMocks(this);
		Mockito.when(firebaseService.phoneNumberForToken("token")).thenReturn(PHONE);
		Mockito.when(firebaseService.phoneNumberForToken(INVALID_TOKEN)).thenThrow(new FirebaseAuthException("errorCode", "Invalid Token"));
	}

	@After
	public void tearDown() {
		docsRepository.deleteAll();
		spaceRepository.deleteAll();
		entryRepository.deleteAll();
		invitesRepository.deleteAll();
	}

	//region <Tests for Adding an ID Document>

	@Test
	public void givenNoHeader_whenPostDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenPostDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenPostDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidDoc_whenPostDoc_thenBadRequest() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "5409145800080");
		// No gender which is a required field
		requestMap.put("birthDate", "1954-09-14");
		// No citizenship status which is a required field
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isBadRequest());
	}

	@Test
	public void givenValidIdCard_whenPostDoc_thenIdCardSaved() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idCard");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("firstNames", "John");
		requestMap.put("surname", "Snow");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("issueDate", "2015-10-21");
		requestMap.put("smartIdNumber", "00002");
		requestMap.put("nationality", "ZA");
		requestMap.put("countryOfBirth", "ZA");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.phoneNumber").value(PHONE));
	}

	@Test
	public void givenValidIdBook_whenPostDoc_thenIdBookSaved() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.phoneNumber").value(PHONE));
	}

	@Test
	public void givenValidDrivers_whenPostDoc_thenDriversSaved() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "driversLicense");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("firstNames", "John");
		requestMap.put("surname", "Snow");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("validFrom", "2015-10-14");
		requestMap.put("validTo", "2030-10-21");
		requestMap.put("licenseNumber", "00002");
		requestMap.put("vehicleCodes", "2");
		requestMap.put("licenseIssueNumber", "00002");
		requestMap.put("driverRestrictions", "N");
		requestMap.put("idNumberType", "ID Number");
		requestMap.put("vehicleRestrictions", "");
		requestMap.put("idCountryOfIssue", "ZA");
		requestMap.put("licenseCountryOfIssue", "ZA");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.phoneNumber").value(PHONE));
	}

	@Test
	public void givenValidPassport_whenPostDoc_thenPassportSaved() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "passport");
		requestMap.put("idNumber", "5409145800080");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.phoneNumber").value(PHONE));
	}

	//endregion

	//region <Tests for Getting a user's linked ID Documents>

	@Test
	public void givenNoHeader_whenGetDocs_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/docs").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenGetDocs_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenGetDocs_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenSavedDocs_whenGetDocs_thenDocList() throws Exception {
		// Given
		IdBook savedIdBook = docsRepository.save(getTestIdBook());
		IdCard savedIdCard = docsRepository.save(getTestIdCard());

		//When
		mvc.perform(MockMvcRequestBuilders.get("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.[?(@.id == " + savedIdBook.getId().toString() + ")]").exists())
				.andExpect(jsonPath("$.[?(@.id == " + savedIdCard.getId().toString() + ")]").exists());
	}

	@Test
	public void givenNoDocs_whenGetDocs_thenEmpty() throws Exception {
		//Given When
		mvc.perform(MockMvcRequestBuilders.get("/docs").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.[*]").isEmpty());
	}

	//endregion

	//region <Tests for deleting an ID Document linked too a user >

	@Test
	public void givenNoHeader_whenDeleteDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/docs/1").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenDeleteDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/docs/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenDeleteDoc_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/docs/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenNonExistentDoc_whenDeleteDoc_thenNotFound() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/docs/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenOtherUsersDoc_whenDeleteDoc_thenForbidden() throws Exception {
		// Given
		IdBook testIdBook = getTestIdBook();
		testIdBook.setPhoneNumber("+27813279999");
		IdBook savedDocument = docsRepository.save(testIdBook);

		// Given When
		String path = "/docs/" + savedDocument.getId();
		mvc.perform(MockMvcRequestBuilders.delete(path).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isForbidden());
	}

	@Test
	public void givenSavedDoc_whenDeleteDoc_thenOk() throws Exception {
		// Given
		IdBook savedDocument = docsRepository.save(getTestIdBook());

		//When
		String path = "/docs/" + savedDocument.getId();
		mvc.perform(MockMvcRequestBuilders.delete(path).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk());
	}

	//endregion

	// TODO: Integration tests for Spaces, Invites and Entry controllers.

	//region < Helper Methods >

	private IdCard getTestIdCard() {
		IdCard idCard = new IdCard();
		idCard.setPhoneNumber(PHONE);
		idCard.setIdNumber("5409145800080");
		idCard.setFirstNames("John");
		idCard.setSurname("Snow");
		idCard.setGender("M");
		idCard.setBirthDate(LocalDate.of(1954, 9, 14));
		idCard.setIssueDate(LocalDate.of(2020, 4, 4));
		idCard.setCitizenshipStatus("South African Citizen");
		idCard.setCountryOfBirth("ZA");
		idCard.setSmartIdNumber("000000");
		idCard.setNationality("ZA");

		return idCard;
	}

	private IdBook getTestIdBook() {
		IdBook idBook = new IdBook();
		idBook.setPhoneNumber(PHONE);
		idBook.setIdNumber("5409145800080");
		idBook.setGender("M");
		idBook.setBirthDate(LocalDate.of(1954, 9, 14));
		idBook.setCitizenshipStatus("South African Citizen");
		return idBook;
	}

	//endregion
}
