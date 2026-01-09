<%@ page import="java.util.List" %>
  <%@ page import="entity.Voiture" %>
    <%@ page import="java.util.Collections" %>
      <% List<Voiture> dispo = (List<Voiture>) request.getAttribute("dispo");
          if (dispo == null) {
          dispo = Collections.emptyList();
          }
          %>
          <label class="block text-gray-700 mb-1">Vehicule disponible</label>
          <select name="matricule" required class="w-full border px-3 py-2 rounded">
            <% if (dispo==null || dispo.isEmpty()) { %>
              <option value="">-- Aucun vehicule disponible pour le moment --</option>
              <% } %>
                <% if (dispo !=null && !dispo.isEmpty()) { %>
                  <option value="">-- Choisir un vehicule --</option>
                  <% } %>
                    <% for (Voiture v : dispo) { %>
                      <option value="<%= v.getMatricule() %>">
                        <%= v.getMarque() %>
                          <%= v.getModele() %> (Matricule <%= v.getMatricule() %>)
                      </option>
                      <% } %>
          </select>