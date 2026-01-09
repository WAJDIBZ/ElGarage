<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Paiement Annulé - ELGarage</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                <div class="bg-red-500 p-8 flex items-center justify-center">
                    <div class="bg-white rounded-full p-4">
                        <i class="fas fa-times-circle text-red-500 text-5xl"></i>
                    </div>
                </div>

                <div class="p-8 text-center">
                    <h1 class="text-3xl font-bold text-gray-800 mb-4">Paiement Annulé</h1>
                    <p class="text-gray-600 text-lg mb-8">Votre paiement a été annulé. Aucun montant n'a été prélevé.
                    </p>

                    <div class="mb-8 bg-gray-50 rounded-lg p-6 max-w-md mx-auto">
                        <h2 class="text-lg font-semibold text-gray-700 mb-4">Que souhaitez-vous faire?</h2>
                        <ul class="text-left space-y-2 text-gray-600">
                            <li class="flex items-start">
                                <i class="fas fa-arrow-right text-red-500 mt-1 mr-2"></i>
                                <span>Réessayer le paiement</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-arrow-right text-red-500 mt-1 mr-2"></i>
                                <span>Choisir une autre méthode de paiement</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-arrow-right text-red-500 mt-1 mr-2"></i>
                                <span>Retourner au tableau de bord</span>
                            </li>
                        </ul>
                    </div>

                    <div class="flex flex-col sm:flex-row justify-center gap-4">
                        <a href="ClientDashboard.jsp"
                            class="bg-red-600 hover:bg-red-700 text-white font-medium px-6 py-3 rounded-lg transition-colors duration-300 flex items-center justify-center">
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
                    title: 'Paiement annulé',
                    text: 'Votre paiement a été annulé. Aucun montant n\'a été prélevé.',
                    icon: 'warning',
                    confirmButtonText: 'Continuer',
                    confirmButtonColor: '#EF4444'
                });
            });
        </script>
    </body>

    </html>