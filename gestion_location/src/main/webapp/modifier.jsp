<%@ page import="entity.Client" %>
<%@ page import="doo.ClientDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un Client | Premium Car Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.10.3/cdn.min.js" defer></script>
    <style>
        .car-bg {
            background-image: url('https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3');
            background-size: cover;
            background-position: center;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fadeIn {
            animation: fadeIn 0.6s ease-out forwards;
        }
        
        @keyframes slideIn {
            from { transform: translateX(-20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        .animate-slideIn {
            animation: slideIn 0.5s ease-out forwards;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    <%
    String codeClient = request.getParameter("codeClient");
    ClientDAO clientDAO = new ClientDAO();

    Client client = clientDAO.getClientById(codeClient);
    %>

    <!-- Header with car animation -->
    <div x-data="{ showCar: false }" x-init="setTimeout(() => showCar = true, 300)" 
         class="bg-gradient-to-r from-blue-900 to-indigo-900 text-white p-6 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <div class="flex items-center space-x-3">
                <i class="fas fa-car-side text-3xl text-yellow-400"></i>
                <h1 class="text-2xl font-bold">Premium Car Rental</h1>
            </div>
            <div x-show="showCar" x-transition class="hidden md:block">
                <i class="fas fa-car animate-bounce text-2xl text-yellow-400"></i>
            </div>
        </div>
    </div>

    <!-- Main content -->
    <div class="container mx-auto p-6 md:p-10">
        <div class="flex flex-col md:flex-row gap-8">
            <!-- Form Section -->
            <div class="w-full md:w-2/3 animate-fadeIn" style="animation-delay: 0.2s;">
                <div class="bg-white rounded-xl shadow-xl overflow-hidden">
                    <div class="bg-gradient-to-r from-blue-700 to-indigo-800 p-6">
                        <h2 class="text-2xl font-bold text-white flex items-center">
                            <i class="fas fa-user-edit mr-3"></i>
                            Modifier les informations du client
                        </h2>
                    </div>
                    
                    <form action="ClientServlet" method="post" class="p-6 space-y-6">
                        <input type="hidden" name="action" value="modifier">
                        <input type="hidden" name="codeClient" value="<%= client.getCodeClient() %>">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="animate-slideIn" style="animation-delay: 0.3s;">
                                <label class="block text-gray-700 font-medium mb-2" for="ncin">
                                    <i class="fas fa-id-card mr-2 text-blue-600"></i>NCIN
                                </label>
                                <input type="text" id="ncin" name="ncin" value="<%= client.getNcin() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                            
                            <div class="animate-slideIn" style="animation-delay: 0.4s;">
                                <label class="block text-gray-700 font-medium mb-2" for="nom">
                                    <i class="fas fa-user mr-2 text-blue-600"></i>Nom
                                </label>
                                <input type="text" id="nom" name="nom" value="<%= client.getNom() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                            
                            <div class="animate-slideIn" style="animation-delay: 0.5s;">
                                <label class="block text-gray-700 font-medium mb-2" for="prenom">
                                    <i class="fas fa-user mr-2 text-blue-600"></i>Prénom
                                </label>
                                <input type="text" id="prenom" name="prenom" value="<%= client.getPrenom() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                            
                            <div class="animate-slideIn" style="animation-delay: 0.6s;">
                                <label class="block text-gray-700 font-medium mb-2" for="numTel">
                                    <i class="fas fa-phone mr-2 text-blue-600"></i>Téléphone
                                </label>
                                <input type="text" id="numTel" name="numTel" value="<%= client.getNumTel() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                            
                            <div class="animate-slideIn" style="animation-delay: 0.7s;">
                                <label class="block text-gray-700 font-medium mb-2" for="adresse">
                                    <i class="fas fa-map-marker-alt mr-2 text-blue-600"></i>Adresse
                                </label>
                                <input type="text" id="adresse" name="adresse" value="<%= client.getAdresse() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                            
                            <div class="animate-slideIn" style="animation-delay: 0.8s;">
                                <label class="block text-gray-700 font-medium mb-2" for="email">
                                    <i class="fas fa-envelope mr-2 text-blue-600"></i>Email
                                </label>
                                <input type="email" id="email" name="email" value="<%= client.getEmail() %>" required
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            </div>
                        </div>
                        
                        <div class="flex space-x-4 pt-4 animate-fadeIn" style="animation-delay: 1s;">
                            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-700 text-white font-medium rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-200 flex items-center">
                                <i class="fas fa-save mr-2"></i>
                                Enregistrer les modifications
                            </button>
                            <a href="GererClient.jsp" class="px-6 py-3 bg-gray-200 text-gray-700 font-medium rounded-lg shadow hover:shadow-md transform hover:-translate-y-1 transition-all duration-200 flex items-center">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Retour à la liste
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Decorative Side Panel -->
            <div class="w-full md:w-1/3 hidden md:block animate-fadeIn" style="animation-delay: 0.5s;">
                <div class="bg-white rounded-xl shadow-xl overflow-hidden h-full">
                    <div class="car-bg h-48 relative">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end">
                            <h3 class="text-white text-xl font-bold p-6">Gestion Premium</h3>
                        </div>
                    </div>
                    <div class="p-6 space-y-6">
                        <div class="flex items-center space-x-4">
                            <div class="bg-blue-100 p-3 rounded-full">
                                <i class="fas fa-shield-alt text-blue-600 text-xl"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800">Données Sécurisées</h4>
                                <p class="text-gray-600">Protection des informations clients</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center space-x-4">
                            <div class="bg-indigo-100 p-3 rounded-full">
                                <i class="fas fa-tachometer-alt text-indigo-600 text-xl"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800">Performances</h4>
                                <p class="text-gray-600">Gestion rapide et efficace</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center space-x-4">
                            <div class="bg-yellow-100 p-3 rounded-full">
                                <i class="fas fa-star text-yellow-600 text-xl"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800">Service Premium</h4>
                                <p class="text-gray-600">Pour une expérience de qualité</p>
                            </div>
                        </div>
                        
                        <!-- Animated car -->
                        <div class="flex justify-center pt-4">
                            <div class="relative">
                                <i class="fas fa-car-side text-4xl text-blue-700"></i>
                                <div class="absolute -bottom-1 left-0 right-0 flex justify-center">
                                    <div class="animate-spin rounded-full h-3 w-3 border-b-2 border-gray-800"></div>
                                    <div class="animate-spin rounded-full h-3 w-3 border-b-2 border-gray-800 ml-8"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-gray-800 text-white p-6 mt-10">
        <div class="container mx-auto">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="flex items-center space-x-2 mb-4 md:mb-0">
                    <i class="fas fa-car-side text-yellow-400"></i>
                    <span class="font-bold">Premium Car Rental</span>
                </div>
                <div class="flex space-x-4">
                    <a href="#" class="hover:text-yellow-400 transition-colors">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <a href="#" class="hover:text-yellow-400 transition-colors">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="hover:text-yellow-400 transition-colors">
                        <i class="fab fa-twitter"></i>
                    </a>
                </div>
            </div>
        </div>
    </footer>
    
    <script>
        // Add some subtle animations when the form fields are focused
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function() {
                this.classList.add('scale-105');
                setTimeout(() => this.classList.remove('scale-105'), 200);
            });
        });
    </script>
</body>
</html>