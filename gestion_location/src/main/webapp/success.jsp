<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="doo.LocationDAO" %>
        <% // Update location status when redirected from successful payment String
            locationIdParam=request.getParameter("locationId"); if(locationIdParam !=null && !locationIdParam.isEmpty())
            { try { int locationId=Integer.parseInt(locationIdParam); LocationDAO locationDAO=new LocationDAO(); //
            Update status to 'Confirmée' boolean updated=locationDAO.updateLocationStatus(locationId, "Confirmée" );
            if(updated) { System.out.println("Location " + locationId + " status updated to Confirmée"); } else {
            System.out.println("Failed to update location " + locationId + " status"); } } catch(Exception e) {
            System.out.println("Error updating location status: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang=" fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Paiement Réussi - ELGarage</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

                    body {
                        font-family: 'Inter', sans-serif;
                    }
                </style>
            </head>

            <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
                <div class="max-w-4xl mx-auto px-4 py-16">
                    <div class="bg-white rounded-2xl shadow-xl overflow-hidden">
                        <div class="bg-green-500 p-8 flex items-center justify-center">
                            <div class="bg-white rounded-full p-4">
                                <i class="fas fa-check-circle text-green-500 text-5xl"></i>
                            </div>
                        </div>

                        <div class="p-8 text-center">
                            <h1 class="text-3xl font-bold text-gray-800 mb-4">Paiement Réussi!</h1>
                            <p class="text-gray-600 text-lg mb-8">Votre paiement a été traité avec succès. Merci de
                                votre confiance!</p>

                            <div class="mb-8 bg-gray-50 rounded-lg p-6 max-w-md mx-auto">
                                <h2 class="text-xl font-semibold text-gray-700 mb-4">Détails de la transaction</h2>
                                <div class="flex justify-between py-2 border-b">
                                    <span class="text-gray-600">Statut:</span>
                                    <span class="font-medium text-green-600">Complété</span>
                                </div>
                                <div class="flex justify-between py-2 border-b">
                                    <span class="text-gray-600">Méthode:</span>
                                    <span class="font-medium">Stripe</span>
                                </div>
                            </div>

                            <div class="flex flex-col sm:flex-row justify-center gap-4">
                                <a href="ClientDashboard.jsp"
                                    class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-6 py-3 rounded-lg transition-colors duration-300 flex items-center justify-center">
                                    <i class="fas fa-home mr-2"></i>
                                    Retour au tableau de bord
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        Swal.fire({
                            title: 'Paiement réussi!',
                            text: 'Votre location a été confirmée.',
                            icon: 'success',
                            confirmButtonText: 'Continuer',
                            confirmButtonColor: '#4F46E5'
                        });
                    });
                </script>
            </body>

            </html>