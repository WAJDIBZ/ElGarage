<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter Client | AutoGestion</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0f9ff',
                            100: '#e0f2fe',
                            200: '#bae6fd',
                            300: '#7dd3fc',
                            400: '#38bdf8',
                            500: '#0ea5e9',
                            600: '#0284c7',
                            700: '#0369a1',
                            800: '#075985',
                            900: '#0c4a6e',
                        }
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-up': 'slideUp 0.5s ease-in-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' },
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(20px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' },
                        }
                    }
                }
            }
        }
    </script>
    <style>
        .car-pattern {
    background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M10 40 h40 v-10 h-5 l-5-10 h-20 l-5 10 h-5 v10 z M15 40 a5 5 0 1 0 0-10 a5 5 0 0 0 0 10 z M45 40 a5 5 0 1 0 0-10 a5 5 0 0 0 0 10 z' fill='%232096f3' fill-opacity='0.05' fill-rule='evenodd'/%3E%3C/svg%3E");
}
        .input-animation {
            transition: all 0.3s ease;
        }
        
        .input-animation:focus-within {
            transform: translateY(-3px);
        }
        
        .car-drive {
            animation: drive 20s linear infinite;
            transform-origin: center;
        }
        
        @keyframes drive {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(500%); }
        }
        
        .floating {
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        
        .pulse-button {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(2, 132, 199, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(2, 132, 199, 0); }
            100% { box-shadow: 0 0 0 0 rgba(2, 132, 199, 0); }
        }
        
        .glow-on-hover {
            transition: all 0.3s ease;
        }
        
        .glow-on-hover:hover {
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.6);
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen car-pattern">
    <div class="flex">
        <!-- Sidebar -->
        <div class="fixed h-screen w-64 bg-primary-800 text-white shadow-xl">
            <div class="p-6 border-b border-primary-700">
                <h2 class="text-2xl font-bold">ELGarage</h2>
                <p class="text-xs text-primary-300">Location de voitures</p>
            </div>
            <nav class="mt-6">
                <a href="GererClient.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                    <i class="fas fa-users mr-3"></i><span>Clients</span>
                </a>
                <a href="GererVehicules.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                    <i class="fas fa-car mr-3"></i><span>Véhicules</span>
                </a>
                <a href="GererLocations.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                    <i class="fas fa-calendar-check mr-3"></i><span>Locations</span>
                </a>
                <a href="GererCalendar.jsp" class="flex items-center py-3 pl-6 pr-4 bg-primary-700 border-l-4 border-white">
                    <i class="fas fa-calendar-check mr-3"></i><span>Calendrier</span>
                </a>
                <a href="GererParcs.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                    <i class="fas fa-parking mr-3"></i><span>Parcs</span>

                </a>


            </nav>
            <div class="absolute bottom-0 w-full p-4 border-t border-primary-700">
                <div class="flex items-center">
                    <div class="h-10 w-10 rounded-full bg-primary-600 flex items-center justify-center">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="ml-3">
                        <p class="font-medium">Admin</p>
                        <p class="text-xs text-primary-300">admin@elgarage.com</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="ml-64 w-full">
            <!-- Top Navigation -->
            <div class="bg-white shadow-md p-4 flex justify-between items-center">
                <div class="flex items-center">
                    <button class="mr-4 text-gray-500 hover:text-primary-500">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                    <h1 class="text-xl font-semibold text-gray-700">Gestion des Clients</h1>
                </div>
                <div class="flex items-center">
                <!--  
                    <button class="relative p-2 mx-2 bg-gray-100 rounded-full hover:bg-gray-200">
                        <i class="fas fa-bell text-gray-600"></i>
                        <span class="absolute top-0 right-0 h-4 w-4 bg-red-500 rounded-full text-xs text-white flex items-center justify-center">2</span>
                    </button>-->
                    <button class="p-2 mx-2 bg-gray-100 rounded-full hover:bg-gray-200">
                        <i class="fas fa-envelope text-gray-600"></i>
                    </button>
                    <div class="relative mx-2">
                        <button class="flex items-center focus:outline-none">
                            <div class="h-8 w-8 rounded-full bg-primary-600 flex items-center justify-center text-white">
                                <i class="fas fa-user"></i>
                            </div>
                            <span class="ml-2 font-medium text-gray-700">Admin</span><!--  
                            <i class="fas fa-chevron-down ml-2 text-xs text-gray-500"></i>-->
                        </button>
                    </div>
                </div>
            </div>

            <!-- Page Content -->
            <div class="container mx-auto p-6">
                <!-- Breadcrumbs -->
                <div class="flex items-center text-sm text-gray-500 mb-6 animate__animated animate__fadeIn">
                    <a href="GererClient.jsp" class="hover:text-primary-600">Accueil</a>
                    <i class="fas fa-chevron-right mx-2 text-xs"></i>
                    <a href="GererClient.jsp" class="hover:text-primary-600">Clients</a>
                    <i class="fas fa-chevron-right mx-2 text-xs"></i>
                    <span class="text-gray-700 font-medium">Ajouter un client</span>
                </div>

                <!-- Car Animation -->
                <div class="relative w-full h-20 mb-6 overflow-hidden animate__animated animate__fadeIn">
                    <div class="car-drive absolute">
                        <img src="https://www.svgrepo.com/show/490618/car-sports.svg" width="120" height="40">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <!-- Main Form Card -->
                    <div class="md:col-span-2">
                        <div class="bg-white rounded-lg shadow-lg overflow-hidden animate__animated animate__fadeInUp">
                            <!-- Card Header -->
                            <div class="bg-gradient-to-r from-primary-600 to-primary-700 px-6 py-4 flex items-center justify-between">
                                <h2 class="text-xl font-bold text-white flex items-center">
                                    <i class="fas fa-user-plus mr-3"></i>
                                    Ajouter un nouveau client
                                </h2>
                                <div class="bg-white bg-opacity-20 rounded-full p-2">
                                    <i class="fas fa-id-card text-white text-lg"></i>
                                </div>
                            </div>
                            
                            <!-- Form -->
                            <div class="p-6">
                                <form action="ClientServlet" method="post" class="space-y-6">
                                    <input type="hidden" name="action" value="ajouter">
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <!-- NCIN -->
                                        <div class="input-animation">
                                            <label for="ncin" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-id-card mr-2 text-primary-500"></i>
                                                Numéro CIN
                                            </label>
                                            <div class="relative">
                                                <input type="text" id="ncin" name="ncin" required
                                                    class="w-full px-4 py-2 pl-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                    placeholder="ex: 01123456">
                                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                                    <i class="fas fa-check-circle text-gray-400"></i>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Nom -->
                                        <div class="input-animation">
                                            <label for="nom" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-user mr-2 text-primary-500"></i>
                                                Nom
                                            </label>
                                            <input type="text" id="nom" name="nom" required
                                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                placeholder="Nom du client">
                                        </div>
                                        
                                        <!-- Prénom -->
                                        <div class="input-animation">
                                            <label for="prenom" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-user mr-2 text-primary-500"></i>
                                                Prénom
                                            </label>
                                            <input type="text" id="prenom" name="prenom" required
                                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                placeholder="Prénom du client">
                                        </div>
                                        
                                        <!-- Numéro de téléphone -->
                                        <div class="input-animation">
                                            <label for="numTel" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-phone mr-2 text-primary-500"></i>
                                                Numéro de téléphone
                                            </label>
                                            <div class="relative">
                                                <input type="tel" id="numTel" name="numTel" required
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                    placeholder="ex: +216 XX XXX XXX">
                                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                                    <i class="fas fa-mobile-alt text-gray-400"></i>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Email -->
                                        <div class="input-animation md:col-span-2">
                                            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-envelope mr-2 text-primary-500"></i>
                                                Email
                                            </label>
                                            <div class="relative">
                                                <input type="email" id="email" name="email" required
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                    placeholder="email@exemple.com">
                                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                                    <i class="fas fa-at text-gray-400"></i>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Adresse -->
                                        <div class="input-animation md:col-span-2">
                                            <label for="adresse" class="block text-sm font-medium text-gray-700 mb-1">
                                                <i class="fas fa-map-marker-alt mr-2 text-primary-500"></i>
                                                Adresse
                                            </label>
                                            <textarea id="adresse" name="adresse" rows="3"
                                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 glow-on-hover"
                                                placeholder="Adresse complète du client"></textarea>
                                        </div>
                                    </div>
                                    
                                    <div class="pt-4 flex justify-between items-center border-t border-gray-200">
                                        <a href="GererClient.jsp" class="text-primary-600 hover:text-primary-800 flex items-center">
                                            <i class="fas fa-arrow-left mr-2"></i>
                                            Retour à la liste
                                        </a>
                                        <div class="flex space-x-3">
                                            <button type="reset" class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition duration-300 flex items-center">
                                                <i class="fas fa-redo mr-2"></i>
                                                Réinitialiser
                                            </button>
                                            <button type="submit" class="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition duration-300 pulse-button flex items-center">
                                                <i class="fas fa-save mr-2"></i>
                                                Enregistrer
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Side Panel -->
                    <div class="md:col-span-1 space-y-6">
                        <!-- Information Card -->
                        <div class="bg-white rounded-lg shadow-lg overflow-hidden animate__animated animate__fadeInRight animate__delay-1s">
                            <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
                                <h3 class="text-lg font-bold text-white flex items-center">
                                    <i class="fas fa-info-circle mr-2"></i>
                                    Informations
                                </h3>
                            </div>
                            <div class="p-6 space-y-4">
                                <div class="flex items-start">
                                    <div class="bg-blue-100 p-2 rounded-full mt-1">
                                        <i class="fas fa-user-shield text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <h4 class="font-medium text-gray-800">Données confidentielles</h4>
                                        <p class="text-sm text-gray-600">Les informations clients sont protégées et sécurisées.</p>
                                    </div>
                                </div>
                                <div class="flex items-start">
                                    <div class="bg-blue-100 p-2 rounded-full mt-1">
                                        <i class="fas fa-id-card text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <h4 class="font-medium text-gray-800">CIN obligatoire</h4>
                                        <p class="text-sm text-gray-600">Document officiel nécessaire pour la location.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Car Card -->
                        <div class="bg-white rounded-lg shadow-lg overflow-hidden animate__animated animate__fadeInRight animate__delay-2s">
                            <div class="relative h-40 bg-gradient-to-r from-gray-800 to-gray-900 overflow-hidden">
                                <div class="absolute inset-0 opacity-20 bg-pattern"></div>
                                <div class="absolute bottom-0 left-0 right-0 p-4">
                                    <h3 class="text-lg font-bold text-white">Nos véhicules premium</h3>
                                    <p class="text-sm text-gray-300">Découvrez notre gamme exclusive</p>
                                </div>
                                <div class="absolute right-4 bottom-12 floating">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="120" height="50" viewBox="0 0 100 30" class="text-primary-500">
                                        <path fill="currentColor" d="M15,8 L18,8 L19,11 L85,11 L90,17 L87,24 L12,24 L8,17 L15,8 Z M25,24 L25,27 L18,27 L18,24 M80,24 L80,27 L73,27 L73,24 M23,13 C20.5,13 18.5,15 18.5,17.5 C18.5,20 20.5,22 23,22 C25.5,22 27.5,20 27.5,17.5 C27.5,15 25.5,13 23,13 Z M75,13 C72.5,13 70.5,15 70.5,17.5 C70.5,20 72.5,22 75,22 C77.5,22 79.5,20 79.5,17.5 C79.5,15 77.5,13 75,13 Z" fill="white"/>
                                    </svg>
                                </div>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="flex items-center">
                                        <i class="fas fa-check-circle text-green-500 mr-2"></i>
                                        <span class="text-sm text-gray-600">Véhicules neufs</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="fas fa-check-circle text-green-500 mr-2"></i>
                                        <span class="text-sm text-gray-600">Kilométrage illimité</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="fas fa-check-circle text-green-500 mr-2"></i>
                                        <span class="text-sm text-gray-600">Assistance 24/7</span>
                                    </div>
                                </div>
                                <button class="w-full mt-4 bg-primary-600 text-white py-2 rounded-lg hover:bg-primary-700 transition duration-300">
                                    Découvrir la flotte
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Footer -->
                <div class="mt-8 text-center text-gray-500 text-sm animate__animated animate__fadeIn animate__delay-2s">
                    <p>© 2025 AutoGestion Location Voitures - Tous droits réservés</p>
                    <p class="mt-1">Version 2.4.1</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Form validation enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const inputs = form.querySelectorAll('input[required], textarea[required]');
            
            inputs.forEach(input => {
                // Add animation when input is focused
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('animate__animated', 'animate__pulse');
                    setTimeout(() => {
                        this.parentElement.classList.remove('animate__animated', 'animate__pulse');
                    }, 1000);
                });
                
                // Validate inputs
                input.addEventListener('blur', function() {
                    if (this.value.trim() !== '') {
                        this.classList.add('border-green-400');
                        if (this.nextElementSibling && this.nextElementSibling.querySelector('i')) {
                            this.nextElementSibling.querySelector('i').className = 'fas fa-check-circle text-green-500';
                        }
                    } else {
                        this.classList.add('border-red-400');
                        if (this.nextElementSibling && this.nextElementSibling.querySelector('i')) {
                            this.nextElementSibling.querySelector('i').className = 'fas fa-exclamation-circle text-red-500';
                        }
                    }
                });
            });
            
            // Submit animation
            form.addEventListener('submit', function(e) {
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Enregistrement...';
                submitBtn.disabled = true;
            });
        });
    </script>
</body>
</html>
