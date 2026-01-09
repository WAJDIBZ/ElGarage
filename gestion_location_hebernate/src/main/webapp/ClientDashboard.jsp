<%@ page import="java.util.*, entity.*, doo.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% HttpSession sess=request.getSession(); Object clientIdObj=sess.getAttribute("clientId"); String
            codeClient=clientIdObj !=null ? String.valueOf(clientIdObj) : null; if (codeClient==null) {
            response.sendRedirect("index.jsp"); return; } LocationDAO locDAO=new LocationDAO(); List<Location>
            historique = locDAO.getLocationsByClient(codeClient);
            VoitureDAO vdao = new VoitureDAO();
            List<String> marques = vdao.getAllMarques();
                String selectedMarque = request.getParameter("marque");
                String selectedModele = request.getParameter("modele");

                List<Voiture> voitures = vdao.rechercherVehiculesDisponibles(
                    selectedMarque, selectedModele,
                    request.getParameter("dateDebut"), request.getParameter("dateFin")
                    );



                    // Get client info for personalization
                    ClientDAO clientDAO = new ClientDAO();
                    Client client = clientDAO.getClientById(codeClient);
                    String clientName = client != null ? client.getNom() + " " + client.getPrenom() : "Client";
                    %>

                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>ELGarage | Espace Client</title>
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
                                        },
                                        fontFamily: {
                                            'sans': ['Inter', 'system-ui', 'sans-serif'],
                                        }
                                    }
                                }
                            }
                        </script>
                        <style>
                            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

                            .car-card:hover .car-img {
                                transform: scale(1.05);
                            }

                            .car-img {
                                transition: transform 0.3s ease-in-out;
                            }

                            .badge {
                                position: absolute;
                                top: 12px;
                                right: 12px;
                                padding: 4px 12px;
                                border-radius: 9999px;
                                font-size: 0.75rem;
                                font-weight: 600;
                                text-transform: uppercase;
                                letter-spacing: 0.05em;
                            }

                            .tooltip {
                                position: relative;
                                display: inline-block;
                            }

                            .tooltip .tooltip-text {
                                visibility: hidden;
                                width: 120px;
                                background-color: rgba(0, 0, 0, 0.8);
                                color: #fff;
                                text-align: center;
                                border-radius: 6px;
                                padding: 5px;
                                position: absolute;
                                z-index: 1;
                                bottom: 125%;
                                left: 50%;
                                margin-left: -60px;
                                opacity: 0;
                                transition: opacity 0.3s;
                            }

                            .tooltip:hover .tooltip-text {
                                visibility: visible;
                                opacity: 1;
                            }

                            /* Table alternating rows */
                            tbody tr:nth-child(even) {
                                background-color: #f9fafb;
                            }
                        </style>
                    </head>

                    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen font-sans">
                        <!-- Top Navigation Bar -->
                        <header class="bg-white shadow-md">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                                <div class="flex justify-between items-center py-4">
                                    <div class="flex items-center">
                                        <h1 class="text-2xl font-bold text-primary-800">
                                            <i class="fas fa-car-side mr-2"></i>ELGarage
                                        </h1>
                                    </div>
                                    <div class="flex items-center space-x-4">
                                        <div class="hidden md:flex items-center">
                                            <i class="fas fa-user-circle text-gray-500 text-2xl mr-2"></i>
                                            <span class="font-medium text-gray-700">
                                                <%= clientName %>
                                            </span>
                                        </div>
                                        <a href="LogoutServlet"
                                            class="flex items-center bg-red-50 text-red-600 px-4 py-2 rounded-lg hover:bg-red-100 transition">
                                            <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </header>

                        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                            <!-- Welcome Banner -->
                            <div
                                class="bg-gradient-to-r from-primary-700 to-primary-900 rounded-xl shadow-lg mb-8 overflow-hidden">
                                <div class="md:flex">
                                    <div class="p-8 md:w-2/3">
                                        <h1 class="text-3xl md:text-4xl font-extrabold text-white mb-2">Bienvenue, <%=
                                                clientName.split(" ")[0] %></h1>
                <p class=" text-primary-100 mb-6">Explorez notre sélection exclusive de véhicules et gérez vos
                                                locations en toute simplicité.</p>
                                                <div class="flex flex-wrap gap-3">
                                                    <div
                                                        class="bg-white/20 backdrop-blur rounded-lg p-3 flex items-center">
                                                        <i class="fas fa-history text-white mr-2"></i>
                                                        <div>
                                                            <p class="text-xs text-primary-100">Locations totales</p>
                                                            <p class="text-xl font-bold text-white">
                                                                <%= historique.size() %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div
                                                        class="bg-white/20 backdrop-blur rounded-lg p-3 flex items-center">
                                                        <i class="fas fa-car text-white mr-2"></i>
                                                        <div>
                                                            <p class="text-xs text-primary-100">Véhicules disponibles
                                                            </p>
                                                            <p class="text-xl font-bold text-white">
                                                                <%= voitures !=null ? voitures.size() : 0 %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                    </div>
                                    <div class="hidden md:block md:w-1/3 relative">
                                        <div class="absolute bottom-0 right-0 w-full h-full">
                                            <div
                                                class="absolute bottom-0 right-0 w-64 h-64 bg-primary-500 rounded-full filter blur-3xl opacity-20 -mr-20 -mb-20">
                                            </div>
                                            <div
                                                class="absolute top-0 right-12 w-40 h-40 bg-primary-200 rounded-full filter blur-3xl opacity-20">
                                            </div>
                                        </div>
                                        <div class="relative h-full flex items-center justify-center p-6">
                                            <i class="fas fa-car-side text-white/50 text-9xl"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Recherche de Véhicules - Section -->
                            <div class="mb-12">
                                <div class="flex justify-between items-center mb-6">
                                    <h2 class="text-2xl font-bold text-gray-800 flex items-center">
                                        <i class="fas fa-search text-primary-600 mr-2"></i>
                                        Recherche de Véhicules
                                    </h2>
                                    <span class="text-sm text-gray-500">
                                        <%= voitures !=null ? voitures.size() : 0 %> véhicules disponibles
                                    </span>
                                </div>

                                <!-- Formulaire de recherche -->
                                <form method="get" class="bg-white p-6 rounded-xl shadow-md mb-8">
                                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                                        <div>
                                            <label for="marque"
                                                class="block text-sm font-medium text-gray-700 mb-1">Marque</label>
                                            <div class="relative">
                                                <select id="marque" name="marque"
                                                    class="block w-full pl-3 pr-10 py-3 text-base border-gray-300 rounded-lg shadow-sm focus:ring-primary-500 focus:border-primary-500 appearance-none bg-white"
                                                    onchange="this.form.submit()">
                                                    <option value="">Toutes les marques</option>
                                                    <% for (String marque : marques) { %>
                                                        <option value="<%= marque %>" <%=marque.equals(selectedMarque)
                                                            ? "selected" : "" %>><%= marque %>
                                                        </option>
                                                        <% } %>
                                                </select>
                                                <div
                                                    class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                                    <i class="fas fa-chevron-down"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <label for="modele"
                                                class="block text-sm font-medium text-gray-700 mb-1">Modèle</label>
                                            <div class="relative">
                                                <select id="modele" name="modele"
                                                    class="block w-full pl-3 pr-10 py-3 text-base border-gray-300 rounded-lg shadow-sm focus:ring-primary-500 focus:border-primary-500 appearance-none bg-white">
                                                    <option value="">Tous les modèles</option>
                                                    <% if (selectedMarque !=null && !selectedMarque.isEmpty()) {
                                                        List<String> modeles = vdao.getModelesParMarque(selectedMarque);
                                                        for (String m : modeles) {
                                                        %>
                                                        <option value="<%= m %>" <%=m.equals(selectedModele)
                                                            ? "selected" : "" %>><%= m %>
                                                        </option>
                                                        <% }} %>
                                                </select>
                                                <div
                                                    class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                                    <i class="fas fa-chevron-down"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <label for="dateDebut"
                                                class="block text-sm font-medium text-gray-700 mb-1">Date de
                                                début</label>
                                            <div class="relative">
                                                <div
                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                    <i class="fas fa-calendar-alt text-gray-400"></i>
                                                </div>
                                                <input type="date" id="dateDebut" name="dateDebut"
                                                    class="block w-full pl-10 pr-3 py-3 text-base border-gray-300 rounded-lg shadow-sm focus:ring-primary-500 focus:border-primary-500"
                                                    value="<%= request.getParameter(" dateDebut") !=null ?
                                                    request.getParameter("dateDebut") : "" %>">
                                            </div>
                                        </div>

                                        <div>
                                            <label for="dateFin"
                                                class="block text-sm font-medium text-gray-700 mb-1">Date de fin</label>
                                            <div class="relative">
                                                <div
                                                    class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                    <i class="fas fa-calendar-alt text-gray-400"></i>
                                                </div>
                                                <input type="date" id="dateFin" name="dateFin"
                                                    class="block w-full pl-10 pr-3 py-3 text-base border-gray-300 rounded-lg shadow-sm focus:ring-primary-500 focus:border-primary-500"
                                                    value="<%= request.getParameter(" dateFin") !=null ?
                                                    request.getParameter("dateFin") : "" %>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-6">
                                        <button type="submit"
                                            class="w-full bg-primary-600 hover:bg-primary-700 text-white font-medium py-3 px-6 rounded-lg shadow-md hover:shadow-lg transition duration-300 flex items-center justify-center">
                                            <i class="fas fa-search mr-2"></i>
                                            Rechercher des véhicules disponibles
                                        </button>
                                    </div>
                                </form>

                                <!-- Résultats sous forme de cartes -->
                                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                                    <% if (voitures !=null && !voitures.isEmpty()) { for (Voiture v : voitures) { //
                                        Calculez des attributs promotionnels fictifs pour l'affichage boolean
                                        isNew=Math.random()> 0.7;
                                        boolean isPopular = Math.random() > 0.5;
                                        int reviewCount = (int)(Math.random() * 50) + 10;
                                        double rating = 3.5 + (Math.random() * 1.5);
                                        String formattedRating = String.format("%.1f", rating);

                                        // Déterminez les badges à afficher
                                        String badgeClass = isNew ? "bg-green-500 text-white" : (isPopular ?
                                        "bg-yellow-500 text-white" : "");
                                        String badgeText = isNew ? "Nouveau" : (isPopular ? "Populaire" : "");
                                        %>
                                        <div
                                            class="car-card bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition duration-300 relative">
                                            <% if (!badgeText.isEmpty()) { %>
                                                <div class="badge <%= badgeClass %>">
                                                    <%= badgeText %>
                                                </div>
                                                <% } %>

                                                    <div class="relative overflow-hidden h-52">
                                                        <img src="<%= v.getImage() %>"
                                                            alt="<%= v.getMarque() %> <%= v.getModele() %>"
                                                            class="car-img w-full h-full object-cover"
                                                            onerror="this.src='assets/img/car-placeholder.jpg'">
                                                        <div
                                                            class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4">
                                                            <div class="flex items-center text-white">
                                                                <div class="flex items-center">
                                                                    <% for (int i=1; i <=5; i++) { %>
                                                                        <i class="<%= i <= rating ? " fas" : "far" %>
                                                                            fa-star <%= i <=rating ? "text-yellow-400"
                                                                                : "text-gray-300" %> text-sm"></i>
                                                                        <% } %>
                                                                </div>
                                                                <span class="ml-2 text-sm">
                                                                    <%= formattedRating %> (<%= reviewCount %>)
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="p-6">
                                                        <div class="flex justify-between items-start mb-2">
                                                            <h3 class="text-xl font-bold text-gray-800">
                                                                <%= v.getMarque() %>
                                                                    <%= v.getModele() %>
                                                            </h3>
                                                            <div class="text-primary-600 font-bold text-xl">
                                                                <%= v.getTarif() %> DT
                                                                    <span
                                                                        class="text-xs text-gray-500 font-normal">/jour</span>
                                                            </div>
                                                        </div>

                                                        <div class="space-y-2 mb-4">
                                                            <div class="flex items-center text-gray-600 text-sm">
                                                                <i class="fas fa-id-card mr-2 text-primary-500"></i>
                                                                <span>Matricule: <%= v.getMatricule() %></span>
                                                            </div>

                                                            <div class="flex items-center text-gray-600 text-sm">
                                                                <i class="fas fa-car mr-2 text-primary-500"></i>
                                                                <span>Année: <%= 2019 + (int)(Math.random() * 5) %>
                                                                        </span>
                                                            </div>

                                                            <div class="flex items-center text-gray-600 text-sm">
                                                                <i class="fas fa-gas-pump mr-2 text-primary-500"></i>
                                                                <span>Carburant: <%= Math.random()> 0.5 ? "Diesel" :
                                                                        "Essence" %></span>
                                                            </div>
                                                        </div>

                                                        <div
                                                            class="flex items-center justify-between pt-4 border-t border-gray-100">
                                                            <div class="flex items-center space-x-2">
                                                                <div class="tooltip">
                                                                    <i class="fas fa-info-circle text-primary-500"></i>
                                                                    <span class="tooltip-text">Disponible aux dates
                                                                        sélectionnées</span>
                                                                </div>
                                                                <span class="flex items-center text-sm text-green-600">
                                                                    <i class="fas fa-check-circle mr-1"></i>
                                                                    Disponible
                                                                </span>
                                                            </div>
                                                            <form action="LocationServlet" method="post"
                                                                onsubmit="return fillReservationDates(this)">
                                                                <input type="hidden" name="action" value="ajouter">
                                                                <input type="hidden" name="codeClient"
                                                                    value="<%= codeClient %>">
                                                                <input type="hidden" name="matricule"
                                                                    value="<%= v.getMatricule() %>">
                                                                <input type="hidden" name="dateDebut" value="">
                                                                <input type="hidden" name="dateFin" value="">
                                                                <input type="hidden" name="tarif"
                                                                    value="<%= v.getTarif() %>">
                                                                <button
                                                                    class="bg-primary-600 hover:bg-primary-700 text-white font-medium px-4 py-2 rounded-lg shadow hover:shadow-md transition duration-200 flex items-center">
                                                                    <i class="fas fa-calendar-check mr-2"></i>
                                                                    Réserver
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                        </div>
                                        <% }} else { %>
                                            <div
                                                class="col-span-3 flex flex-col items-center justify-center py-12 px-4 bg-white rounded-xl shadow-md">
                                                <div class="text-gray-400 mb-4 text-7xl">
                                                    <i class="fas fa-car-side"></i>
                                                </div>
                                                <h3 class="text-xl font-medium text-gray-700 mb-2">Aucun véhicule trouvé
                                                </h3>
                                                <p class="text-gray-500 text-center max-w-md">
                                                    Aucune voiture ne correspond à vos critères actuels. Essayez
                                                    d'ajuster vos filtres ou vos dates pour voir plus d'options.
                                                </p>
                                            </div>
                                            <% } %>
                                </div>
                            </div>

                            <!-- Historique -->
                            <div class="bg-white rounded-xl shadow-lg p-6 mb-6">
                                <div class="flex justify-between items-center mb-6">
                                    <h2 class="text-2xl font-bold text-gray-800 flex items-center">
                                        <i class="fas fa-history text-primary-600 mr-2"></i>
                                        Historique de vos locations
                                    </h2>
                                    <span
                                        class="bg-primary-100 text-primary-800 py-1 px-3 rounded-full text-sm font-medium">
                                        <%= historique.size() %> locations
                                    </span>
                                </div>

                                <% if (historique !=null && !historique.isEmpty()) { %>
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200 rounded-lg overflow-hidden">
                                            <thead class="bg-gray-100">
                                                <tr>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        #</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Véhicule</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Période</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Montant</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Statut</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <% for (Location loc : historique) { String statusClass="" ; String
                                                    statusIcon="" ; switch(loc.getStatut().toLowerCase()) {
                                                    case "confirmée" : case "confirmee" :
                                                    statusClass="bg-green-100 text-green-800" ;
                                                    statusIcon="fa-check-circle" ; break; case "en attente" :
                                                    statusClass="bg-yellow-100 text-yellow-800" ; statusIcon="fa-clock"
                                                    ; break; case "terminée" : case "terminee" :
                                                    statusClass="bg-gray-100 text-gray-800" ;
                                                    statusIcon="fa-check-double" ; break; case "annulée" :
                                                    case "annulee" : statusClass="bg-red-100 text-red-800" ;
                                                    statusIcon="fa-times-circle" ; break; default:
                                                    statusClass="bg-blue-100 text-blue-800" ;
                                                    statusIcon="fa-info-circle" ; } %>
                                                    <tr class="hover:bg-gray-50">
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                            #<%= loc.getId() %>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                            <div class="flex items-center">
                                                                <i class="fas fa-car text-primary-500 mr-2"></i>
                                                                <%= loc.getMatricule() %>
                                                            </div>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                            <div class="flex items-center">
                                                                <i class="fas fa-calendar text-gray-400 mr-2"></i>
                                                                <span>
                                                                    <%= loc.getDateDebut() %> → <%= loc.getDateFin() %>
                                                                </span>
                                                            </div>
                                                        </td>
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                            <%= loc.getMontant() %> DT
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <span
                                                                class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full <%= statusClass %>">
                                                                <i class="fas <%= statusIcon %> mr-1"></i>
                                                                <%= loc.getStatut() %>
                                                            </span>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm">
                                                            <div class="flex justify-end space-x-2">
                                                                <button class="text-primary-600 hover:text-primary-800"
                                                                    title="Voir détails">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                                <% if (loc.getStatut().equalsIgnoreCase("en attente")) {
                                                                    %>
                                                                    <button class="text-red-600 hover:text-red-800"
                                                                        title="Annuler">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                    <% } %>
                                                                        <% if
                                                                            (loc.getStatut().equalsIgnoreCase("terminée")
                                                                            ||
                                                                            loc.getStatut().equalsIgnoreCase("terminee"))
                                                                            { %>
                                                                            <button
                                                                                class="text-yellow-600 hover:text-yellow-800"
                                                                                title="Évaluer">
                                                                                <i class="fas fa-star"></i>
                                                                            </button>
                                                                            <% } %>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <% } else { %>
                                        <div class="flex flex-col items-center justify-center py-12">
                                            <div class="text-gray-400 mb-4 text-5xl">
                                                <i class="fas fa-calendar-times"></i>
                                            </div>
                                            <h3 class="text-xl font-medium text-gray-700 mb-2">Aucun historique de
                                                location</h3>
                                            <p class="text-gray-500 text-center max-w-md">
                                                Vous n'avez pas encore effectué de location. Trouvez un véhicule qui
                                                vous convient et réservez-le dès maintenant !
                                            </p>
                                        </div>
                                        <% } %>
                            </div>

                            <!-- Help Card -->
                            <div class="bg-primary-50 rounded-xl p-6 flex items-center justify-between">
                                <div>
                                    <h3 class="text-lg font-semibold text-primary-800 mb-1">Besoin d'aide ?</h3>
                                    <p class="text-primary-600">Notre équipe de service client est disponible pour vous
                                        aider.</p>
                                </div>
                                <button
                                    class="bg-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg shadow flex items-center">
                                    <i class="fas fa-headset mr-2"></i>
                                    Contactez-nous
                                </button>
                            </div>
                        </main>

                        <!-- Footer -->
                        <footer class="bg-white mt-12 py-8 border-t border-gray-200">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                                <div class="flex flex-col md:flex-row justify-between items-center">
                                    <div class="mb-4 md:mb-0">
                                        <p class="text-gray-600 text-sm">© 2025 ELGarage. Tous droits réservés.</p>
                                    </div>
                                    <div class="flex space-x-6">
                                        <a href="#" class="text-gray-500 hover:text-primary-600">
                                            <i class="fab fa-facebook-f"></i>
                                        </a>
                                        <a href="#" class="text-gray-500 hover:text-primary-600">
                                            <i class="fab fa-twitter"></i>
                                        </a>
                                        <a href="#" class="text-gray-500 hover:text-primary-600">
                                            <i class="fab fa-instagram"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </footer>

                        <script>
                            // Format dates for better display
                            document.addEventListener('DOMContentLoaded', function () {
                                // Additional JavaScript can be added here if needed
                            });
                        </script>
                    </body>

                    <!-- Modal réservation (choix dates) -->
                    <div id="reservationModal"
                        class="fixed inset-0 bg-black/50 hidden items-center justify-center p-4 z-50">
                        <div class="bg-white w-full max-w-md rounded-xl shadow-xl p-6">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-lg font-bold text-gray-800">Choisir les dates</h3>
                                <button type="button" onclick="closeReservationModal()"
                                    class="text-gray-500 hover:text-gray-700">✕</button>
                            </div>

                            <div class="space-y-4">
                                <div>
                                    <label for="resDateDebut" class="block text-sm font-medium text-gray-700 mb-1">Date
                                        de début</label>
                                    <input type="date" id="resDateDebut"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2">
                                </div>
                                <div>
                                    <label for="resDateFin" class="block text-sm font-medium text-gray-700 mb-1">Date de
                                        fin</label>
                                    <input type="date" id="resDateFin"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2">
                                </div>
                            </div>

                            <div class="mt-6 flex gap-3 justify-end">
                                <button type="button" onclick="closeReservationModal()"
                                    class="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50">Annuler</button>
                                <button type="button" onclick="confirmReservationDates()"
                                    class="px-4 py-2 rounded-lg bg-primary-600 text-white hover:bg-primary-700">Confirmer</button>
                            </div>
                        </div>
                    </div>

                    <script>
                        let pendingReservationForm = null;

                        function openReservationModal(prefillDebut, prefillFin) {
                            const modal = document.getElementById('reservationModal');
                            const d1 = document.getElementById('resDateDebut');
                            const d2 = document.getElementById('resDateFin');

                            d1.value = prefillDebut || '';
                            d2.value = prefillFin || '';

                            modal.classList.remove('hidden');
                            modal.classList.add('flex');
                            d1.focus();
                        }

                        function closeReservationModal() {
                            const modal = document.getElementById('reservationModal');
                            modal.classList.add('hidden');
                            modal.classList.remove('flex');
                            pendingReservationForm = null;
                        }

                        function confirmReservationDates() {
                            if (!pendingReservationForm) {
                                closeReservationModal();
                                return;
                            }

                            const dateDebut = document.getElementById('resDateDebut').value;
                            const dateFin = document.getElementById('resDateFin').value;

                            if (!dateDebut || !dateFin) {
                                alert('Veuillez choisir une date de début et une date de fin.');
                                return;
                            }
                            if (new Date(dateFin) < new Date(dateDebut)) {
                                alert('La date de fin doit être après la date de début.');
                                return;
                            }

                            const hiddenDebut = pendingReservationForm.querySelector('input[name="dateDebut"]');
                            const hiddenFin = pendingReservationForm.querySelector('input[name="dateFin"]');
                            if (hiddenDebut) hiddenDebut.value = dateDebut;
                            if (hiddenFin) hiddenFin.value = dateFin;

                            pendingReservationForm.submit();
                            closeReservationModal();
                        }

                        function fillReservationDates(form) {
                            const dateDebutInput = document.getElementById('dateDebut');
                            const dateFinInput = document.getElementById('dateFin');
                            const dateDebut = dateDebutInput ? dateDebutInput.value : '';
                            const dateFin = dateFinInput ? dateFinInput.value : '';

                            if (dateDebut && dateFin) {
                                if (new Date(dateFin) < new Date(dateDebut)) {
                                    alert('La date de fin doit être après la date de début.');
                                    return false;
                                }
                                const hiddenDebut = form.querySelector('input[name="dateDebut"]');
                                const hiddenFin = form.querySelector('input[name="dateFin"]');
                                if (hiddenDebut) hiddenDebut.value = dateDebut;
                                if (hiddenFin) hiddenFin.value = dateFin;
                                return true;
                            }

                            pendingReservationForm = form;
                            openReservationModal(dateDebut, dateFin);
                            return false;
                        }
                    </script>

                    </html>