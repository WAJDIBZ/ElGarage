<%@ page import="java.util.*, entity.*, doo.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% HttpSession sess=request.getSession(); Object clientIdObj=sess.getAttribute("clientId"); String
            codeClient=clientIdObj !=null ? String.valueOf(clientIdObj) : null; if (codeClient==null) {
            response.sendRedirect("index.jsp"); return; } // Récupérer les rendez-vous du client RendezVousDAO
            rendezVousDAO=new RendezVousDAO(); List<RendezVous> rendezVousList =
            rendezVousDAO.getRendezVousByClientId(codeClient);

            // Récupérer les informations du client
            ClientDAO clientDAO = new ClientDAO();
            Client client = clientDAO.getClientById(codeClient);
            String clientName = client != null ? client.getNom() + " " + client.getPrenom() : "Client";

            // Récupérer les informations de location pour chaque rendez-vous
            LocationDAO locationDAO = new LocationDAO();
            %>

            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>ELGarage | Mes Rendez-vous</title>
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
                                        600: '#0284c7',
                                        700: '#0369a1',
                                        800: '#075985'
                                    }
                                }
                            }
                        }
                    }
                </script>
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

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
                        <div class="flex justify-between h-16">
                            <div class="flex items-center">
                                <a href="ClientDashboard.jsp" class="text-xl font-bold text-gray-800">ELGarage</a>
                            </div>
                            <div class="flex items-center">
                                <a href="ClientDashboard.jsp"
                                    class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                                    <i class="fas fa-arrow-left mr-2"></i> Retour au tableau de bord
                                </a>
                            </div>
                        </div>
                    </div>
                </header>

                <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    <!-- Welcome Banner -->
                    <div class="bg-gradient-to-r from-primary-600 to-primary-800 rounded-xl shadow-lg p-6 mb-8">
                        <div class="flex flex-col md:flex-row">
                            <div class="md:w-2/3 p-4">
                                <h1 class="text-3xl font-bold text-white mb-2">Mes Rendez-vous</h1>
                                <p class="text-primary-100 mb-6">Consultez et gérez tous vos rendez-vous avec notre
                                    équipe.</p>
                            </div>
                            <div class="hidden md:block md:w-1/3 relative">
                                <div class="relative h-full flex items-center justify-center p-6">
                                    <i class="fas fa-calendar-check text-white/50 text-9xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Liste des Rendez-vous -->
                    <div class="bg-white rounded-xl shadow-lg p-6 mb-6">
                        <div class="flex justify-between items-center mb-6">
                            <h2 class="text-2xl font-bold text-gray-800 flex items-center">
                                <i class="fas fa-calendar-alt mr-3 text-primary-600"></i>
                                Mes Rendez-vous
                            </h2>
                        </div>

                        <% if (rendezVousList !=null && !rendezVousList.isEmpty()) { %>
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                ID
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Date du Rendez-vous
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Téléphone
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Adresse
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                N° CIN
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Location ID
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <% for (RendezVous rv : rendezVousList) { %>
                                            <tr>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                    <%= rv.getId() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <%= rv.getRendezVousDate() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <%= rv.getPhone() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <%= rv.getAddress() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <%= rv.getNcin() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <%= rv.getLocationId() %>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                    <button onclick="confirmerAnnulation(<%= rv.getId() %>)"
                                                        class="text-red-600 hover:text-red-900">
                                                        <i class="fas fa-times-circle mr-1"></i> Annuler
                                                    </button>
                                                </td>
                                            </tr>
                                            <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <% } else { %>
                                <div class="text-center py-10">
                                    <i class="fas fa-calendar-times text-gray-300 text-5xl mb-4"></i>
                                    <p class="text-gray-500 text-lg">Vous n'avez aucun rendez-vous pour le moment.</p>
                                    <a href="ClientDashboard.jsp"
                                        class="mt-4 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700">
                                        <i class="fas fa-arrow-left mr-2"></i> Retour au tableau de bord
                                    </a>
                                </div>
                                <% } %>
                    </div>

                    <!-- Help Card -->
                    <div class="bg-primary-50 rounded-xl p-6 flex items-center justify-between">
                        <div>
                            <h3 class="text-lg font-semibold text-primary-800 mb-1">Besoin d'aide ?</h3>
                            <p class="text-primary-600">Notre équipe de service client est disponible pour vous aider.
                            </p>
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
                                <p class="text-gray-500">© 2025 ELGarage. Tous droits réservés.</p>
                            </div>
                            <div class="flex space-x-6">
                                <a href="#" class="text-gray-400 hover:text-gray-500">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a href="#" class="text-gray-400 hover:text-gray-500">
                                    <i class="fab fa-twitter"></i>
                                </a>
                                <a href="#" class="text-gray-400 hover:text-gray-500">
                                    <i class="fab fa-instagram"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Confirmation Modal -->
                <div id="confirmationModal"
                    class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                    <div class="bg-white rounded-lg p-6 w-96">
                        <h3 class="text-lg font-bold mb-4">Confirmer l'annulation</h3>
                        <p class="text-gray-600 mb-6">Êtes-vous sûr de vouloir annuler ce rendez-vous ?</p>
                        <div class="flex justify-end space-x-3">
                            <button onclick="fermerModal()"
                                class="px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50">
                                Annuler
                            </button>
                            <form id="annulationForm" method="post" action="RendezVousServlet">
                                <input type="hidden" id="rendezVousId" name="rendezVousId" value="">
                                <input type="hidden" name="action" value="annuler">
                                <button type="submit"
                                    class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">
                                    Confirmer
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <script>
                    function confirmerAnnulation(id) {
                        document.getElementById('rendezVousId').value = id;
                        document.getElementById('confirmationModal').classList.remove('hidden');
                    }

                    function fermerModal() {
                        document.getElementById('confirmationModal').classList.add('hidden');
                    }

                    // Format dates for better display
                    document.addEventListener('DOMContentLoaded', function () {
                        // Additional JavaScript can be added here if needed
                    });
                </script>
            </body>

            </html>