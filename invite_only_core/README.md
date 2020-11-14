<!-- PROJECT LOGO -->
<p align="right">
<a href="https://www.up.ac.za">
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_700_project/master/invite_only_core/assets/project_badge.png" height="100" alt="badge">
</a>
</p>
<p align="center">
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_700_project/master/invite_only_core/assets/project_logo.png" height="100" alt="logo" />
</p>

<!-- PROJECT SHIELDS -->
<p align="center">
<a href="https://github.com/marcus-bornman/cos_700_project/actions?query=workflow%3Abuild-io-core"><img src="https://img.shields.io/github/workflow/status/marcus-bornman/cos_700_project/build-io-core?label=build" alt="build"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/issues"><img src="https://img.shields.io/github/issues/marcus-bornman/cos_700_project" alt="issues"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/network"><img src="https://img.shields.io/github/forks/marcus-bornman/cos_700_project" alt="forks"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/stargazers"><img src="https://img.shields.io/github/stars/marcus-bornman/cos_700_project" alt="stars"></a>
<a href="https://google.github.io/styleguide/javaguide.html"><img src="https://img.shields.io/badge/style-google_java-40c4ff.svg" alt="style"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/blob/master/LICENSE"><img src="https://img.shields.io/github/license/marcus-bornman/cos_700_project" alt="license"></a>
</p>

---

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project
<p align="center">
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_700_project/master/invite_only_core/assets/screenshot_1.png" width="800" alt="Screenshot 1" />
</p>

The Invite Only Core API provides the means for client systems to access the core functionalities of the Invite Only project.
The API requires incoming requests to provide a Bearer Authentication Token retrieved by authenticating with [Firebase Authentication](https://firebase.google.com/docs/auth).

### Built With
* [Spring](https://spring.io)
* [Apache Maven](https://maven.apache.org)



<!-- GETTING STARTED -->
## Getting Started
If this is your first Spring Application, you may want to see [A Guide on Building an Application with Spring Boot](https://spring.io/guides/gs/spring-boot/).
To build this project you will need to have Java 13 and [Apache Maven](https://maven.apache.org) installed.
You can ensure that the project compiles by running the following command from this folder:
```shell script
mvn clean install
```

Next - because this services makes use of [Firebase Authentication](https://firebase.google.com/docs/auth) through
the [Firebase Admin SDK](https://firebase.google.com/docs/reference/admin) - you will need to:
1. [Set up a Firebase project and service account](https://firebase.google.com/docs/admin/setup#set-up-project-and-service-account)
2. [Enable Phone Number sign-in for your Firebase project](https://firebase.google.com/docs/auth/web/phone-auth#enable-phone-number-sign-in-for-your-firebase-project)
3. [Generate a private key file for your service account](https://firebase.google.com/docs/admin/setup#initialize-sdk)

Finally, the application will require access to a MySQL Database Instance. This can be an instance on your local machine
or hosted on GCP. See the following to help you Get Started with a MySQL database:
* [Getting Started with MySQL](https://dev.mysql.com/doc/mysql-getting-started/en/)
* [Quickstart for Cloud SQL for MySQL](https://cloud.google.com/sql/docs/mysql/quickstart)

After you have completed all the steps above, you are ready to [run the application](#Usage).



<!-- USAGE EXAMPLES -->
## Usage
Importantly, the application requires a few environment variables to be set when running it. Run the application as follows:
```
mvn spring-boot:run 
-DGCP_PROJECT_ID={The Project ID for your Firebase/GCP project}
-DGOOGLE_APPLICATION_CREDENTIALS={The path to your private key file for your GCP/Firebase service account}
-DDB_URL={The URL to your database instance}
-DDB_USERNAME={The username for your database user}
-DDB_PASSWORD={The password for your database user}
-DGCP_DB_INSTANCE={The ID of your Cloud MySQL instance - if you're using a local instance you don't need to set this}
-DGCP_DB_NAME={The database name of the DB - if you're using a local instance you don't need to set this}
```

The application should now be up and running. Assuming your application is running on Port 8080, you can access the API
documentation at http://localhost:8080/documentation.html. Note that all the endpoints require clients to provide a
Bearer token retrieved by authenticating with [Firebase Authentication](https://firebase.google.com/docs/auth).


<!-- ROADMAP -->
## Roadmap
See the [open issues](https://github.com/marcus-bornman/cos_700_project/issues) for a list of other proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See [LICENSE](../LICENSE) for more information.



<!-- CONTACT -->
## Contact

Marcus Bornman - [marcusbornman.com](https://www.marcusbornman.com) - [marcus.bornman@gmail.com](mailto:marcus.bornman@gmail.com)

Project Link: [https://github.com/marcus-bornman/cos_700_project](https://github.com/marcus-bornman/cos_700_project)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [GitHub Actions](https://github.com/features/actions)
* [Shields IO](https://shields.io)
* [Open Source Licenses](https://choosealicense.com)