<%@ page import="java.util.List" %>
    <%@ page import="entity.Client" %>
        <%@ page import="doo.ClientDAO" %>
<%@ page import="doo.LocationDAO" %>
<%@ page import="entity.Location" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="fr">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Gérer les Clients | Location Voitures</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                                    }
                                }
                            }
                        }
                    </script>
                </head>

                <body class="bg-gray-50 min-h-screen">
                    <!-- Sidebar -->
                    <div class="flex">
                        <div class="fixed h-screen w-64 bg-primary-800 text-white shadow-lg">
                            <div class="p-5 border-b border-primary-700">
                                <h2 class="text-2xl font-bold">ELGarage</h2>
                                <p class="text-xs text-primary-300">Location de voitures</p>
                            </div>
                            <nav class="mt-6">
                                <a href="#"
                                    class="flex items-center py-3 pl-6 pr-4 bg-primary-700 border-l-4 border-white">
                                    <i class="fas fa-users mr-3"></i>
                                    <span>Clients</span>
                                </a>
                                <a href="GererVehicules.jsp"
                                    class="flex items-center py-3 pl-6 pr-4 hover:bg-primary-700 transition duration-200">
                                    <i class="fas fa-car mr-3"></i>
                                    <span>Véhicules</span>
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
                                        <p class="text-xs text-primary-300">admin@autogestion.com</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="ml-64 w-full">
                            <!-- Top Navigation -->
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
                                <!-- Breadcrumbs -->
                                <div class="flex items-center text-sm text-gray-500 mb-6">
                                    <a href="#" class="hover:text-primary-600">Accueil</a>
                                    <i class="fas fa-chevron-right mx-2 text-xs"></i>
                                    <span class="text-gray-700 font-medium">Clients</span>
                                </div>
                                <%ClientDAO clientDAO=new ClientDAO(); List<Client> clients = clientDAO.getAllClients();
                                    %>

                                    <!-- Stats Cards -->
                                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
                                        <div class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary-500">
                                            <div class="flex justify-between items-center">
                                                <div>
                                                    <p class="text-gray-500 text-sm">Total Clients</p>
                                                    <h3 class="text-3xl font-bold text-gray-800">
                                                        <%=clients.size()%>
                                                    </h3>
                                                </div>
                                                <div class="bg-primary-100 p-3 rounded-full">
                                                    <i class="fas fa-users text-primary-500 text-xl"></i>
                                                </div>
                                            </div>
                                            <!--   <p class="text-green-500 text-sm mt-4"><i class="fas fa-arrow-up mr-1"></i> +5% depuis le mois dernier</p>-->
                                        </div>
                                        <div class="bg-white rounded-lg shadow-md p-6 border-l-4 border-green-500">
                                            <div class="flex justify-between items-center">
                                                <div>
                                                    <p class="text-gray-500 text-sm">Clients actifs</p>
                                                    <h3 class="text-3xl font-bold text-gray-800">
                                                        <%=clients.size() - 3%>
                                                    </h3>
                                                </div>
                                                <div class="bg-green-100 p-3 rounded-full">
                                                    <i class="fas fa-user-check text-green-500 text-xl"></i>
                                                </div>
                                            </div>
                                            <!--<p class="text-green-500 text-sm mt-4"><i class="fas fa-arrow-up mr-1"></i> +8% depuis le mois dernier</p>-->
                                        </div>
                                        <div class="bg-white rounded-lg shadow-md p-6 border-l-4 border-yellow-500">
                                            <div class="flex justify-between items-center">
                                                <div>
                                                    <p class="text-gray-500 text-sm">Nouveaux clients</p>
                                                    <h3 class="text-3xl font-bold text-gray-800">
                                                        <%=clients.size()%>
                                                    </h3>
                                                </div>
                                                <div class="bg-yellow-100 p-3 rounded-full">
                                                    <i class="fas fa-user-plus text-yellow-500 text-xl"></i>
                                                </div>
                                            </div>
                                            <!--<p class="text-green-500 text-sm mt-4"><i class="fas fa-arrow-up mr-1"></i> +12% depuis le mois dernier</p>-->
                                        </div>
                                        <div class="bg-white rounded-lg shadow-md p-6 border-l-4 border-purple-500">
                                            <div class="flex justify-between items-center">
                                                <div>
                                                    <% LocationDAO d = new LocationDAO();List< Location>l= d.getAllLocations(); %>
                                                    <p class="text-gray-500 text-sm">Contrats actifs</p>
                                                    <h3 class="text-3xl font-bold text-gray-800"><% l.size();%></h3>
                                                </div>
                                                <div class="bg-purple-100 p-3 rounded-full">
                                                    <i class="fas fa-file-contract text-purple-500 text-xl"></i>
                                                </div>
                                            </div>
                                            <!--<p class="text-red-500 text-sm mt-4"><i class="fas fa-arrow-down mr-1"></i> -2% depuis le mois dernier</p>-->
                                        </div>
                                    </div>

                                    <!-- Main Card -->
                                    <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                                        <!-- Card Header -->
                                        <div class="bg-gray-50 px-6 py-4 border-b flex justify-between items-center">
                                            <h2 class="text-xl font-bold text-gray-800">Liste des Clients</h2>
                                            <a href="AjouterClient.jsp"
                                                class="bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded-lg transition duration-300 flex items-center">
                                                <i class="fas fa-plus mr-2"></i>
                                                Ajouter un Client
                                            </a>
                                        </div>

                                        <!-- Search and Filters -->
                                        <div class="p-6 border-b">
                                            <div class="flex flex-col md:flex-row gap-4">
                                                <div class="relative flex-grow">
                                                    <input type="text" id="search" placeholder="Rechercher un client..."
                                                        class="w-full px-4 py-2 pl-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500">
                                                    <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                                                </div>
                                                <div class="flex gap-4">
                                                    <select
                                                        class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 bg-white">
                                                        <option value="">Filtrer par...</option>
                                                        <option value="nom">Nom</option>
                                                        <option value="email">Email</option>
                                                        <option value="telephone">Téléphone</option>
                                                    </select>
                                                    <select
                                                        class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 bg-white">
                                                        <option value="10">10 par page</option>
                                                        <option value="25">25 par page</option>
                                                        <option value="50">50 par page</option>
                                                        <option value="100">100 par page</option>
                                                    </select>
                                                    <button
                                                        class="flex items-center px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50">
                                                        <i class="fas fa-file-export mr-2 text-gray-600"></i>
                                                        Exporter
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Table -->
                                        <div class="overflow-x-auto">
                                            <table class="min-w-full bg-white">
                                                <thead>
                                                    <tr class="bg-gray-100 text-gray-700 text-sm uppercase">
                                                        <th class="py-3 px-6 text-left font-semibold">
                                                            <div class="flex items-center">
                                                                NCIN
                                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                                            </div>
                                                        </th>
                                                        <th class="py-3 px-6 text-left font-semibold">
                                                            <div class="flex items-center">
                                                                Nom
                                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                                            </div>
                                                        </th>
                                                        <th class="py-3 px-6 text-left font-semibold">
                                                            <div class="flex items-center">
                                                                Prénom
                                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                                            </div>
                                                        </th>
                                                        <th class="py-3 px-6 text-left font-semibold">Téléphone</th>
                                                        <th class="py-3 px-6 text-left font-semibold">Adresse</th>
                                                        <th class="py-3 px-6 text-left font-semibold">Email</th>
                                                        <th class="py-3 px-6 text-center font-semibold">Statut</th>
                                                        <th class="py-3 px-6 text-center font-semibold">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="text-gray-600 text-sm">
                                                    <% for (Client c : clients) { %>
                                                        <tr
                                                            class="border-b border-gray-200 hover:bg-gray-50 transition duration-150">
                                                            <td
                                                                class="py-3 px-6 text-left whitespace-nowrap font-medium">
                                                                <%= c.getNcin() %>
                                                            </td>
                                                            <td class="py-3 px-6 text-left">
                                                                <%= c.getNom() %>
                                                            </td>
                                                            <td class="py-3 px-6 text-left">
                                                                <%= c.getPrenom() %>
                                                            </td>
                                                            <td class="py-3 px-6 text-left">
                                                                <a href="tel:<%= c.getNumTel() %>"
                                                                    class="text-primary-600 hover:text-primary-800 flex items-center">
                                                                    <i class="fas fa-phone mr-2 text-gray-400"></i>
                                                                    <%= c.getNumTel() %>
                                                                </a>
                                                            </td>
                                                            <td class="py-3 px-6 text-left">
                                                                <div class="flex items-center">
                                                                    <i
                                                                        class="fas fa-map-marker-alt mr-2 text-gray-400"></i>
                                                                    <%= c.getAdresse() %>
                                                                </div>
                                                            </td>
                                                            <td class="py-3 px-6 text-left">
                                                                <a href="mailto:<%= c.getEmail() %>"
                                                                    class="text-primary-600 hover:text-primary-800 flex items-center">
                                                                    <i class="fas fa-envelope mr-2 text-gray-400"></i>
                                                                    <%= c.getEmail() %>
                                                                </a>
                                                            </td>
                                                            <td class="py-3 px-6 text-center">
                                                                <span
                                                                    class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full">Actif</span>
                                                            </td>
                                                            <td class="py-3 px-6 text-center">
                                                                <div class="flex justify-center">

                                                                    <form action="modifier.jsp" method="get"
                                                                        class="mx-1">
                                                                        <input type="hidden" name="codeClient"
                                                                            value="<%= c.getCodeClient() %>">
                                                                        <button type="submit"
                                                                            class="text-yellow-500 hover:text-yellow-600 tooltip"
                                                                            title="Modifier">
                                                                            <i class="fas fa-edit"></i>
                                                                        </button>
                                                                    </form>
                                                                    <form action="ClientServlet" method="post"
                                                                        class="mx-1">
                                                                        <input type="hidden" name="action"
                                                                            value="supprimer">
                                                                        <input type="hidden" name="codeClient"
                                                                            value="<%= c.getCodeClient() %>">
                                                                        <button type="submit"
                                                                            onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client?')"
                                                                            class="text-red-500 hover:text-red-600 tooltip"
                                                                            title="Supprimer">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </form>
                                                                    <a href="AjouterLocation.jsp?codeClient=<%= c.getCodeClient() %>"
                                                                       class="text-blue-500 hover:text-blue-600 mx-1 tooltip"
                                                                       title="Créer contrat">
                                                                        <i class="fas fa-file-signature"></i>
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Pagination -->
                                        <div
                                            class="px-6 py-4 bg-gray-50 border-t flex flex-col sm:flex-row justify-between items-center">
                                            <span class="text-sm text-gray-600 mb-3 sm:mb-0">
                                                Affichage de <span class="font-medium">1</span> à <span
                                                    class="font-medium">
                                                    <%= clients.size() %>
                                                </span> sur <span class="font-medium">
                                                    <%= clients.size() %>
                                                </span> clients
                                            </span>
                                            <div class="flex">
                                                <button disabled
                                                    class="bg-gray-100 text-gray-400 px-3 py-1 rounded-l-lg border border-gray-300">
                                                    <i class="fas fa-chevron-left"></i>
                                                </button>
                                                <button
                                                    class="bg-primary-600 text-white px-3 py-1 border border-primary-600">1</button>
                                                <button
                                                    class="bg-white text-gray-700 px-3 py-1 hover:bg-gray-100 border border-gray-300">2</button>
                                                <button
                                                    class="bg-white text-gray-700 px-3 py-1 hover:bg-gray-100 border border-gray-300">3</button>
                                                <button
                                                    class="bg-white text-gray-700 px-3 py-1 rounded-r-lg hover:bg-gray-100 border border-gray-300">
                                                    <i class="fas fa-chevron-right"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <div class="mt-8 text-center text-gray-500 text-sm">
                                        <p>© 2025 AutoGestion Location Voitures - Tous droits réservés</p>
                                        <p class="mt-1">Version 2.4.1</p>
                                    </div>
                            </div>
                        </div>
                    </div>

                    <script>

                        document.addEventListener('DOMContentLoaded', function () {
                            const tooltips = document.querySelectorAll('.tooltip');
                            tooltips.forEach(function (tooltip) {
                                tooltip.addEventListener('mouseenter', function () {
                                    const title = this.getAttribute('title');
                                    this.setAttribute('data-tooltip', title);
                                    this.removeAttribute('title');

                                    const tooltipEl = document.createElement('div');
                                    tooltipEl.classList.add('tooltip-content');
                                    tooltipEl.innerHTML = title;
                                    tooltipEl.style.position = 'absolute';
                                    tooltipEl.style.background = 'rgba(0,0,0,0.8)';
                                    tooltipEl.style.color = 'white';
                                    tooltipEl.style.padding = '5px 10px';
                                    tooltipEl.style.borderRadius = '5px';
                                    tooltipEl.style.fontSize = '12px';
                                    tooltipEl.style.zIndex = '100';
                                    document.body.appendChild(tooltipEl);

                                    const rect = this.getBoundingClientRect();
                                    tooltipEl.style.top = (rect.top - tooltipEl.offsetHeight - 5) + 'px';
                                    tooltipEl.style.left = (rect.left + rect.width / 2 - tooltipEl.offsetWidth / 2) + 'px';

                                    this.addEventListener('mouseleave', function () {
                                        this.setAttribute('title', this.getAttribute('data-tooltip'));
                                        this.removeAttribute('data-tooltip');
                                        document.body.removeChild(tooltipEl);
                                    }, { once: true });
                                });
                            });
                        });
                    </script>
                </body>

                </html>