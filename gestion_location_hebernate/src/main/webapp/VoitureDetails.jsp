<%@ page import="doo.VoitureDAO, entity.Voiture" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String matricule = request.getParameter("matricule");
    if (matricule == null) {
        response.sendRedirect("GererVehicules.jsp");
        return;
    }
    VoitureDAO dao = new VoitureDAO();
    Voiture v = dao.getVoitureByMatricule(matricule);
    if (v == null) {
        response.sendRedirect("GererVehicules.jsp?error=notfound");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Détails – <%= v.getMarque() %> <%= v.getModele() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="max-w-4xl mx-auto my-10 bg-white rounded-lg shadow-lg overflow-hidden">
    <!-- Image Principale -->
    <div class="h-64 md:h-96 overflow-hidden">
        <img src="<%= v.getImage() %>" alt="Photo de <%= v.getMarque() %> <%= v.getModele() %>"
             class="w-full h-full object-cover">
    </div>

    <!-- Contenu -->
    <div class="p-6">
        <!-- Titre -->
        <h1 class="text-3xl font-bold mb-2"><%= v.getMarque() %> <%= v.getModele() %></h1>
        <p class="text-gray-600 mb-6">Matricule : <span class="font-medium"><%= v.getMatricule() %></span></p>

        <!-- Caractéristiques -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
            <div class="bg-gray-50 p-4 rounded">
                <h2 class="font-semibold mb-1">Kilométrage</h2>
                <p><%= v.getKilometrage() %> km</p>
            </div>
            <div class="bg-gray-50 p-4 rounded">
                <h2 class="font-semibold mb-1">Vitesse Max</h2>
                <p><%= v.getSpeed() %> km/h</p>
            </div>
            <div class="bg-gray-50 p-4 rounded">
                <h2 class="font-semibold mb-1">Accélération</h2>
                <p>0–100 km/h en <%= v.getAcceleration() %> s</p>
            </div>
            <div class="bg-gray-50 p-4 rounded">
                <h2 class="font-semibold mb-1">Énergie</h2>
                <p><%= v.getTypeEnergie() %></p>
            </div>
        </div>

        <!-- Tarif et action -->
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div class="text-2xl font-bold text-primary-600">
                Tarif : <%= String.format("%.2f", v.getTarif()) %> DT/jour
            </div>
            <div class="space-x-4">
                <a href="GererVehicules.jsp"
                   class="px-4 py-2 border rounded hover:bg-gray-100">← Retour à la liste</a>
                <a href="AjouterLocation.jsp?matricule=<%= v.getMatricule() %>"
                   class="bg-primary-600 text-white px-4 py-2 rounded hover:bg-primary-700">
                    Réserver ce véhicule
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
