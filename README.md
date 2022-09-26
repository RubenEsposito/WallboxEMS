# WallboxEMS

<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<h3 align="center">WallboxEMS</h3>

  <p align="center">
    Wallbox energy management system app for easy data visualization.
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#tests">Tests</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#decisions-log">Decisions Log</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project is an exercise for the interview process at Wallbox. The aim of this code is to show my personal expertise on several aspects of iOS development, including:

- Architecture: I chose MVVM as the project architecture given it's suitable for small to medium sized projects and enables reactive programming seamlessly.
- SwiftUI/Combine are used in the app to allow the use of latest technologies from Apple (like Swift Charts) and reactive programming.
- It follows SOLID code principles, so for example in the networking layer protocols are used to uncouple the modules.
- Testing: The XCTest cases implemeneted cover a big part of the code, making it safer to maintain and refactor, increasing it's quality.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps:

### Prerequisites

- Xcode 14.0
- Swift 5.7

### Installation

The project is prepared so everything you need to do is clone the repository, open the xcodeproj and run it.

### Tests

You can run the unit tests with Cmd + U.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

On the dashboard screen you will see the information from the EMS. If you tap on the Statistics view, you will navigate to the detail view containing the charts.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- DECISIONS LOG -->
## Decisions Log

*By following the commits you can see the changes implied

- I started thinking about the architecture. As the project has a limited scope and I want to use some reactive code and tests, I chose MVVM as it allows SOLID principles with a limited code overload.
- First, I created the models and its unit tests.
- I also added the services, implementing protocols to keep the concrete implementations uncoupled and apply the dependency inversion principle.
- I added the tests for the services. At this point I had to leave some of the tests (related to the fetch functions) to a later moment due to time constraints.
- Then, with all the tests passing, I implemented the Views and ViewModels on top of the model and networking modules already created.
- At this point, I saw that it was possible to optimize the view models and reduce them to one. I started by extracting the ChartElement as a separate model object and the EnergySourceType to the common view model.
- Then I reduced the number of VMs to one. At that point, I saw that it was possible to improve this architecture by adding an extra layer. That would make it feel more like a MVVMC architecture (similar to VIPER but with MVVM naming), with an interactor dealing with networking code (fetch functions mainly). But again, due to the time constraints inherent to this kind of tests I couldn't complete the refactor.
- Finally, I saw that I could improve the test coverage (from 70%) and implemented some new tests for the view models, incrementing it to 75%.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the GNU General Public License v3.0. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Rubén Expósito Marín - ruben@lightonapps.com

Project Link: [https://github.com/RubenEsposito/WallboxEMS](https://github.com/RubenEsposito/WallboxEMS)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* You can check the exercise specs from this app [here](https://gitlab.com/carandahe/ems-demo-project).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/RubenEsposito/WallboxEMS.svg?style=for-the-badge
[contributors-url]: https://github.com/RubenEsposito/WallboxEMS/graphs/contributors
[license-shield]: https://img.shields.io/github/license/RubenEsposito/WallboxEMS.svg?style=for-the-badge
[license-url]: https://github.com/RubenEsposito/WallboxEMS/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/rubenexposito
