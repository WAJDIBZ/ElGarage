<%@ page import="doo.LocationDAO, entity.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="entity.Location" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));
  LocationDAO dao = new LocationDAO();
  Location l = dao.getLocationById(id);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <title>Modifier Location | ELGarage</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="p-6">
  <h1 class="text-2xl font-bold mb-4">Modifier la Location</h1>
  <form action="LocationServlet" method="post" class="space-y-4">
    <input type="hidden" name="action" value="modifier"/>
    <input type="hidden" name="id" value="<%=l.getId()%>"/>

    <div>
      <label class="block">Code Client</label>
      <input type="number" name="codeClient" value="<%=l.getCodeClient()%>" required class="border px-3 py-2 rounded w-1/3"/>
    </div>
    <div>
      <label class="block">Matricule Véhicule</label>
      <input type="text" name="matricule" value="<%=l.getMatricule()%>" required class="border px-3 py-2 rounded w-1/3"/>
    </div>
    <div class="flex gap-4">
      <div>
        <label class="block">Date Début</label>
        <input type="date" name="dateDebut" value="<%=l.getDateDebut()%>" required class="border px-3 py-2 rounded"/>
      </div>
      <div>
        <label class="block">Date Fin</label>
        <input type="date" name="dateFin" value="<%=l.getDateFin()%>" required class="border px-3 py-2 rounded"/>
      </div>
    </div>
    <div>
      <label class="block">Tarif (DT)</label>
      <input type="number" step="0.01" name="tarif" value="<%=l.getTarif()%>" required class="border px-3 py-2 rounded w-1/3"/>
    </div>
    <div>
      <label class="block">Statut</label>
      <select name="statut" class="border px-3 py-2 rounded w-1/3">
        <option<%= "En cours".equals(l.getStatut())?" selected":"" %>>En cours</option>
        <option<%= "Terminé".equals(l.getStatut())?" selected":"" %>>Terminé</option>
      </select>
    </div>
    <button type="submit" class="bg-primary-600 text-white px-6 py-2 rounded">Enregistrer</button>
    <a href="GererLocations.jsp" class="ml-4 text-gray-600">Annuler</a>
  </form>
</body>
</html>
