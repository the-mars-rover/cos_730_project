package com.inviteonly;

import com.google.firebase.auth.FirebaseAuthException;
import com.google.gson.Gson;
import com.inviteonly.docs.entities.DriversLicense;
import com.inviteonly.docs.entities.IdBook;
import com.inviteonly.docs.entities.IdCard;
import com.inviteonly.docs.repositories.IDocsRepository;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.repositories.IEntryRepository;
import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.IInvitesRepository;
import com.inviteonly.security.services.FirebaseService;
import com.inviteonly.spaces.entities.Space;
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

import java.time.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

	// Unfortunately, we need to mock firebase because there are no means to perform test interactions with the interface.
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
		invitesRepository.deleteAll();
		entryRepository.deleteAll();
		docsRepository.deleteAll();
		spaceRepository.deleteAll();
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
		requestMap.put("vehicleCodes", List.of());
		requestMap.put("licenseIssueNumber", "00002");
		requestMap.put("driverRestrictions", "N");
		requestMap.put("idNumberType", "ID Number");
		requestMap.put("vehicleRestrictions", List.of());
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

	//region <Tests for adding a new space >

	@Test
	public void givenNoHeader_whenPostSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenPostSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenPostSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidSpace_whenPostSpace_thenBadRequest() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		// Title not set
		requestMap.put("managerPhones", List.of("+27615552222"));
		requestMap.put("guardPhones", List.of("+27615552222"));
		requestMap.put("inviterPhones", List.of("+27615552222"));
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isBadRequest());
	}

	@Test
	public void givenValidSpace_whenPostSpace_thenSpaceSaved() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("title", "The Wilds Estate");
		requestMap.put("managerPhones", List.of("+27615552222"));
		requestMap.put("guardPhones", List.of("+27615552222"));
		requestMap.put("inviterPhones", List.of("+27615552222"));
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.title").value("The Wilds Estate"));
	}

	//endregion

	//region <Tests for updating a space >

	@Test
	public void givenNoHeader_whenPutSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/1").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenPutSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenPutSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidSpaceId_whenPutSpace_thenNotFound() throws Exception {
		Space testSpace = getTestSpace();
		testSpace.setId(1L);
		String json = new Gson().toJson(testSpace);

		// Given When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(json))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenNonManagedSpace_whenPutSpace_thenForbidden() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		Space savedSpace = spaceRepository.save(testSpace);
		savedSpace.setTitle("New Title");
		savedSpace.setManagerPhones(Set.of(PHONE));
		String json = new Gson().toJson(savedSpace);

		// When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/" + savedSpace.getId()).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(json))
				// Then
				.andExpect(status().isForbidden());
	}

	@Test
	public void givenValidSpace_whenPutSpace_thenSpaceSaved() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setManagerPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		savedSpace.setTitle("New Title");
		String json = new Gson().toJson(savedSpace);

		// When
		mvc.perform(MockMvcRequestBuilders.put("/spaces/" + savedSpace.getId()).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON)
				.content(json))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.title").value("New Title"));
	}

	//endregion

	//region <Tests for retrieving accessible spaces >

	@Test
	public void givenNoHeader_whenGetSpaces_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenGetSpaces_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenGetSpaces_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenNoRelevantSpaces_whenGetSpaces_thenEmptyList() throws Exception {
		Space testSpace = getTestSpace();
		spaceRepository.save(testSpace);
		spaceRepository.save(testSpace);
		spaceRepository.save(testSpace);

		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$").isEmpty());
	}

	@Test
	public void givenSomeRelevantSpaces_whenGetSpaces_thenRelevantList() throws Exception {
		Space testSpaceA = getTestSpace();
		Space savedSpaceA = spaceRepository.save(testSpaceA);
		Space testSpaceB = getTestSpace();
		testSpaceB.setManagerPhones(Set.of(PHONE));
		Space savedSpaceB = spaceRepository.save(testSpaceB);
		Space testSpaceC = getTestSpace();
		testSpaceC.setInviterPhones(Set.of(PHONE));
		Space savedSpaceC = spaceRepository.save(testSpaceC);
		Space testSpaceD = getTestSpace();
		testSpaceD.setGuardPhones(Set.of(PHONE));
		Space savedSpaceD = spaceRepository.save(testSpaceD);

		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.[?(@.id == " + savedSpaceA.getId() + ")]").doesNotExist())
				.andExpect(jsonPath("$.[?(@.id == " + savedSpaceB.getId() + ")]").exists())
				.andExpect(jsonPath("$.[?(@.id == " + savedSpaceC.getId() + ")]").exists())
				.andExpect(jsonPath("$.[?(@.id == " + savedSpaceD.getId() + ")]").exists());
	}

	//endregion

	//region <Tests for deleting a space >

	@Test
	public void givenNoHeader_whenDeleteSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenDeleteSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenDeleteSpace_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidSpaceId_whenDeleteSpace_thenNotFound() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces/1").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenNonManagedSpace_whenDeleteSpace_thenForbidden() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		Space savedSpace = spaceRepository.save(testSpace);

		// When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces/" + savedSpace.getId()).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isForbidden());
	}

	@Test
	public void givenSpaceAndEntryAndInvite_whenDeleteSpace_thenAllDeleted() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setManagerPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		Invite testInvite = invitesRepository.save(getTestInvite(testSpace));
		SpaceEntry testEntry = entryRepository.save(getTestEntry(testSpace));

		// When
		mvc.perform(MockMvcRequestBuilders.delete("/spaces/" + savedSpace.getId()).with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk());
		assert spaceRepository.findById(savedSpace.getId()).orElse(null) == null;
		assert invitesRepository.findById(testInvite.getId()).orElse(null) == null;
		assert entryRepository.findById(testEntry.getId()).orElse(null) == null;
	}

	//endregion

	//region <Tests for invite generation >

	@Test
	public void givenNoHeader_whenPostInvite_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/invites").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenPostInvite_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/invites").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenPostInvite_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/invites").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenNonExistingSpace_whenPostInvite_thenNotFound() throws Exception {
		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/invites").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenNonInviterSpace_whenPostInvite_thenForbidden() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		Space savedSpace = spaceRepository.save(testSpace);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/" + savedSpace.getId() + "/invites").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isForbidden());
	}

	@Test
	public void givenInviterSpace_whenPostInvite_thenInviteCreated() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setInviterPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/" + savedSpace.getId() + "/invites").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.code").isNotEmpty())
				.andExpect(jsonPath("$.inviterPhone").value(PHONE));
	}

	//endregion

	//region <Tests for adding an entry >

	@Test
	public void givenNoHeader_whenPostEntry_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/entries").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenPostEntry_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenPostEntry_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenNonExistingSpace_whenPostEntry_thenNotFound() throws Exception {
		// Given
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/1/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenNoDocAndNoInviteCode_whenPostEntry_thenNotFound() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setGuardPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/" + savedSpace.getId() + "/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isNotFound());
	}

	@Test
	public void givenNonGuardingSpace_whenPostEntry_thenForbidden() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		Space savedSpace = spaceRepository.save(testSpace);
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "5409145800080");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1954-09-14");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/" + savedSpace.getId() + "/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isForbidden());
	}

	@Test
	public void givenValidID_whenPostEntry_thenEntryCreated() throws Exception {
		// Given
		// The visitor who is also an inviter for the space
		String visitorPhone = "+27651110000";
		IdBook testIdBook = getTestIdBook();
		testIdBook.setPhoneNumber(visitorPhone);
		IdBook savedIdBook = docsRepository.save(testIdBook);
		// The space for which the current user is a guard
		Space testSpace = getTestSpace();
		testSpace.setInviterPhones(Set.of(visitorPhone));
		testSpace.setGuardPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		// The request
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", testIdBook.getIdNumber());
		requestMap.put("gender", testIdBook.getGender());
		requestMap.put("birthDate", testIdBook.getBirthDate().toString());
		requestMap.put("citizenshipStatus", testIdBook.getCitizenshipStatus());
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders.post("/spaces/" + savedSpace.getId() + "/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.guardPhone").value(PHONE))
				.andExpect(jsonPath("$.idDocument.id").value(savedIdBook.getId()));
	}

	@Test
	public void givenValidEntryCode_whenPostEntry_thenEntryCreated() throws Exception {
		// Given
		// The space for which the current user is a guard
		Space testSpace = getTestSpace();
		testSpace.setGuardPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		// The invite for the space
		Invite testInvite = getTestInvite(savedSpace);
		Invite savedInvite = invitesRepository.save(testInvite);
		// The visitor ID
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "8609185800083");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1986-09-18");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders
				.post("/spaces/" + savedSpace.getId() + "/entries?inviteCode=" + savedInvite.getCode())
				.with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.guardPhone").value(PHONE))
				.andExpect(jsonPath("$.invite.id").value(savedInvite.getId()))
				.andExpect(jsonPath("$.idDocument.id").isNotEmpty())
				.andExpect(jsonPath("$.idDocument.phoneNumber").doesNotExist());
	}

	@Test
	public void givenExpiredEntryCode_whenPostEntry_thenEntryCreated() throws Exception {
		// Given
		// The space for which the current user is a guard
		Space testSpace = getTestSpace();
		testSpace.setGuardPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		// The invite for the space
		Invite testInvite = getTestInvite(savedSpace);
		testInvite.setExpiryDate(LocalDateTime.now().minus(Duration.ofHours(1)));
		Invite savedInvite = invitesRepository.save(testInvite);
		// The visitor ID
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("type", "idBook");
		requestMap.put("idNumber", "8609185800083");
		requestMap.put("gender", "M");
		requestMap.put("birthDate", "1986-09-18");
		requestMap.put("citizenshipStatus", "SA Citizen");
		JSONObject requestObject = new JSONObject(requestMap);

		// When
		mvc.perform(MockMvcRequestBuilders
				.post("/spaces/" + savedSpace.getId() + "/entries?inviteCode=" + savedInvite.getCode())
				.with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN)
				.contentType(MediaType.APPLICATION_JSON).content(requestObject.toString()))
				// Then
				.andExpect(status().isNotAcceptable());
	}

	//endregion

	//region <Tests for getting entries >

	@Test
	public void givenNoHeader_whenGetEntries_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/1/entries").with(csrf()))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenMalformedHeader_whenGetEntries_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/1/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "oops"))
				// then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenInvalidToken_whenGetEntries_thenUnauthorizedResponse() throws Exception {
		// Given When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/1/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + INVALID_TOKEN))
				// Then
				.andExpect(status().isUnauthorized());
	}

	@Test
	public void givenNoDateConstraints_whenGetEntries_thenAllEntries() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setManagerPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		SpaceEntry testEntryOne = getTestEntry(testSpace);
		testEntryOne.setEntryDate(LocalDateTime.of(2020, 1, 1, 0, 0));
		SpaceEntry savedEntryOne = entryRepository.save(testEntryOne);
		SpaceEntry testEntryTwo = getTestEntry(testSpace);
		testEntryTwo.setEntryDate(LocalDateTime.of(2020, 2, 1, 0, 0));
		SpaceEntry savedEntryTwo = entryRepository.save(testEntryTwo);
		SpaceEntry testEntryThree = getTestEntry(testSpace);
		testEntryThree.setEntryDate(LocalDateTime.of(2020, 3, 1, 0, 0));
		SpaceEntry savedEntryThree = entryRepository.save(testEntryThree);

		// When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/"+ savedSpace.getId() +"/entries").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryOne.getId() + ")]").exists())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryTwo.getId() + ")]").exists())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryThree.getId() + ")]").exists());
	}

	@Test
	public void givenFromDateConstraint_whenGetEntries_thenAllEntriesAfterFromDate() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setManagerPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		SpaceEntry testEntryOne = getTestEntry(testSpace);
		testEntryOne.setEntryDate(LocalDateTime.of(2020, 1, 1, 0, 0));
		SpaceEntry savedEntryOne = entryRepository.save(testEntryOne);
		SpaceEntry testEntryTwo = getTestEntry(testSpace);
		testEntryTwo.setEntryDate(LocalDateTime.of(2020, 2, 1, 0, 0));
		SpaceEntry savedEntryTwo = entryRepository.save(testEntryTwo);
		SpaceEntry testEntryThree = getTestEntry(testSpace);
		testEntryThree.setEntryDate(LocalDateTime.of(2020, 3, 1, 0, 0));
		SpaceEntry savedEntryThree = entryRepository.save(testEntryThree);

		// When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/"+ savedSpace.getId() +"/entries?from=2020-01-15T00:00:00").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryOne.getId() + ")]").doesNotExist())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryTwo.getId() + ")]").exists())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryThree.getId() + ")]").exists());
	}

	@Test
	public void givenToDateConstraint_whenGetEntries_thenAllEntriesBeforeToDate() throws Exception {
		// Given
		Space testSpace = getTestSpace();
		testSpace.setManagerPhones(Set.of(PHONE));
		Space savedSpace = spaceRepository.save(testSpace);
		SpaceEntry testEntryOne = getTestEntry(testSpace);
		testEntryOne.setEntryDate(LocalDateTime.of(2020, 1, 1, 0, 0));
		SpaceEntry savedEntryOne = entryRepository.save(testEntryOne);
		SpaceEntry testEntryTwo = getTestEntry(testSpace);
		testEntryTwo.setEntryDate(LocalDateTime.of(2020, 2, 1, 0, 0));
		SpaceEntry savedEntryTwo = entryRepository.save(testEntryTwo);
		SpaceEntry testEntryThree = getTestEntry(testSpace);
		testEntryThree.setEntryDate(LocalDateTime.of(2020, 3, 1, 0, 0));
		SpaceEntry savedEntryThree = entryRepository.save(testEntryThree);

		// When
		mvc.perform(MockMvcRequestBuilders.get("/spaces/"+ savedSpace.getId() +"/entries?to=2020-02-15T00:00:00").with(csrf())
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + VALID_TOKEN))
				// Then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryOne.getId() + ")]").exists())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryTwo.getId() + ")]").exists())
				.andExpect(jsonPath("$.content.[?(@.id == " + savedEntryThree.getId() + ")]").doesNotExist());
	}

	//endregion

	//region < Helper Methods >

	private DriversLicense getTestDrivers() {
		DriversLicense drivers = new DriversLicense();
		drivers.setPhoneNumber(PHONE);
		drivers.setIdNumber("5409145800080");
		drivers.setFirstNames("John");
		drivers.setSurname("Snow");
		drivers.setGender("M");
		drivers.setBirthDate(LocalDate.of(1954, 9, 14));
		drivers.setDriverRestrictions("");
		drivers.setIdCountryOfIssue("ZA");
		drivers.setIdNumberType("ZA");
		drivers.setLicenseCountryOfIssue("ZA");
		drivers.setLicenseIssueNumber("000000");
		drivers.setLicenseNumber("000000");
		drivers.setValidFrom(LocalDate.now().minus(Period.ofDays(365)));
		drivers.setValidTo(LocalDate.now().minus(Period.ofDays(365)));
		drivers.setPrdpCode("prdpCode");
		drivers.setPrdpExpiry(LocalDate.now().minus(Period.ofDays(365)));
		drivers.setVehicleCodes(List.of("B"));
		drivers.setVehicleRestrictions(List.of("0000"));

		return drivers;
	}

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

	private Space getTestSpace() {
		Space space = new Space();
		space.setTitle("Test Space");
		space.setManagerPhones(Set.of());
		space.setInviterPhones(Set.of());
		space.setGuardPhones(Set.of());
		return space;
	}

	private Invite getTestInvite(Space space) {
		Invite invite = new Invite();
		invite.setSpace(space);
		invite.setInviterPhone("+27823335555");
		invite.setExpiryDate(LocalDateTime.now().plus(Duration.ofHours(48)));
		invite.setCode("000000");
		return invite;
	}

	private SpaceEntry getTestEntry(Space space) {
		SpaceEntry entry = new SpaceEntry();
		entry.setSpace(space);
		entry.setEntryDate(LocalDateTime.now());
		entry.setIdDocument(getTestDrivers());
		entry.setGuardPhone("+27817778888");
		return entry;
	}

	//endregion
}
