<%@ page import="java.util.List" %>
<%@ page import="entity.Voiture" %>
<%@ page import="doo.VoitureDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gérer les Véhicules | ELGarage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0f9ff', 100: '#e0f2fe', 200: '#bae6fd',
                            300: '#7dd3fc', 400: '#38bdf8', 500: '#0ea5e9',
                            600: '#0284c7', 700: '#0369a1', 800: '#075985',
                            900: '#0c4a6e'
                        }
                    }
                }
            }
        }
    </script>
    <style>
        /* Custom styles for sticky headers */
        thead th {
            position: sticky;
            top: 0;
            z-index: 10;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-sans">
    <div class="flex">
        <!-- Sidebar -->
        <div class="fixed h-screen w-64 bg-primary-800 text-white shadow-xl transition-all duration-300">
            <div class="p-6 border-b border-primary-700">
                <h2 class="text-2xl font-bold tracking-tight">ELGarage</h2>
                <p class="text-xs text-primary-300">Location de voitures</p>
            </div>
            <nav class="mt-6">
                <a href="GererClient.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition duration-200">
                    <i class="fas fa-users mr-3"></i><span>Clients</span>
                </a>
                <a href="#" class="flex items-center py-3 pl-6 pr-4 bg-primary-700 border-l-4 border-white">
                    <i class="fas fa-car mr-3"></i><span>Véhicules</span>
                </a>
                 <a href="GererLocations.jsp"
                                    class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition duration-200">
                                    <i class="fas fa-calendar-check mr-3"></i>
                                    <span>Locations</span>
                                </a>
                <a href="GererCalendar.jsp" class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition">
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
            <!-- Top Nav -->
            <div class="bg-white shadow-md p-4 flex justify-between items-center">
                <div class="flex items-center">
                    <button class="mr-4 text-gray-500 hover:text-primary-500"><i class="fas fa-bars text-xl"></i></button>
                    <h1 class="text-xl font-semibold text-gray-700">Tableau de bord</h1>
                </div>
                <a href="index.jsp" class="flex items-center text-red-700 hover:text-red-800 transition duration-200">
                    <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                </a>
            </div>

            <!-- Page Content -->
            <div class="container mx-auto p-6">
                <div class="flex items-center text-sm text-gray-500 mb-6">
                    <a href="#" class="hover:text-primary-600 transition duration-200">Accueil</a>
                    <i class="fas fa-chevron-right mx-2 text-xs"></i>
                    <span class="text-gray-700 font-medium">Véhicules</span>
                </div>
                <% VoitureDAO dao = new VoitureDAO(); List<Voiture> vehicules = dao.getAllVoitures(); %>

                <!-- Stat Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-primary-500 transform hover:scale-105 transition duration-300">
                        <p class="text-gray-500 text-sm">Total Véhicules</p>
                        <h3 class="text-3xl font-bold text-gray-800"><%= vehicules.size() %></h3>
                    </div>
<%--                    <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-primary-500 transform hover:scale-105 transition duration-300">--%>
<%--                        <p class="text-gray-500 text-sm">Top Marques</p>--%>
<%--                        <h3 class="text-xl font-bold text-gray-800" id="top-brands"></h3>--%>
<%--                    </div>--%>
                </div>

                <!-- Table Card -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                    <div class="bg-gray-50 px-6 py-4 border-b">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-gray-800">Liste des Véhicules</h2>
                            <a href="AjouterVehicule.jsp" class="bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded-lg transition duration-300 flex items-center shadow-md">
                                <i class="fas fa-plus mr-2"></i>Ajouter un Véhicule
                            </a>
                        </div>
                        <div>
                            <input type="text" id="search" class="w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-primary-500 focus:border-primary-500" placeholder="Rechercher par matricule, marque ou modèle">
                        </div>
                    </div>
                    <div class="max-h-[500px] overflow-y-auto overflow-x-auto">
                        <table class="min-w-full bg-white">
                            <thead>
                                <tr class="bg-gray-100 text-gray-700 text-sm uppercase">
                                    <th class="py-3 px-6 text-left sticky top-0 bg-gray-100 cursor-pointer" onclick="sortTable(0)">Matricule <i class="fas fa-sort ml-1"></i></th>
                                    <th class="py-3 px-6 text-left sticky top-0 bg-gray-100 cursor-pointer" onclick="sortTable(1)">Marque <i class="fas fa-sort ml-1"></i></th>
                                    <th class="py-3 px-6 text-left sticky top-0 bg-gray-100 cursor-pointer" onclick="sortTable(2)">Modèle <i class="fas fa-sort ml-1"></i></th>
                                    <th class="py-3 px-6 text-left sticky top-0 bg-gray-100 cursor-pointer" onclick="sortTable(3)">Kilométrage <i class="fas fa-sort ml-1"></i></th>
                                    <th class="py-3 px-6 text-center sticky top-0 bg-gray-100">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="text-gray-600 text-sm">
                                <% for (Voiture v : vehicules) { %>
                                    <tr class="odd:bg-white even:bg-gray-50 border-b border-gray-200 hover:bg-gray-100 transition duration-200">
                                        <td class="py-3 px-6 font-medium"><%= v.getMatricule() %></td>
                                        <td class="py-3 px-6"><%= v.getMarque() %></td>
                                        <td class="py-3 px-6"><%= v.getModele() %></td>
                                        <td class="py-3 px-6"><%= v.getKilometrage() %> km</td>
                                        <td class="py-3 px-6 text-center flex justify-center space-x-2">
                                            <a href="VoitureDetails.jsp?matricule=<%= v.getMatricule() %>" title="Voir les détails" class="text-blue-500 hover:text-blue-600 p-2 rounded-full hover:bg-blue-50 transition duration-200"><i class="fas fa-eye"></i></a>
                                            <a href="ModifierVehicule.jsp?matricule=<%= v.getMatricule() %>" title="Modifier" class="text-yellow-500 hover:text-yellow-600 p-2 rounded-full hover:bg-yellow-50 transition duration-200"><i class="fas fa-edit"></i></a>
                                            <form action="VoitureServlet" method="post" onsubmit="return confirm('Supprimer ce véhicule ?')">
                                                <input type="hidden" name="action" value="supprimer">
                                                <input type="hidden" name="matricule" value="<%= v.getMatricule() %>">
                                                <button type="submit" title="Supprimer" class="text-red-500 hover:text-red-600 p-2 rounded-full hover:bg-red-50 transition duration-200"><i class="fas fa-trash"></i></button>

                                            </form>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Search Functionality
        document.getElementById('search').addEventListener('keyup', function() {
            var searchTerm = this.value.toLowerCase();
            var rows = document.querySelectorAll('tbody tr');
            rows.forEach(function(row) {
                var text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Sorting Functionality
        let sortDirection = {};
        function sortTable(colIndex) {
            const tbody = document.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            const isNumeric = colIndex === 3; // Kilometrage is numeric
            sortDirection[colIndex] = !sortDirection[colIndex]; // Toggle direction

            rows.sort((a, b) => {
                let aValue = a.cells[colIndex].textContent.trim();
                let bValue = b.cells[colIndex].textContent.trim();
                if (isNumeric) {
                    aValue = parseFloat(aValue) || 0;
                    bValue = parseFloat(bValue) || 0;
                    return sortDirection[colIndex] ? bValue - aValue : aValue - bValue;
                }
                return sortDirection[colIndex] ? 
                       bValue.localeCompare(aValue) : 
                       aValue.localeCompare(bValue);
            });

            rows.forEach(row => tbody.appendChild(row));

            // Update sort icons
            document.querySelectorAll('th i').forEach((icon, index) => {
                icon.className = 'fas fa-sort ml-1';
                if (index === colIndex) {
                    icon.className = sortDirection[colIndex] ? 
                                     'fas fa-sort-down ml-1' : 
                                     'fas fa-sort-up ml-1';
                }
            });
        }

        // Top Brands Calculation
        var brandCounts = {};
       // Top Brands Calculation
        document.addEventListener('DOMContentLoaded', function () {
            var brandCounts = {};
            document.querySelectorAll('tbody tr').forEach(function (row) {
                var brand = row.cells[1]?.textContent.trim(); // Ensure the cell exists
                if (brand) {
                    brandCounts[brand] = (brandCounts[brand] || 0) + 1;
                }
            });

            var sortedBrands = Object.entries(brandCounts)
                .sort((a, b) => b[1] - a[1]) // Sort by count in descending order
                .slice(0, 3) // Get the top 3 brands
                .map(item => `${item[0]} (${item[1]})`) // Format as "Brand (Count)"
                .join(', ');

            document.getElementById('top-brands').textContent = sortedBrands || 'Aucune donnée';
        });
    </script>
</body>
</html>