package com.inviteonly.web;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;

/**
 * Integration test for local or remote service based on the env var
 * "SERVICE_URL". See java/CONTRIBUTING.MD for more information. 
 */
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class UserControllerIT {

  @Test
  public void respondsToHttpRequest() throws IOException {
//    String port = System.getenv("PORT");
//    if (port == null || port == "") {
//      port = "8080";
//    }
//
//    String url = System.getenv("SERVICE_URL");
//    if (url == null || url == "") {
//      url = "http://localhost:" + port;
//    }
//
//    OkHttpClient ok =
//        new OkHttpClient.Builder()
//            .connectTimeout(20, TimeUnit.SECONDS)
//            .readTimeout(20, TimeUnit.SECONDS)
//            .writeTimeout(20, TimeUnit.SECONDS)
//            .build();
//
//    Request request = new Request.Builder().url(url + "/").get().build();
//
//    String expected = "Congratulations, you successfully deployed a container image to Cloud Run";
//    Response response = ok.newCall(request).execute();
//    assertThat(response.body().string(), containsString(expected));
//    assertThat(response.code(), equalTo(200));
  }
}
