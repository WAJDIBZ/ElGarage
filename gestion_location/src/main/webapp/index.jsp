<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes driveIn {
                from {
                    transform: translateX(-150px);
                    opacity: 0;
                }

                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes float {
                0% {
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-10px);
                }

                100% {
                    transform: translateY(0px);
                }
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.05);
                }

                100% {
                    transform: scale(1);
                }
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

            /* Path for the car trail */
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

            /* Custom scrollbar */
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

            /* Particle background */
            .particle {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                pointer-events: none;
                transform: translate(-50%, -50%);
            }
        </style>
    </head>

    <body
        class="bg-gradient-to-br from-gray-900 via-blue-900 to-indigo-900 min-h-screen flex items-center justify-center p-4 overflow-hidden">
        <!-- Animated background particles -->
        <div id="particles" class="absolute inset-0 overflow-hidden"></div>

        <!-- Path for animated car -->
        <svg class="hidden md:block absolute top-0 left-0 w-full h-full pointer-events-none overflow-visible"
            preserveAspectRatio="none">
            <path id="carPath"
                d="M-100,400 C100,350 300,450 500,380 C700,320 900,450 1100,380 C1300,320 1500,420 1700,370" fill="none"
                stroke="rgba(255,255,255,0.1)" stroke-width="4" class="path-animation"></path>
        </svg>

        <!-- Animated car following the path -->
        <div id="movingCar" class="absolute text-yellow-400 text-2xl hidden md:block"
            style="filter: drop-shadow(0 0 8px rgba(234, 179, 8, 0.5));">
            <i class="fas fa-car-side"></i>
        </div>

        <div class="container max-w-5xl mx-auto relative z-10 h-200">
            <div class="flex flex-col md:flex-row rounded-3xl shadow-2xl overflow-hidden glassmorphism">
                <!-- Left Side - Car Image & Features -->
                <div class="w-full md:w-1/2 car-bg relative hidden md:block">
                    <div class="absolute inset-0 bg-gradient-to-t from-black to-transparent"></div>

                    <!-- Floating luxury car badges -->
                    <div class="absolute top-8 left-8 bg-black/70 backdrop-blur-md px-4 py-2 rounded-full animate-float"
                        style="animation-delay: 0s">
                        <div class="flex items-center space-x-2">
                            <i class="fas fa-award text-yellow-400"></i>
                            <span class="text-white text-sm font-medium">Service 5 étoiles</span>
                        </div>
                    </div>

                    <div class="absolute top-8 right-8 bg-black/70 backdrop-blur-md px-4 py-2 rounded-full animate-float"
                        style="animation-delay: 1s">
                        <div class="flex items-center space-x-2">
                            <i class="fas fa-shield-alt text-blue-400"></i>
                            <span class="text-white text-sm font-medium">Protection Premium</span>
                        </div>
                    </div>

                    <div class="absolute bottom-40 left-8 bg-black/70 backdrop-blur-md px-4 py-2 rounded-full animate-float"
                        style="animation-delay: 2s">
                        <div class="flex items-center space-x-2">
                            <i class="fas fa-map-marker-alt text-red-400"></i>
                            <span class="text-white text-sm font-medium">Livraison Partout</span>
                        </div>
                    </div>

                    <div class="absolute bottom-0 left-0 right-0 p-8 text-white">
                        <h1 class="text-3xl font-bold">Premium Car Rental</h1>
                        <p class="text-gray-300 mt-2">L'excellence à votre service</p>

                        <div class="mt-8">
                            <div class="flex items-center">
                                <i class="fas fa-car text-yellow-400 text-3xl mr-3 animate-pulse-slow"></i>
                                <div>
                                    <p class="font-medium">Expérience de conduite exclusive</p>
                                    <div class="flex mt-2">
                                        <i class="fas fa-star text-yellow-400"></i>
                                        <i class="fas fa-star text-yellow-400"></i>
                                        <i class="fas fa-star text-yellow-400"></i>
                                        <i class="fas fa-star text-yellow-400"></i>
                                        <i class="fas fa-star text-yellow-400"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Luxury car features -->
                            <div class="mt-6 grid grid-cols-2 gap-4">
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-check-circle text-green-400"></i>
                                    <span class="text-sm">Véhicules haut de gamme</span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-check-circle text-green-400"></i>
                                    <span class="text-sm">Service 24/7</span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-check-circle text-green-400"></i>
                                    <span class="text-sm">Assurance complète</span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-check-circle text-green-400"></i>
                                    <span class="text-sm">Assistance routière</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Login Form with enhanced animations -->
                <div class="w-full md:w-1/2 p-8 md:p-12 bg-white/90 backdrop-blur-lg">
                    <div class="mb-8 text-center">
                        <div class="flex items-center justify-center">
                            <div class="relative">
                                <i class="fas fa-car-side text-4xl text-blue-700 mr-3"></i>
                                <!-- Engine revving animation -->
                                <div class="absolute -right-1 -top-1">
                                    <div id="engineEffect" class="opacity-0">
                                        <i class="fas fa-bolt text-yellow-500 text-xs"></i>
                                    </div>
                                </div>
                            </div>
                            <h2
                                class="text-3xl font-bold bg-gradient-to-r from-blue-700 to-indigo-600 text-transparent bg-clip-text">
                                Premium Car Rental
                            </h2>
                        </div>
                        <p class="text-gray-600 mt-2">
                            Accédez à votre espace premium
                        </p>
                    </div>

                    <form action="AuthServlet" method="post" class="space-y-6" id="loginForm">
                        <div class="opacity-0" id="adresseField">
                            <label class="block text-gray-700 font-medium mb-2" for="adresse">
                                <i class="fas fa-user text-blue-600 mr-2"></i>Adresse email
                            </label>
                            <div class="relative group">
                                <input type="text" id="adresse" name="adresse" required
                                    class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all pl-12 group-hover:shadow-md">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i
                                        class="fas fa-envelope text-gray-400 group-hover:text-blue-500 transition-colors"></i>
                                </div>
                            </div>
                        </div>

                        <div class="opacity-0" id="passwordField">
                            <label class="block text-gray-700 font-medium mb-2" for="password">
                                <i class="fas fa-lock text-blue-600 mr-2"></i>Mot de passe
                            </label>
                            <div class="relative group">
                                <input type="password" id="password" name="password" required
                                    class="w-full px-4 py-4 rounded-xl border border-gray-300 focus:ring-3 focus:ring-blue-500/30 focus:border-blue-500 transition-all pl-12 group-hover:shadow-md">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i
                                        class="fas fa-lock text-gray-400 group-hover:text-blue-500 transition-colors"></i>
                                </div>
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer"
                                    id="togglePassword">
                                    <i class="fas fa-eye text-gray-400 hover:text-blue-500 transition-colors"></i>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between opacity-0" id="rememberField">
                            <div class="flex items-center">
                                <input id="remember" name="remember" type="checkbox"
                                    class="h-5 w-5 text-blue-600 focus:ring-blue-500 border-gray-300 rounded-md">
                                <label for="remember" class="ml-2 block text-sm text-gray-700">
                                    Se souvenir de moi
                                </label>
                            </div>
                            <a href="#" class="text-sm text-blue-600 hover:text-blue-800 transition-colors font-medium">
                                Mot de passe oublié?
                            </a>
                        </div>

                        <div class="opacity-0" id="submitField">
                            <button type="submit"
                                class="w-full bg-gradient-to-r from-blue-600 to-indigo-700 text-white font-medium py-4 px-6 rounded-xl shadow-lg hover:shadow-xl hover:shadow-blue-500/20 transform hover:-translate-y-1 transition-all duration-300 flex items-center justify-center group">
                                <span class="relative">
                                    <i class="fas fa-sign-in-alt mr-2 group-hover:animate-pulse"></i>
                                    <span>Se connecter</span>
                                </span>
                            </button>
                        </div>

                        <!-- Login options -->
                        <div class="opacity-0 mt-4" id="loginOptions">
                            <div class="relative flex items-center">
                                <div class="flex-grow border-t border-gray-300"></div>
                                <span class="flex-shrink mx-4 text-gray-500 text-sm">Ou connectez-vous avec</span>
                                <div class="flex-grow border-t border-gray-300"></div>
                            </div>

                            <div class="flex space-x-3 mt-4">
                                <button type="button"
                                    class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-300 rounded-lg bg-white hover:bg-gray-50 transition-colors shadow-sm">
                                    <i class="fab fa-google text-red-500 mr-2"></i>
                                    <span class="text-sm font-medium text-gray-700">Google</span>
                                </button>
                                <button type="button"
                                    class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-300 rounded-lg bg-white hover:bg-gray-50 transition-colors shadow-sm">
                                    <i class="fab fa-apple text-black mr-2"></i>
                                    <span class="text-sm font-medium text-gray-700">Apple</span>
                                </button>
                            </div>
                        </div>
                    </form>

                    <div class="mt-8 text-center opacity-0" id="registerField">
                        <p class="text-sm text-gray-600">
                            Nouveau sur Premium Car Rental?
                            <a href="Inscription.jsp"
                                class="text-blue-600 hover:text-blue-800 font-medium transition-colors underline">
                                Créer un compte
                            </a>
                        </p>
                    </div>

                    <div class="mt-8 border-t pt-6 opacity-0" id="securityField">
                        <div class="flex items-center justify-center space-x-2">
                            <i class="fas fa-shield-alt text-green-600"></i>
                            <p class="text-sm text-gray-500">
                                Connexion sécurisée avec encryption SSL
                            </p>
                        </div>
                    </div>

                    <!-- Google Login Button -->
                    <div class="mt-4 text-center">
                        <a href="GoogleLoginServlet"
                            class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded inline-flex items-center">
                            <i class="fab fa-google mr-2"></i>
                            Login with Google
                        </a>
                    </div>
                </div>
            </div>

            <!-- Floating cars at the bottom -->
            <div class="mt-10 text-center relative">
                <div class="flex justify-center space-x-12">
                    <div class="text-white text-xs opacity-0" id="car1">
                        <i class="fas fa-car-side text-2xl"></i>
                        <div class="mt-2">
                            <span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">
                                Sedan Premium
                            </span>
                        </div>
                    </div>
                    <div class="text-white text-xs opacity-0" id="car2">
                        <i class="fas fa-truck-monster text-2xl"></i>
                        <div class="mt-2">
                            <span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">
                                SUV de Luxe
                            </span>
                        </div>
                    </div>
                    <div class="text-white text-xs opacity-0" id="car3">
                        <i class="fas fa-car-side text-2xl"></i>
                        <div class="mt-2">
                            <span class="bg-white/10 backdrop-blur-md px-3 py-1 rounded-full">
                                Sportive
                            </span>
                        </div>
                    </div>
                </div>

                <div class="mt-6 text-white text-xs opacity-0" id="copyright">
                    <span class="bg-white/10 backdrop-blur-md px-4 py-2 rounded-full inline-block">
                        © 2025 Premium Car Rental | Tous droits réservés
                    </span>
                </div>
            </div>
        </div>

        <script>
            document.querySelectorAll('input').forEach(input => {
                input.addEventListener('focus', function () {
                    this.parentElement.classList.add('ring', 'ring-blue-300');
                    gsap.to(this.parentElement, { scale: 1.02, duration: 0.3, ease: "power2.out" });
                });

                input.addEventListener('blur', function () {
                    this.parentElement.classList.remove('ring', 'ring-blue-300');
                    gsap.to(this.parentElement, { scale: 1, duration: 0.3, ease: "power2.out" });
                });
            });

            document.getElementById('togglePassword').addEventListener('click', function () {
                const passwordInput = document.getElementById('password');
                const icon = this.querySelector('i');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
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

            // Initialize all animations when DOM is loaded
            document.addEventListener('DOMContentLoaded', () => {
                // Form fields fade in sequence
                gsap.to('#adresseField', { opacity: 1, y: 0, duration: 0.6, delay: 0.2 });
                gsap.to('#passwordField', { opacity: 1, y: 0, duration: 0.6, delay: 0.4 });
                gsap.to('#rememberField', { opacity: 1, y: 0, duration: 0.6, delay: 0.6 });
                gsap.to('#submitField', { opacity: 1, y: 0, duration: 0.6, delay: 0.8 });
                gsap.to('#loginOptions', { opacity: 1, y: 0, duration: 0.6, delay: 1.0 });
                gsap.to('#registerField', { opacity: 1, y: 0, duration: 0.6, delay: 1.2 });
                gsap.to('#securityField', { opacity: 1, y: 0, duration: 0.6, delay: 1.4 });

                // Car icons at the bottom
                gsap.to('#car1', { opacity: 1, y: 0, duration: 0.6, delay: 1.6 });
                gsap.to('#car2', { opacity: 1, y: 0, duration: 0.6, delay: 1.8 });
                gsap.to('#car3', { opacity: 1, y: 0, duration: 0.6, delay: 2.0 });
                gsap.to('#copyright', { opacity: 1, y: 0, duration: 0.6, delay: 2.2 });

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
                    gsap.to(submitBtn, { scale: 1.03, duration: 0.3 });
                });
                submitBtn.addEventListener('mouseleave', () => {
                    gsap.to(submitBtn, { scale: 1, duration: 0.3 });
                });
            });
        </script>
    </body>

    </html>