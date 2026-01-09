<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | Premium Car Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes driveIn {
            from { transform: translateX(-150px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .animate-float {
            animation: float 6s ease-in-out infinite;
        }

        .animate-pulse-slow {
            animation: pulse 4s ease-in-out infinite;
        }

        .car-bg {
            background-image: url('https://images.unsplash.com/photo-1493238792000-8113da705763?ixlib=rb-4.0.3');
            background-size: cover;
            background-position: center;
        }

        .glassmorphism {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        @keyframes dash {
            to {
                stroke-dashoffset: 0;
            }
        }

        .path-animation {
            stroke-dasharray: 1000;
            stroke-dashoffset: 1000;
            animation: dash 3s linear forwards;
            animation-delay: 0.5s;
        }

        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(45deg, #3b82f6, #4f46e5);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(45deg, #2563eb, #4338ca);
        }

        .particle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            pointer-events: none;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-900 via-blue-900 to-indigo-900 min-h-screen flex items-center justify-center p-4 overflow-hidden">
<!-- Animated background particles -->
<div id="particles" class="absolute inset-0 overflow-hidden"></div>

<!-- Path for animated car -->
<svg class="hidden md:block absolute top-0 left-0 w-full h-full pointer-events-none overflow-visible" preserveAspectRatio="none">
    <path id="carPath" d="M-100,400 C100,350 300,450 500,380 C700,320 900,450 1100,380 C1300,320 1500,420 1700,370"
          fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="4" class="path-animation"></path>
</svg>

<!-- Animated car following the path -->
<div id="movingCar" class="absolute text-yellow-400 text-2xl hidden md:block" style="filter: drop-shadow(0 0 8px rgba(234, 179, 8, 0.5));">
    <i class="fas fa-car-side"></i>
</div>

<div class="container max-w-5xl mx-auto relative z-10 h-200">
    <div class="flex flex-col md:flex-row rounded-3xl shadow-2xl glassmorphism">
        <!-- Left Side - Placeholder for Car Image & Features -->
        <!-- Assuming this section exists but is not provided -->

        <!-- Right Side - Registration Form -->
        <div class="w-full bg-blue-900 p-8 rounded-3xl flex flex-col items-center justify-center">
            <div class="mb-8 text-center">
                <div class="flex items-center justify-center">
                    <div class="relative">
                        <i class="fas fa-user-plus text-4xl text-blue-700 mr-3"></i>
                    </div>
                    <h2 class="text-3xl font-bold bg-gradient-to-r from-blue-700 to-indigo-600 text-transparent bg-clip-text">
                        Créer un compte
                    </h2>
                </div>
                <p class="text-gray-600 mt-2">
                    Rejoignez Premium Car Rental
                </p>
            </div>

            <form action="RegistrationServlet" method="post" class="md:grid md:grid-cols-2 md:gap-6" id="registerForm">
                <!-- Section 1: Informations personnelles -->
                <div class="space-y-6">
                    <h3 class="text-xl font-semibold text-gray-700">Informations personnelles</h3>
                    <!-- Nom -->
                    <div class="form-field" id="nomField">
                        <label class="block text-black-700 font-medium mb-2" for="nom">
                            <i class="fas fa-id-badge text-blue-600 mr-2"></i>Nom
                        </label>
                        <input type="text" id="nom" name="nom" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- Prénom -->
                    <div class="form-field" id="prenomField">
                        <label class="block text-black-700 font-medium mb-2" for="prenom">
                            <i class="fas fa-id-card text-blue-600 mr-2"></i>Prénom
                        </label>
                        <input type="text" id="prenom" name="prenom" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- Email -->
                    <div class="form-field" id="emailField">
                        <label class="block text-black-700 font-medium mb-2" for="email">
                            <i class="fas fa-envelope text-blue-600 mr-2"></i>Email
                        </label>
                        <input type="email" id="email" name="email" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- Téléphone -->
                    <div class="form-field" id="telField">
                        <label class="block text-black-700 font-medium mb-2" for="numTel">
                            <i class="fas fa-phone text-blue-600 mr-2"></i>Téléphone
                        </label>
                        <input type="tel" id="numTel" name="numTel" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- NCIN -->
                    <div class="form-field" id="ncinField">
                        <label class="block text-black-700 font-medium mb-2" for="ncin">
                            <i class="fas fa-id-card-alt text-blue-600 mr-2"></i>NCIN
                        </label>
                        <input type="text" id="ncin" name="ncin" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                </div>
                <!-- Section 2: Informations de compte -->
                <div class="space-y-6">
                    <h3 class="text-xl font-semibold text-gray-700">Informations de compte</h3>
                    <!-- Username -->
                    <div class="form-field" id="usernameField">
                        <label class="block text-black-700 font-medium mb-2" for="username">
                            <i class="fas fa-user text-blue-600 mr-2"></i>Login souhaité
                        </label>
                        <input type="text" id="username" name="username" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- Password -->
                    <div class="form-field relative" id="passwordField">
                        <label class="block text-black-700 font-medium mb-2" for="password">
                            <i class="fas fa-lock text-blue-600 mr-2"></i>Mot de passe
                        </label>
                        <input type="password" id="password" name="password" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                    <!-- Confirm Password -->
                    <div class="form-field relative" id="confirmField">
                        <label class="block text-black-700 font-medium mb-2" for="confirmPassword">
                            <i class="fas fa-lock text-blue-600 mr-2"></i>Confirmer mot de passe
                        </label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required
                               class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all">
                    </div>
                </div>
                <!-- Submit -->
                <div id="submitField" class="md:col-span-2 mt-6">
                    <button type="submit"
                            class="w-full bg-gradient-to-r from-blue-600 to-indigo-700 text-white font-medium py-4 px-6 rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 flex items-center justify-center">
                        <i class="fas fa-user-plus mr-2 animate-pulse"></i>
                        <span>S’inscrire</span>
                    </button>
                </div>
                <!-- Back to login -->
                <div id="loginField" class="md:col-span-2 mt-4 text-center">
                    <p class="text-sm text-gray-600">
                        Vous avez déjà un compte ?
                        <a href="index.jsp" class="text-blue-600 hover:underline">Se connecter</a>
                    </p>
                </div>
            </form>
        </div>
    </div>

    <!-- Floating cars at the bottom -->
    <div class="mt-10 text-center relative">
        <div class="flex justify-center space-x-12">
            <div class="text-white text-xs" id="car1">
                <i class="fas fa-car-side text-2xl"></i>
                <div class="mt-2"><span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">Sedan Premium</span></div>
            </div>
            <div class="text-white text-xs" id="car2">
                <i class="fas fa-truck-monster text-2xl"></i>
                <div class="mt-2"><span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">SUV de Luxe</span></div>
            </div>
            <div class="text-white text-xs" id="car3">
                <i class="fas fa-car-side text-2xl"></i>
                <div class="mt-2"><span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">Sportive</span></div>
            </div>
        </div>
        <div class="mt-6 text-white text-xs" id="copyright">
            <span class="bg-white/10 backdrop-blur-md px-4 py-2 rounded-full inline-block">
                © 2025 Premium Car Rental | Tous droits réservés
            </span>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('ring', 'ring-blue-300');
            gsap.to(this.parentElement, {scale: 1.02, duration: 0.3, ease: "power2.out"});
        });

        input.addEventListener('blur', function() {
            this.parentElement.classList.remove('ring', 'ring-blue-300');
            gsap.to(this.parentElement, {scale: 1, duration: 0.3, ease: "power2.out"});
        });
    });

    // Engine effect animation
    function animateEngine() {
        gsap.to('#engineEffect', {
            opacity: 1,
            duration: 0.1,
            yoyo: true,
            repeat: 3,
            onComplete: () => {
                setTimeout(animateEngine, Math.random() * 3000 + 1000);
            }
        });
    }

    // Create particles for background
    function createParticles() {
        const particlesContainer = document.getElementById('particles');
        const numberOfParticles = window.innerWidth > 768 ? 30 : 15;

        for (let i = 0; i < numberOfParticles; i++) {
            const size = Math.random() * 6 + 2;
            const particle = document.createElement('div');
            particle.classList.add('particle');
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;
            particle.style.opacity = Math.random() * 0.5 + 0.1;

            particlesContainer.appendChild(particle);

            const posX = Math.random() * window.innerWidth;
            const posY = Math.random() * window.innerHeight;

            gsap.set(particle, { x: posX, y: posY });

            animateParticle(particle);
        }
    }

    function animateParticle(particle) {
        const duration = Math.random() * 60 + 30;
        const xMovement = Math.random() * 100 - 50;
        const yMovement = Math.random() * 100 - 50;

        gsap.to(particle, {
            x: `+=${xMovement}`,
            y: `+=${yMovement}`,
            duration: duration,
            ease: "none",
            repeat: -1,
            yoyo: true
        });
    }

    // Moving car along the path
    function animateCarAlongPath() {
        const carPath = document.getElementById('carPath');
        const movingCar = document.getElementById('movingCar');

        gsap.to(movingCar, {
            duration: 15,
            repeat: -1,
            ease: "power1.inOut",
            motionPath: {
                path: carPath,
                align: carPath,
                autoRotate: true
            }
        });
    }

    // Initialize animations
    document.addEventListener('DOMContentLoaded', () => {
        // Form fields fade in sequence (adjusted to match IDs)
        gsap.fromTo('#nomField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 0.2});
        gsap.fromTo('#prenomField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 0.4});
        gsap.fromTo('#emailField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 0.6});
        gsap.fromTo('#telField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 0.8});
        gsap.fromTo('#ncinField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 1.0});
        gsap.fromTo('#usernameField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 1.2});
        gsap.fromTo('#passwordField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 1.4});
        gsap.fromTo('#confirmField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 1.6});
        gsap.fromTo('#submitField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 1.8});
        gsap.fromTo('#loginField', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 2.0});

        // Car icons and copyright
        gsap.fromTo('#car1', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 2.2});
        gsap.fromTo('#car2', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 2.4});
        gsap.fromTo('#car3', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 2.6});
        gsap.fromTo('#copyright', {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.6, delay: 2.8});

        // Start engine effect
        setTimeout(animateEngine, 1000);

        // Create particles
        createParticles();

        // Animate car along path for desktop
        if (window.innerWidth > 768) {
            animateCarAlongPath();
        }

        // Button hover effect
        const submitBtn = document.querySelector('button[type="submit"]');
        submitBtn.addEventListener('mouseenter', () => {
            gsap.to(submitBtn, {scale: 1.03, duration: 0.3});
        });
        submitBtn.addEventListener('mouseleave', () => {
            gsap.to(submitBtn, {scale: 1, duration: 0.3});
        });
    });
</script>
</body>
</html>