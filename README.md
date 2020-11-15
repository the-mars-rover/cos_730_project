<!-- PROJECT LOGO -->
<p align="right">
<a href="https://pub.dev">
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_730_project/master/assets/project_badge.png" height="100" alt="Flutter">
</a>
</p>
<p align="center">
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_730_project/master/assets/project_logo.png" height="200" alt="Masterpass Example" />
</p>

<!-- PROJECT SHIELDS -->
<p align="center">
<a href="https://github.com/marcus-bornman/cos_730_project/issues"><img src="https://img.shields.io/github/issues/marcus-bornman/cos_730_project" alt="issues"></a>
<a href="https://github.com/marcus-bornman/cos_730_project/network"><img src="https://img.shields.io/github/forks/marcus-bornman/cos_730_project" alt="forks"></a>
<a href="https://github.com/marcus-bornman/cos_730_project/stargazers"><img src="https://img.shields.io/github/stars/marcus-bornman/cos_730_project" alt="stars"></a>
<a href="https://github.com/marcus-bornman/cos_730_project/blob/master/LICENSE"><img src="https://img.shields.io/github/license/marcus-bornman/cos_730_project" alt="license"></a>
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
<img src="https://raw.githubusercontent.com/marcus-bornman/cos_730_project/master/assets/screenshot_1.png" width="800" alt="Screenshot 1" />
</p>

This project was completed as part of the COS730 (Software Engineering) module at the University of Pretoria. The project
entails the implementation of the Invite Only Platform which is an access-control system allowing 
users to define access measures for a space and scan identification documents of persons wishing to enter the space 
to determine if they should be allowed entry.

Central to the system is the [Invite Only Core API](invite_only_core) which - protected by Firebase Authentication - 
exposes an API to interact with the main Invite Only functionalities through reading and writing to a persistent MySQL database. 

To make the API easy to use for any multi-platform application, the [Invite Only Repo Package](invite_only_repo) provides
the means for any Flutter application to interact with the API through easy-to-use classes and functions.

Finally, the [Invite Only Mobile App](invite_only_app) is implemented as a Flutter application and makes use of the 
Invite Only Repo to provide an Android and iOS client-side application to expose the functionalities of the platform to users.

### Built With
* [Spring](https://spring.io)
* [Apache Maven](https://maven.apache.org)
* [Flutter](https://flutter.dev/)
* [Firebase](https://firebase.google.com)
* [MySQL](https://www.mysql.com)



<!-- GETTING STARTED -->
## Getting Started
This repository serves as a mono-repo for each of the Invite Only components. To get started with individual components see
the sub-folders in this repo:
* [The Invite Only Core API](invite_only_core/README.md)
* [The Invite Only Dart Repo](invite_only_repo/README.md)
* [The Invite Only App](invite_only_app/README.md)


<!-- USAGE EXAMPLES -->
## Usage
Again, depending on the component of the Invite Only platform you would like to make use of, the usage examples for each
component will differ.



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/marcus-bornman/cos_730_project/issues) for a list of proposed features (and known issues).



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

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.



<!-- CONTACT -->
## Contact

Marcus Bornman - [marcusbornman.com](https://www.marcusbornman.com) - [marcus.bornman@gmail.com](mailto:marcus.bornman@gmail.com)

Project Link: [https://github.com/marcus-bornman/cos_730_project](https://github.com/marcus-bornman/cos_730_project)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Shields IO](https://shields.io)
* [Open Source Licenses](https://choosealicense.com)
