<%@ page import="java.util.List" %>
<%@ page import="doo.LocationDAO" %>
<%@ page import="entity.Location" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gérer les Locations | ELGarage</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        <a href="#" class="flex items-center py-3 pl-6 pr-4 bg-primary-700 border-l-4 border-white">
          <i class="fas fa-calendar-check mr-3"></i><span>Locations</span>
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

      <!-- Content -->
      <div class="container mx-auto p-6">
        <div class="flex items-center text-sm text-gray-500 mb-6">
          <a href="#" class="hover:text-primary-600">Accueil</a>
          <i class="fas fa-chevron-right mx-2 text-xs"></i>
          <span class="text-gray-700 font-medium">Locations</span>
        </div>

        <% 
          LocationDAO dao = new LocationDAO();
          List<Location> locations = dao.getAllLocations();
        %>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-primary-500 hover:scale-105 transition">
            <p class="text-gray-500 text-sm">Total Locations</p>
            <h3 class="text-3xl font-bold text-gray-800"><%= locations.size() %></h3>
          </div>
          <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-primary-500 hover:scale-105 transition">
            <p class="text-gray-500 text-sm">Locations en Cours</p>
            <h3 class="text-3xl font-bold text-gray-800">
              <%= locations.stream().filter(l->"En cours".equals(l.getStatut())).count() %>
            </h3>
          </div>
        </div>

        <!-- Table card -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
          <div class="bg-gray-50 px-6 py-4 border-b flex flex-col md:flex-row md:justify-between md:items-center gap-4">
            <h2 class="text-xl font-bold text-gray-800">Liste des Locations</h2>
            <div class="flex gap-2 w-full md:w-auto">
              <input type="text" id="search" placeholder="Rechercher..." 
                     class="flex-1 border border-gray-300 rounded-md px-3 py-2 focus:ring-primary-500 focus:border-primary-500">
              <a href="AjouterLocation.jsp" 
                 class="bg-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded shadow">
                <i class="fas fa-plus mr-1"></i>Nouvelle
              </a>
            </div>
          </div>
          <div class="max-h-[500px] overflow-auto">
            <table class="min-w-full bg-white">
              <thead>
                <tr class="bg-gray-100 text-gray-700 text-sm uppercase">
                  <th class="py-3 px-6 text-left sticky">#</th>
                  <th class="py-3 px-6 text-left sticky cursor-pointer" onclick="sortTable(1)">Client <i class="fas fa-sort ml-1"></i></th>
                  <th class="py-3 px-6 text-left sticky">Véhicule</th>
                  <th class="py-3 px-6 text-left sticky cursor-pointer" onclick="sortTable(3)">Début <i class="fas fa-sort ml-1"></i></th>
                  <th class="py-3 px-6 text-left sticky cursor-pointer" onclick="sortTable(4)">Fin <i class="fas fa-sort ml-1"></i></th>
                  <th class="py-3 px-6 text-left sticky cursor-pointer" onclick="sortTable(5)">Tarif (DT) <i class="fas fa-sort ml-1"></i></th>
                  <th class="py-3 px-6 text-center sticky">Statut</th>
                  <th class="py-3 px-6 text-center sticky">Actions</th>
                </tr>
              </thead>
              <tbody class="text-gray-600 text-sm">
                <% for (Location l : locations) { %>
                  <tr class="odd:bg-white even:bg-gray-50 hover:bg-gray-100 transition">
                    <td class="py-3 px-6"><%= l.getId() %></td>
                    <td class="py-3 px-6"><%= l.getCodeClient() %></td>
                    <td class="py-3 px-6"><%= l.getMatricule() %></td>
                    <td class="py-3 px-6"><%= l.getDateDebut() %></td>
                    <td class="py-3 px-6"><%= l.getDateFin() %></td>
                    <td class="py-3 px-6"><%= String.format("%.2f", l.getMontant()) %> DT</td>
                    <td class="py-3 px-6 text-center">
                      <span class="<%= "En cours".equals(l.getStatut()) 
                         ? "bg-yellow-100 text-yellow-800" 
                         : "bg-green-100 text-green-800" %> text-xs font-medium px-2.5 py-0.5 rounded-full">
                        <%= l.getStatut() %>
                      </span>
                    </td>
                    <td class="py-3 px-6 text-center flex justify-center space-x-2">
<%--                      <a href="ModifierLocation.jsp?id=<%=l.getId()%>" --%>
<%--                         class="text-yellow-500 hover:text-yellow-600 p-2 rounded-full hover:bg-yellow-50">--%>
<%--                        <i class="fas fa-edit"></i>--%>
<%--                      </a>--%>
                      <form action="LocationServlet" method="post" onsubmit="return confirm('Supprimer cette location ?')" class="inline">
                        <input type="hidden" name="action" value="supprimer">
                        <input type="hidden" name="id" value="<%=l.getId()%>">
                        <button type="submit" class="text-red-500 hover:text-red-600 p-2 rounded-full hover:bg-red-50">
                          <i class="fas fa-trash"></i>
                        </button>
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

      document.getElementById("tarif").addEventListener("input", function () {
      const value = this.value.replace(/[^0-9.]/g, ""); // Allow only numbers and dots
      this.value = value;
    });

  // Search
  document.getElementById('search').addEventListener('keyup', function() {
  const term = this.value.toLowerCase();
  document.querySelectorAll('tbody tr').forEach(row => {
  row.style.display = row.textContent.toLowerCase().includes(term) ? '' : 'none';
      });
    });

    // Sort
    let dir = {};
    function sortTable(col) {
      const tbody = document.querySelector('tbody');
      const rows = Array.from(tbody.rows);
      dir[col] = !dir[col];
      rows.sort((a,b) => {
        let x = a.cells[col].textContent.trim();
        let y = b.cells[col].textContent.trim();
        return dir[col] ? y.localeCompare(x) : x.localeCompare(y);
      });
      rows.forEach(r=>tbody.appendChild(r));
      document.querySelectorAll('th i').forEach((i,idx)=>{
        i.className = idx===col 
          ? dir[col] ? 'fas fa-sort-down ml-1' : 'fas fa-sort-up ml-1'
          : 'fas fa-sort ml-1';
      });
    }
  </script>
</body>
</html>
