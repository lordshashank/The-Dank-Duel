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
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/lordshashank/The-Dank-Duel">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">The Dank Duel</h3>

  <p align="center">
    A dank game of Duel - made in Web3Xcelerate Hackathon
    <br />
    <a href="https://github.com/lordshashank/The-Dank-Duel"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/lordshashank/The-Dank-Duel">View Demo</a>
    ·
    <a href="https://github.com/lordshashank/The-Dank-Duel/issues">Report Bug</a>
    ·
    <a href="https://github.com/lordshashank/The-Dank-Duel/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#Logic">Logic</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

This is a game of Duel. You can play it with your friends. It is a game of luck and strategy. Moreover, built in blockchain, you play it through the medium of NFTs and cryptocurrency. To play game you have to mint random NFT cards. These cards have different properties and you can use them to attack your opponent. The game is built on the Martian platform. You can play it on the Martian wallet. The game is built using Move and React. Enjoy!!!!!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

- [![React][react.js]][react-url]
- [![Rust][rust-lang.org]][rust-url]
- [Aptos](https://aptoslabs.com/)
- [Martian](https://martianwallet.xyz/)
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

You can try our dapp by installing martian wallet from [here](https://chrome.google.com/webstore/detail/martian-wallet-for-sui-ap/efbglgofoippbgcjepnhiblaibcnclgk)
and then visiting the aptos explorer [here](https://explorer.aptoslabs.com/account/0xa7a691856c0f756c1844e2fe033ec425e49511f972887e0e8b2b5f136db5b29d/modules/run/game?network=testnet).
This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

Install the aptos CLI from [here](https://aptos.dev/tools/aptos-cli/install-cli/).

### Installation

1. Open any new folder on your system
   ```sh
   mkdir mygame
   ```
2. Clone the repo
   ```sh
   git clone https://github.com/lordshashank/The-Dank-Duel.git
   ```
3. Install NPM packages in frontend folder
   ```sh
   cd frontend
   npm install
   ```
4. start the frontend
   ```sh
   npm start
   ```
5. Now you can interact with game through frontend

To run backend follow these steps

1. Install NPM packages in backend folder
   ```sh
   cd backend
   npm install
   ```
2. initalize the aptos project. you can follow instructions here(https://aptos.dev/tools/aptos-cli/use-cli/use-aptos-cli/#command-line-help)

   ```sh
    aptos init
   ```

   put the new contract address in move.toml file as shown

   ```sh
   [addresses]
   # Testnet Address
   duel = {your-address}
   ```

3. compile the contracts
   ```sh
   aptos move compile
   ```
4. deploy the contracts
   ```sh
   aptos move publish
   ```
5. Now you can interact with newly deplyed contract in aptos explorer by searching for deployed contract address.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Logic

The logic of our game can be seen [here](https://github.com/lordshashank/The-Dank-Duel/blob/master/backend/sources/duel.move#L68C10-L68C10)

Basically, when a person mints NFT, a random power and multiplier get assigned to him. Now, he can go on to play the duel with someone else having the NFT. Winner is decided by random number being generated below sum of the power of both and winner is decided through the probability of total power which is calculated by multiplying the power and multiplier of the NFT.
If the player with less probability wins, his multiplier also get increased by one. Winner gets sum of power of both players while loser gets the lower power. Thus the game is a game of luck and strategy. One can tweak the logic and keep playing the game.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

<!-- CONTACT -->

## Contact

Your Name - [@0xlord_forever](https://twitter.com/0xlord_forever) - shashanktrivedi1917@gmail.com

Project Link: [https://github.com/lordshashank/The-Dank-Duel](https://github.com/lordshashank/The-Dank-Duel)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/lordshashank/The-Dank-Duel.svg?style=for-the-badge
[contributors-url]: https://github.com/lordshashank/The-Dank-Duel/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lordshashank/The-Dank-Duel.svg?style=for-the-badge
[forks-url]: https://github.com/lordshashank/The-Dank-Duel/network/members
[stars-shield]: https://img.shields.io/github/stars/lordshashank/The-Dank-Duel.svg?style=for-the-badge
[stars-url]: https://github.com/lordshashank/The-Dank-Duel/stargazers
[issues-shield]: https://img.shields.io/github/issues/lordshashank/The-Dank-Duel.svg?style=for-the-badge
[issues-url]: https://github.com/lordshashank/The-Dank-Duel/issues
[license-shield]: https://img.shields.io/github/license/lordshashank/The-Dank-Duel.svg?style=for-the-badge
[license-url]: https://github.com/lordshashank/The-Dank-Duel/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[next-url]: https://nextjs.org/
[react.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[react-url]: https://reactjs.org/
[vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[vue-url]: https://vuejs.org/
[angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[angular-url]: https://angular.io/
[svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[svelte-url]: https://svelte.dev/
[laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[laravel-url]: https://laravel.com
[bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[bootstrap-url]: https://getbootstrap.com
[jquery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[jquery-url]: https://jquery.com
[rust-lang.org]: https://img.shields.io/badge/Rust-000000?style=for-the-badge&logo=rust&logoColor=white
[rust-url]: https://www.rust-lang.org/
