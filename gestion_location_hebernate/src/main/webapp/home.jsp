<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--=============== FAVICON ===============-->
    <link rel="shortcut icon" href="assets/img/favicon.png" type="image/x-icon">

    <!--=============== REMIX ICONS ===============-->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

    <!--=============== SWIPER CSS ===============-->
    <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">

    <!--=============== CSS ===============-->
    <link rel="stylesheet" href="assets/css/styles.css">

    <title>Responsive car website - Bedimcode</title>
</head>

<body>
    <!-- https://youtu.be/bDngcOQ8Img   2:16  -->
    <!--==================== HEADER ====================-->
    <header class="header" id="header">
    <hr>
        <nav class="nav container">
            <a href="#" class="nav__logo">
                <i class="ri-steering-line"></i>
                ELGarage
            </a>

            <div class="nav__menu" id="nav-menu">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="#home" class="nav__link active-link">Accueil</a>
                    </li>
                    <li class="nav__item">
                        <a href="#about" class="nav__link">À propos</a>
                    </li>
                    <li class="nav__item">
                        <a href="#popular" class="nav__link">Populaire</a>
                    </li>
                    <li class="nav__item">
                        <a href="#featured" class="nav__link">En vedette</a>
                    </li>

                    <li class="nav__item">
                        <a href="index.jsp" class="nav__link">Connexion</a>
                    </li>
                </ul>

                <div class="nav__close" id="nav-close">
                    <i class="ri-close-line"></i>
                </div>
            </div>

            <!-- Toggle button -->
            <div class="nav__toggle" id="nav-toggle">
                <i class="ri-menu-line"></i>
            </div>
        </nav>
        <hr>
    </header>

    <!--==================== MAIN ====================-->
    <main class="main">
        <!--==================== HOME ====================-->
        <section class="home section" id="home">
            <div class="shape shape__big"></div>
            <div class="shape shape__small"></div>

            <!-- Adding video background -->
            <div class="home__video-container" style="position: absolute; top: 0; left: 0; z-index: -1;">
                <img class="home__video"
                    src="https://media-hosting.imagekit.io/c918eea74fcf4e01/Untitled%20video%20-%20Made%20with%20Clipchamp%20(16).gif?Expires=1841221694&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=X5iLtKa~DFJ5DA1upNh-wPparRKPZf5QxM67STdPvtRzjj9f~c9SgV6BhRI174y-uPx54W4AyGUBqP7m0F1U8lgcqDKLA6GYFk12HnrBeGga3~8SJB1FA0oqb5hP5Zkk-2pbIoNCoP6u44LBZQqITWuOURSa9mumCfE41Am5P6za5V-HHz0118MEvfn673zAk1bcqlRoNtfxcnHfeZzMRDUe5QKp6wLkzjR9RTYgxFBEo6D7FjzhI8gfZdEBD0ieWgjAAAd17byr~a2BQpGNublFjoMpx5e7Vh6e6kNd4CmRBZ2DhSgroE-62lD1CsrmQAmXVgIGTTUokXwFcT~3KQ__"
                    alt="Car Animation" style="width: 100vw; height: 70vh; object-fit: cover;">
            </div>

            <div class="home__container container grid">
                <div class="home__data">
                    <h1 class="home__title">
                        Choisissez la meilleure voiture
                    </h1>

                    <h2 class="home__subtitle">
                        Porsche Mission E
                    </h2>

                    <h3 class="home__elec">
                        <i class="ri-flashlight-fill"></i> Voiture électrique
                    </h3>
                </div>

                <img src="assets/img/home.png" alt="" class="home__img">

                <div class="home__car">
                    <div class="home__car-data">
                        <div class="home__car-icon">
                            <i class="ri-temp-cold-line"></i>
                        </div>
                        <h2 class="home__car-number">24°</h2>
                        <h3 class="home__car-name">TEMPÉRATURE</h3>
                    </div>

                    <div class="home__car-data">
                        <div class="home__car-icon">
                            <i class="ri-dashboard-3-line"></i>
                        </div>
                        <h2 class="home__car-number">873</h2>
                        <h3 class="home__car-name">KILOMÉTRAGE</h3>
                    </div>

                    <div class="home__car-data">
                        <div class="home__car-icon">
                            <i class="ri-flashlight-fill"></i>
                        </div>
                        <h2 class="home__car-number">94%</h2>
                        <h3 class="home__car-name">BATTERIE</h3>
                    </div>
                </div>

                <a href="#contact" class="home__button">LOUER</a>
            </div>
        </section>

        <!--==================== ABOUT ====================-->
        <section class="about section" id="about">
            <div class="about__container container grid">
                <div class="about__group">
                    <img src="assets/img/about.png" alt="" class="about__img">

                    <div class="about__card">
                        <h3 class="about__card-title">2.500+</h3>
                        <p class="about__card-description">
                            Supercharges placées le long des routes populaires
                        </p>
                    </div>
                </div>

                <div class="about__data">
                    <h2 class="section__title about__title">
                        Machines avec <br> technologie du futur
                    </h2>

                    <p class="about__description">
                        Découvrez l'avenir avec des voitures électriques haute performance produites par
                        des marques renommées. Elles présentent des constructions et des designs futuristes avec
                        de nouvelles plateformes innovantes qui durent longtemps.
                    </p>

                    <a href="#" class="button">En savoir plus</a>
                </div>
            </div>
        </section>

        <!--==================== POPULAR ====================-->
        <section class="popular section" id="popular">
            <h2 class="section__title">
                Choisissez votre voiture électrique <br> de la marque Porsche
            </h2>

            <div class="popular__container container swiper">
                <div class="swiper-wrapper">
                    <article class="popular__card swiper-slide">
                        <div class="shape shape__smaller"></div>

                        <h1 class="popular__title">Porsche</h1>
                        <h3 class="popular__subtitle">Turbo S</h3>

                        <img src="assets/img/popular1.png" alt="" class="popular__img">

                        <div class="popular__data">
                            <div class="popular__data-group">
                                <i class="ri-dashboard-3-line"></i> 3.7 Sec
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-funds-box-line"></i> 356 Km/h
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-charging-pile-2-line"></i> Électrique
                            </div>
                        </div>

                        <h3 class="popular__price">DT175,900</h3>

                        <button class="button popular__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="popular__card swiper-slide">
                        <div class="shape shape__smaller"></div>

                        <h1 class="popular__title">Porsche</h1>
                        <h3 class="popular__subtitle">Taycan</h3>

                        <img src="assets/img/popular2.png" alt="" class="popular__img">

                        <div class="popular__data">
                            <div class="popular__data-group">
                                <i class="ri-dashboard-3-line"></i> 3.7 Sec
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-funds-box-line"></i> 356 Km/h
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-charging-pile-2-line"></i> Électrique
                            </div>
                        </div>

                        <h3 class="popular__price">DT114,900</h3>

                        <button class="button popular__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="popular__card swiper-slide">
                        <div class="shape shape__smaller"></div>

                        <h1 class="popular__title">Porsche</h1>
                        <h3 class="popular__subtitle">Turbo S Cross</h3>

                        <img src="assets/img/popular3.png" alt="" class="popular__img">

                        <div class="popular__data">
                            <div class="popular__data-group">
                                <i class="ri-dashboard-3-line"></i> 3.7 Sec
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-funds-box-line"></i> 356 Km/h
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-charging-pile-2-line"></i> Électrique
                            </div>
                        </div>

                        <h3 class="popular__price">DT150,900</h3>

                        <button class="button popular__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="popular__card swiper-slide">
                        <div class="shape shape__smaller"></div>

                        <h1 class="popular__title">Porsche</h1>
                        <h3 class="popular__subtitle">Boxster 718</h3>

                        <img src="assets/img/popular4.png" alt="" class="popular__img">

                        <div class="popular__data">
                            <div class="popular__data-group">
                                <i class="ri-dashboard-3-line"></i> 3.7 Sec
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-funds-box-line"></i> 356 Km/h
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-charging-pile-2-line"></i> Électrique
                            </div>
                        </div>

                        <h3 class="popular__price">DT125,900</h3>

                        <button class="button popular__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="popular__card swiper-slide">
                        <div class="shape shape__smaller"></div>

                        <h1 class="popular__title">Porsche</h1>
                        <h3 class="popular__subtitle">Cayman</h3>

                        <img src="assets/img/popular5.png" alt="" class="popular__img">

                        <div class="popular__data">
                            <div class="popular__data-group">
                                <i class="ri-dashboard-3-line"></i> 3.7 Sec
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-funds-box-line"></i> 356 Km/h
                            </div>
                            <div class="popular__data-group">
                                <i class="ri-charging-pile-2-line"></i> Électrique
                            </div>
                        </div>

                        <h3 class="popular__price">DT128,900</h3>

                        <button class="button popular__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>
                </div>

                <div class="swiper-pagination"></div>
            </div>
        </section>

        <!--==================== FEATURES ====================-->
        <section class="features section">
            <h2 class="section__title">
                Plus de fonctionnalités
            </h2>

            <div class="features__container container grid">
                <div class="features__group">
                    <img src="assets/img/features.png" alt="" class="features__img">

                    <div class="features__card features__card-1">
                        <h3 class="features__card-title">800v</h3>
                        <p class="features__card-description">Turbo <br> Chargin</p>
                        </p>
                    </div>

                    <div class="features__card features__card-2">
                        <h3 class="features__card-title">350</h3>
                        <p class="features__card-description">Km <br> Autonomie</p>
                    </div>

                    <div class="features__card features__card-3">
                        <h3 class="features__card-title">480</h3>
                        <p class="features__card-description">Km <br> Voyage</p>
                    </div>
                </div>
            </div>

            <img src="assets/img/map.svg" alt="" class="features__map">
        </section>

        <!--==================== FEATURED ====================-->
        <section class="featured section" id="featured">
            <h2 class="section__title">
                Voitures de luxe en vedette
            </h2>

            <div class="featured__container container">
                <ul class="featured__filters">
                    <li>
                        <button class="featured__item active-featured" data-filter="all">
                            <span>Tout</span>
                        </button>
                    </li>
                    <li>
                        <button class="featured__item" data-filter=".tesla">
                            <img src="assets/img/logo3.png" alt="">
                        </button>
                    </li>
                    <li>
                        <button class="featured__item" data-filter=".audi">
                            <img src="assets/img/logo2.png" alt="">
                        </button>
                    </li>
                    <li>
                        <button class="featured__item" data-filter=".porsche">
                            <img src="assets/img/logo1.png" alt="">
                        </button>
                    </li>
                </ul>

                <div class="featured__content grid">
                    <article class="featured__card mix tesla">
                        <div class="shape shape__smaller"></div>

                        <h1 class="featured__title">Tesla</h1>

                        <h3 class="featured__subtitle">Model X</h3>

                        <img src="assets/img/featured1.png" alt="" class="featured__img">

                        <h3 class="featured__price">DT98,900</h3>

                        <button class="button featured__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="featured__card mix tesla">
                        <div class="shape shape__smaller"></div>

                        <h1 class="featured__title">Tesla</h1>

                        <h3 class="featured__subtitle">Model 3</h3>

                        <img src="assets/img/featured2.png" alt="" class="featured__img">

                        <h3 class="featured__price">DT45,900</h3>

                        <button class="button featured__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="featured__card mix audi">
                        <div class="shape shape__smaller"></div>

                        <h1 class="featured__title">Audi</h1>

                        <h3 class="featured__subtitle">E-tron</h3>

                        <img src="assets/img/featured3.png" alt="" class="featured__img">

                        <h3 class="featured__price">DT175,900</h3>

                        <button class="button featured__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="featured__card mix porsche">
                        <div class="shape shape__smaller"></div>

                        <h1 class="featured__title">Porsche</h1>

                        <h3 class="featured__subtitle">Boxster 987</h3>

                        <img src="assets/img/featured4.png" alt="" class="featured__img">

                        <h3 class="featured__price">DT126,900</h3>

                        <button class="button featured__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>

                    <article class="featured__card mix porsche">
                        <div class="shape shape__smaller"></div>

                        <h1 class="featured__title">Porsche</h1>

                        <h3 class="featured__subtitle">Panamera</h3>

                        <img src="assets/img/featured5.png" alt="" class="featured__img">

                        <h3 class="featured__price">DT126,900</h3>

                        <button class="button featured__button">
                            <i class="ri-shopping-bag-2-line"></i>
                        </button>
                    </article>
                </div>
            </div>
        </section>

        <!--==================== OFFER ====================-->
        <section class="offer section">
            <div class="offer__container container grid">
                <img src="assets/img/offer-bg.png" alt="" class="offer__bg">

                <div class="offer__data">
                    <h2 class="section__title offer__title">
                        Voulez-vous recevoir <br> des offres spéciales?
                    </h2>

                    <p class="offer__description">
                        Soyez le premier à recevoir toutes les informations sur nos
                        produits et nouvelles voitures par e-mail en vous abonnant à notre
                        liste de diffusion.
                    </p>

                    <a href="#" class="button">
                        Abonnez-vous maintenant
                    </a>
                </div>

                <img src="assets/img/offer.png" alt="" class="offer__img">
            </div>
        </section>

        <!--==================== LOGOS ====================-->
        <section class="logos section">
            <div class="logos__container container grid">
                <div class="logos__content">
                    <img src="assets/img/logo1.png" alt="" class="logos__img">
                </div>

                <div class="logos__content">
                    <img src="assets/img/logo2.png" alt="" class="logos__img">
                </div>

                <div class="logos__content">
                    <img src="assets/img/logo3.png" alt="" class="logos__img">
                </div>

                <div class="logos__content">
                    <img src="assets/img/logo4.png" alt="" class="logos__img">
                </div>

                <div class="logos__content">
                    <img src="assets/img/logo5.png" alt="" class="logos__img">
                </div>

                <div class="logos__content">
                    <img src="assets/img/logo6.png" alt="" class="logos__img">
                </div>
            </div>
        </section>

        <!--==================== CONTACT ====================-->
        <section class="contact section" id="contact">
            <h2 class="section__title">Contactez-nous</h2>

            <div class="contact__container container">
                <p class="contact__description">
                    Si vous souhaitez louer une voiture, veuillez nous contacter à l'adresse suivante :
                    <a href="mailto:wajdibz60@gmail.com">wajdibz60@gmail.com</a>
                </p>
            </div>
        </section>
    </main>

    <!--==================== FOOTER ====================-->
    <footer class="footer section">
        <div class="shape shape__big"></div>
        <div class="shape shape__small"></div>

        <div class="footer__container container grid">
            <div class="footer__content">
                <a href="#" class="footer__logo">
                    <i class="ri-steering-line"></i> ELGarage
                </a>
                <p class="footer__description">
                    Nous offrons les meilleures voitures électriques des <br>
                    marques les plus reconnues dans <br>
                    le monde.
                </p>
            </div>

            <div class="footer__content">
                <h3 class="footer__title">
                    Entreprise
                </h3>

                <ul class="footer__links">
                    <li>
                        <a href="#" class="footer__link">À propos</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Voitures</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Histoire</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Boutique</a>
                    </li>
                </ul>
            </div>

            <div class="footer__content">
                <h3 class="footer__title">
                    Informations
                </h3>

                <ul class="footer__links">
                    <li>
                        <a href="#" class="footer__link">Demander un devis</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Trouver un concessionnaire</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Nous contacter</a>
                    </li>
                    <li>
                        <a href="#" class="footer__link">Services</a>
                    </li>
                </ul>
            </div>

            <div class="footer__content">
                <h3 class="footer__title">
                    Suivez-nous
                </h3>

                <ul class="footer__social">
                    <a href="https://www.facebook.com/" target="_blank" class="footer__social-link">
                        <i class="ri-facebook-fill"></i>
                    </a>
                    <a href="https://www.instagram.com/" target="_blank" class="footer__social-link">
                        <i class="ri-instagram-line"></i>
                    </a>
                    <a href="https://twitter.com/" target="_blank" class="footer__social-link">
                        <i class="ri-twitter-line"></i>
                    </a>
                </ul>
            </div>
        </div>

        <span class="footer__copy">
            &#169; Bedimcode. Tous droits réservés
        </span>
    </footer>


    <!--========== SCROLL UP ==========-->
    <a href="#" class="scrollup" id="scroll-up">
        <i class="ri-arrow-up-line"></i>
    </a>

    <!--=============== SCROLL REVEAL ===============-->
    <script src="assets/js/scrollreveal.min.js"></script>

    <!--=============== SWIPER JS ===============-->
    <script src="assets/js/swiper-bundle.min.js"></script>

    <!--=============== MIXITUP JS ===============-->
    <script src="assets/js/mixitup.min.js"></script>

    <!--=============== MAIN JS ===============-->
    <script src="assets/js/main.js"></script>
</body>

</html>