<%@ page import="java.util.List, java.util.Map, java.util.HashMap" %>
<%@ page import="doo.ParcDAO, doo.VehiculeParcDAO" %>
<%@ page import="entity.Parc, entity.Voiture" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // DAOs
    ParcDAO parcDao = new ParcDAO();
    VehiculeParcDAO vpDao = new VehiculeParcDAO();

    // Récupérer tous les parcs
    List<Parc> parcs = parcDao.getAllParcs();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gérer les Locations | ELGarage</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        .parc-card { width: 100%; max-width: 350px; }
        .map-frame { width:100%; height:150px; border:0; border-radius:4px; }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50:  '#f0f9ff',
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
                    }
                }
            }
        }
    </script>
    <style>
        thead th { position: sticky; top: 0; z-index: 10; background: white; }
        .glass-effect {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        .shadow-custom {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
        }
        .hover-scale {
            transition: transform 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.02);
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-sans">
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
            <a href="GererCalendar.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
                <i class="fas fa-calendar-check mr-3"></i><span>Calendrier</span>
            </a>
            <a href="#" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
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

    <!-- Main -->
    <div class="ml-64 w-full">
        <!-- Top bar -->
        <div class="bg-white shadow-md p-4 flex justify-between items-center">
            <div class="flex items-center">
                <button class="mr-4 text-gray-500 hover:text-primary-500"><i class="fas fa-bars text-xl"></i></button>
                <h1 class="text-xl font-semibold text-gray-700">Tableau de bord</h1>
            </div>
            <a href="index.jsp" class="flex items-center text-red-700 hover:text-red-800">
                <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
            </a>
        </div>

        <!-- Content - ENHANCED SECTION -->
        <div class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
            <div class="max-w-7xl mx-auto p-6">
                <!-- Header Section -->
                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h1 class="text-4xl font-extrabold text-gray-800 mb-2 flex items-center">
                            <i class="fas fa-parking text-primary-600 mr-3"></i>
                            Gestion des Parcs
                        </h1>
                        <p class="text-gray-600 text-lg">Visualisez et gérez votre réseau de parcs automobiles</p>
                    </div>
                    <div class="bg-white shadow-lg rounded-lg p-4 text-center">
                        <h3 class="text-xl font-bold text-primary-600">
                            <i class="fas fa-car-side mr-2"></i>Total Parcs
                        </h3>
                        <p class="text-3xl font-bold text-gray-800"><%= parcs.size() %></p>
                    </div>
                </div>

                <!-- Filter Bar -->
                <div class="flex flex-wrap items-center mb-8 bg-white shadow-lg rounded-lg p-4">
                    <div class="mr-4 flex items-center">
                        <i class="fas fa-filter text-primary-500 mr-2"></i>
                        <span class="text-gray-700 font-medium">Filtrer par:</span>
                    </div>
                    <div class="flex space-x-2">
                        <select class="px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-gray-700">
                            <option>Tous les parcs</option>
                            <option>Parcs actifs</option>
                            <option>Parcs inactifs</option>
                        </select>
                        <select class="px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-gray-700">
                            <option>Toutes les capacités</option>
                            <option>Moins de 50 places</option>
                            <option>50-100 places</option>
                            <option>Plus de 100 places</option>
                        </select>
                    </div>
                    <div class="flex-grow"></div>
                    <div class="mt-2 sm:mt-0">
                        <button class="bg-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg transition duration-200 flex items-center">
                            <i class="fas fa-plus mr-2"></i>
                            Ajouter un parc
                        </button>
                    </div>
                </div>

                <!-- Parc Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    <% for (Parc p : parcs) {
                        // récupérer la liste des véhicules actuellement dans ce parc
                        List<Voiture> vehs = vpDao.getActiveVehiclesByParc(p.getCodeParc());
                        // compter par modèle
                        Map<String,Integer> modelCounts = new HashMap<>();
                        for (Voiture v : vehs) {
                            modelCounts.put(v.getModele(),
                                    modelCounts.getOrDefault(v.getModele(),0) + 1);
                        }

                        // Calculer le taux d'occupation
                        int occupationRate = p.getCapaciteMax() > 0 ?
                                (int)((double)vehs.size() / p.getCapaciteMax() * 100) : 0;

                        // Déterminer la couleur de l'indicateur d'occupation
                        String rateColor = "bg-green-500";
                        if (occupationRate > 80) {
                            rateColor = "bg-red-500";
                        } else if (occupationRate > 50) {
                            rateColor = "bg-yellow-500";
                        }
                    %>
                    <div class="hover-scale shadow-custom rounded-xl overflow-hidden bg-white transition-all duration-300">
                        <!-- Image avec overlay -->
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/assets/img/img.png"
                                 alt="Parc <%=p.getNomParc()%>" class="w-full h-48 object-cover"/>
                            <div class="absolute top-0 left-0 w-full h-full bg-gradient-to-t from-black/70 to-transparent"></div>
                            <div class="absolute bottom-0 left-0 w-full p-4 text-white">
                                <h2 class="text-2xl font-bold mb-1 drop-shadow-md"><%= p.getNomParc() %></h2>
                                <p class="text-sm flex items-center">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <%= p.getAdresse() %>
                                </p>
                            </div>
                            <!-- Badge de statut -->
                            <div class="absolute top-4 right-4 px-3 py-1 rounded-full text-xs font-medium
                                <%= p.getStatut().equalsIgnoreCase("actif") ? "bg-green-500" : "bg-gray-500" %> text-white">
                                <%= p.getStatut() %>
                            </div>
                        </div>

                        <div class="p-5">
                            <div class="flex justify-between items-center mb-4">
                                <div class="flex items-center">
                                    <div class="h-10 w-10 rounded-full bg-primary-100 flex items-center justify-center text-primary-600">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="ml-3">
                                        <span class="text-xs text-gray-500">Responsable</span>
                                        <p class="font-medium text-gray-800"><%= p.getResponsable() %></p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="text-xs text-gray-500">Capacité</span>
                                    <p class="font-bold text-gray-800"><%= p.getCapaciteMax() %> places</p>
                                </div>
                            </div>

                            <!-- Indicateur d'occupation -->
                            <div class="mb-4">
                                <div class="flex justify-between items-center mb-1">
                                    <span class="text-sm text-gray-600">Taux d'occupation</span>
                                    <span class="text-sm font-medium text-gray-800"><%= occupationRate %>%</span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-2">
                                    <div class="<%= rateColor %> h-2 rounded-full" style="width: <%= occupationRate %>%"></div>
                                </div>
                            </div>

                            <!-- Carte Google Maps avec cadre arrondi et ombre -->
                            <div class="mb-4 rounded-lg overflow-hidden shadow-md">
                                <iframe
                                        class="map-frame"
                                        src="https://www.google.com/maps?q=<%= java.net.URLEncoder.encode(p.getAdresse(), "UTF-8") %>&output=embed"
                                        allowfullscreen loading="lazy">
                                </iframe>
                            </div>

                            <!-- Véhicules présents -->
                            <div class="bg-gray-50 rounded-lg p-3">
                                <h3 class="text-sm font-semibold text-gray-800 mb-2 flex items-center">
                                    <i class="fas fa-car text-primary-500 mr-2"></i>
                                    Véhicules présents (<%= vehs.size() %>)
                                </h3>
                                <% if (modelCounts.isEmpty()) { %>
                                <p class="text-gray-500 text-sm flex items-center justify-center p-2">
                                    <i class="fas fa-info-circle mr-2"></i>
                                    Aucun véhicule actuellement
                                </p>
                                <% } else { %>
                                <div class="space-y-2">
                                    <% for (Map.Entry<String,Integer> e : modelCounts.entrySet()) { %>
                                    <div class="flex justify-between items-center text-sm">
                                        <span class="text-gray-700">
                                            <i class="fas fa-car-side text-gray-500 mr-2"></i>
                                            <%= e.getKey() %>
                                        </span>
                                        <span class="bg-primary-100 text-primary-800 px-2 py-1 rounded-full font-medium">
                                            <%= e.getValue() %>
                                        </span>
                                    </div>
                                    <% } %>
                                </div>
                                <% } %>
                            </div>

                            <!-- Actions -->
<%--                            <div class="mt-4 flex space-x-2">--%>
<%--                                <button class="flex-1 bg-primary-50 hover:bg-primary-100 text-primary-600 py-2 rounded-lg transition flex items-center justify-center">--%>
<%--                                    <i class="fas fa-edit mr-1"></i> Éditer--%>
<%--                                </button>--%>
<%--                                <button class="flex-1 bg-primary-600 hover:bg-primary-700 text-white py-2 rounded-lg transition flex items-center justify-center">--%>
<%--                                    <i class="fas fa-car mr-1"></i> Gérer--%>
<%--                                </button>--%>
<%--                            </div>--%>
                        </div>
                    </div>
                    <% } %>
                </div>

                <!-- Pagination -->
                <div class="mt-8 flex justify-center">
                    <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                        <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <span class="sr-only">Previous</span>
                            <i class="fas fa-chevron-left text-xs"></i>
                        </a>
                        <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-primary-600 text-sm font-medium text-white hover:bg-primary-700">
                            1
                        </a>
                        <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                            2
                        </a>
                        <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                            3
                        </a>
                        <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                            ...
                        </span>
                        <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                            8
                        </a>
                        <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <span class="sr-only">Next</span>
                            <i class="fas fa-chevron-right text-xs"></i>
                        </a>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<script>


</script>
</body>
</html>