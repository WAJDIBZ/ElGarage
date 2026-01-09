<%@ page import="doo.VoitureDAO" %>
  <%@ page import="entity.Voiture" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <% String matricule=request.getParameter("matricule"); VoitureDAO dao=new VoitureDAO(); Voiture
        v=dao.getVoitureByMatricule(matricule); %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>Modifier un Véhicule | ELGarage</title>
          <script src="https://cdn.tailwindcss.com"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/ScrollTrigger.min.js"></script>
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
                    },
                  },
                  animation: {
                    'fade-in': 'fadeIn 0.5s ease-in-out',
                    'slide-up': 'slideUp 0.6s ease-out',
                    'pulse-slow': 'pulse 3s infinite',
                  },
                  keyframes: {
                    fadeIn: {
                      '0%': { opacity: '0' },
                      '100%': { opacity: '1' },
                    },
                    slideUp: {
                      '0%': { transform: 'translateY(20px)', opacity: '0' },
                      '100%': { transform: 'translateY(0)', opacity: '1' },
                    },
                  },
                }
              }
            }
          </script>
          <style>
            .input-field {
              transition: all 0.3s ease;
            }

            .input-field:focus {
              transform: translateY(-2px);
              box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }

            .form-card {
              background: rgba(255, 255, 255, 0.9);
              backdrop-filter: blur(10px);
            }

            .gradient-bg {
              background: linear-gradient(135deg, #0ea5e9 0%, #3b82f6 100%);
            }

            .car-icon {
              filter: drop-shadow(0 4px 6px rgba(0, 0, 0, 0.1));
            }

            .progress-bar {
              height: 4px;
              width: 0%;
              background: linear-gradient(90deg, #0ea5e9, #3b82f6);
              position: fixed;
              top: 0;
              left: 0;
              z-index: 100;
            }

            @keyframes float {
              0% {
                transform: translateY(0px) rotate(0deg);
              }

              50% {
                transform: translateY(-10px) rotate(2deg);
              }

              100% {
                transform: translateY(0px) rotate(0deg);
              }
            }

            .float {
              animation: float 3s ease-in-out infinite;
            }

            .disabled-field {
              position: relative;
              overflow: hidden;
            }

            .disabled-field::after {
              content: '';
              position: absolute;
              top: 0;
              left: 0;
              right: 0;
              bottom: 0;
              background: repeating-linear-gradient(45deg,
                  rgba(0, 0, 0, 0.025),
                  rgba(0, 0, 0, 0.025) 10px,
                  rgba(0, 0, 0, 0.05) 10px,
                  rgba(0, 0, 0, 0.05) 20px);
              pointer-events: none;
            }

            .edit-highlight {
              position: relative;
            }

            .edit-highlight::before {
              content: '';
              position: absolute;
              inset: 0;
              border-radius: 0.5rem;
              padding: 2px;
              background: linear-gradient(135deg, #0ea5e9, #3b82f6);
              -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
              -webkit-mask-composite: xor;
              mask-composite: exclude;
              opacity: 0;
              transition: opacity 0.3s ease;
            }

            .edit-highlight:hover::before {
              opacity: 1;
            }
          </style>
        </head>

        <body class="bg-gray-50 min-h-screen flex items-center justify-center p-4 relative overflow-x-hidden">
          <!-- Progress bar -->
          <div class="progress-bar" id="progressBar"></div>

          <!-- Background elements -->
          <div class="absolute inset-0 overflow-hidden z-0">
            <div class="absolute top-20 -left-20 w-80 h-80 bg-primary-200 rounded-full opacity-20 blur-3xl"></div>
            <div class="absolute bottom-40 -right-20 w-96 h-96 bg-primary-300 rounded-full opacity-20 blur-3xl"></div>
            <div
              class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-full max-w-6xl h-px bg-gradient-to-r from-transparent via-primary-300 to-transparent opacity-30">
            </div>
          </div>

          <div class="w-full max-w-4xl z-10">
            <!-- Header with animated icon -->
            <div class="mb-6 text-center">
              <div class="inline-block float mb-4">
                <svg class="w-20 h-20 car-icon mx-auto" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                  fill="none" stroke="#0284c7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                  <path
                    d="M14 16H9m10 0h3v-3.15a1 1 0 0 0-.84-.99L16 11l-2.7-3.6a1 1 0 0 0-.8-.4H5.24a2 2 0 0 0-1.8 1.1l-.8 1.63A6 6 0 0 0 2 12.42V16h2">
                  </path>
                  <circle cx="6.5" cy="16.5" r="2.5"></circle>
                  <circle cx="16.5" cy="16.5" r="2.5"></circle>
                </svg>
              </div>
              <h1 class="text-4xl font-bold text-gray-800 tracking-tight">ELGarage</h1>
              <p class="text-primary-600 animate-pulse-slow">Gestion de flotte de véhicules</p>
            </div>

            <!-- Main form card -->
            <div class="form-card w-full rounded-2xl shadow-xl overflow-hidden">
              <!-- Form header -->
              <div class="gradient-bg p-6">
                <div class="flex items-center justify-between">
                  <div>
                    <h2 class="text-2xl md:text-3xl font-bold text-white flex items-center animate-fade-in">
                      <svg class="w-6 h-6 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                      </svg>
                      Modifier le Véhicule
                    </h2>
                    <p class="text-primary-100 mt-1 opacity-90">Matricule: <%= v.getMatricule() %>
                    </p>
                  </div>
                  <div class="bg-white/20 p-3 rounded-lg backdrop-blur-sm hidden md:block" id="vehicleTag">
                    <div class="text-white text-xs font-medium flex items-center">
                      <svg class="w-4 h-4 mr-1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2">
                        <rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect>
                        <path d="M8 8h8"></path>
                        <path d="M8 12h8"></path>
                        <path d="M8 16h2"></path>
                      </svg>
                      <%= v.getMarque() %>
                        <%= v.getModele() %>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Form body -->
              <div class="bg-white p-6 md:p-8">
                <form id="vehicleForm" action="VoitureServlet" method="post" class="animate-slide-up">
                  <input type="hidden" name="action" value="modifier" />
                  <input type="hidden" name="matricule" value="<%= v.getMatricule() %>" />

                  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Left column -->
                    <div class="space-y-6">
                      <div class="form-group" data-step="1">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Matricule</label>
                        <div class="relative disabled-field">
                          <input type="text" value="<%= v.getMatricule() %>" disabled
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg bg-gray-100 cursor-not-allowed" />
                          <div class="absolute left-3 top-3 text-gray-400">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect>
                              <path d="M8 8h8"></path>
                              <path d="M8 12h8"></path>
                              <path d="M8 16h2"></path>
                            </svg>
                          </div>
                          <div class="absolute right-3 top-3 text-gray-400">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <circle cx="12" cy="12" r="10"></circle>
                              <line x1="5.2" y1="5.2" x2="18.8" y2="18.8"></line>
                            </svg>
                          </div>
                        </div>
                        <p class="text-xs text-gray-500 mt-1">Identifiant unique (non modifiable)</p>
                      </div>

                      <div class="form-group edit-highlight" data-step="2">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Marque</label>
                        <div class="relative">
                          <input type="text" name="marque" value="<%= v.getMarque() %>" required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z">
                              </path>
                              <line x1="7" y1="7" x2="7.01" y2="7"></line>
                            </svg>
                          </div>
                        </div>
                      </div>

                      <div class="form-group edit-highlight" data-step="3">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Modèle</label>
                        <div class="relative">
                          <input type="text" name="modele" value="<%= v.getModele() %>" required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                              <circle cx="8.5" cy="8.5" r="1.5"></circle>
                              <polyline points="21 15 16 10 5 21"></polyline>
                            </svg>
                          </div>
                        </div>
                      </div>

                      <div class="form-group edit-highlight" data-step="4">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Type d'Énergie</label>
                        <div class="relative">
                          <select name="typeEnergie" required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none appearance-none">
                            <option value="Essence" <%="Essence" .equals(v.getTypeEnergie()) ? "selected" : "" %>
                              >Essence</option>
                            <option value="Diesel" <%="Diesel" .equals(v.getTypeEnergie()) ? "selected" : "" %>>Diesel
                            </option>
                            <option value="Électrique" <%="Électrique" .equals(v.getTypeEnergie()) ? "selected" : "" %>
                              >Électrique</option>
                            <option value="Hybride" <%="Hybride" .equals(v.getTypeEnergie()) ? "selected" : "" %>
                              >Hybride</option>
                            <option value="GPL" <%="GPL" .equals(v.getTypeEnergie()) ? "selected" : "" %>>GPL</option>
                            <option value="<%= v.getTypeEnergie() %>" <%=!("Essence".equals(v.getTypeEnergie())
                              || "Diesel" .equals(v.getTypeEnergie()) || "Électrique" .equals(v.getTypeEnergie())
                              || "Hybride" .equals(v.getTypeEnergie()) || "GPL" .equals(v.getTypeEnergie()))
                              ? "selected" : "" %>><%= v.getTypeEnergie() %>
                            </option>
                          </select>
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <path
                                d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z">
                              </path>
                            </svg>
                          </div>
                          <div class="absolute right-3 top-3 text-gray-400 pointer-events-none">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Right column -->
                    <div class="space-y-6">
                      <div class="form-group edit-highlight" data-step="5">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Kilométrage (km)</label>
                        <div class="relative">
                          <input type="number" name="kilometrage" value="<%= v.getKilometrage() %>" min="0" required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <circle cx="12" cy="12" r="10"></circle>
                              <path d="M16.2 7.8l-2 6.3-6.4 2.1 2-6.3z"></path>
                            </svg>
                          </div>
                        </div>
                      </div>

                      <div class="form-group edit-highlight" data-step="6">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Vitesse max (km/h)</label>
                        <div class="relative">
                          <input type="number" name="speed" value="<%= v.getSpeed() %>" min="0" required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <path
                                d="M12 2v4m0 12v4M4.93 4.93l2.83 2.83m8.48 8.48l2.83 2.83M2 12h4m12 0h4M4.93 19.07l2.83-2.83m8.48-8.48l2.83-2.83">
                              </path>
                            </svg>
                          </div>
                        </div>
                      </div>

                      <div class="form-group edit-highlight" data-step="7">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Accélération (0→100 km/h en
                          s)</label>
                        <div class="relative">
                          <input type="number" step="0.1" name="acceleration" value="<%= v.getAcceleration() %>" min="0"
                            required
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                            </svg>
                          </div>
                        </div>
                      </div>

                      <div class="form-group edit-highlight" data-step="8">
                        <label class="block text-sm font-medium text-gray-700 mb-1">URL Image</label>
                        <div class="relative">
                          <input type="text" name="image" value="<%= v.getImage() != null ? v.getImage() : "" %>"
                            class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none" />
                          <div class="absolute left-3 top-3 text-primary-500">
                            <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2">
                              <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                              <circle cx="8.5" cy="8.5" r="1.5"></circle>
                              <polyline points="21 15 16 10 5 21"></polyline>
                            </svg>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Form footer with changes summary -->
                  <div class="mt-8 border-t pt-6 border-gray-100">
                    <div class="bg-primary-50 p-4 rounded-lg mb-6">
                      <h3 class="font-medium text-primary-700 flex items-center">
                        <svg class="w-5 h-5 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2">
                          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                        </svg>
                        Résumé des modifications
                      </h3>
                      <p class="text-sm text-primary-600 mt-1" id="changesSummary">Aucune modification effectuée.</p>
                    </div>

                    <div class="flex flex-col sm:flex-row justify-between items-center">
                      <div class="text-xs text-gray-500 mb-4 sm:mb-0">
                        <div class="flex items-center">
                          <svg class="w-4 h-4 mr-1 text-primary-500" xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                          </svg>
                          Dernière mise à jour: <span id="lastUpdated"></span>
                        </div>
                      </div>
                      <div class="flex space-x-4">
                        <a href="GererVehicules.jsp"
                          class="px-5 py-3 border border-gray-300 rounded-lg text-gray-600 font-medium hover:bg-gray-50 transition-colors duration-300 flex items-center">
                          <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2">
                            <path d="M19 12H5M12 19l-7-7 7-7"></path>
                          </svg>
                          Annuler
                        </a>
                        <button type="submit" id="saveBtn"
                          class="px-6 py-3 bg-primary-600 rounded-lg text-white font-medium hover:bg-primary-700 transition-colors duration-300 flex items-center shadow-lg shadow-primary-500/30">
                          <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                            <polyline points="17 21 17 13 7 13 7 21"></polyline>
                            <polyline points="7 3 7 8 15 8"></polyline>
                          </svg>
                          Enregistrer
                        </button>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>

            <!-- Footer -->
            <div class="text-center mt-8 text-sm text-gray-500 animate-fade-in">
              <p>© 2025 ELGarage - Système de Gestion de Véhicules</p>
            </div>
          </div>

          <script>
            // Format date for last updated
            document.getElementById('lastUpdated').textContent = new Date().toLocaleDateString('fr-FR', {
              day: 'numeric',
              month: 'long',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit'
            });

            // Progress bar animation
            const progressBar = document.getElementById('progressBar');
            window.addEventListener('scroll', () => {
              const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
              const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
              const scrolled = (winScroll / height) * 100;
              progressBar.style.width = scrolled + '%';
            });

            // Ensure original values are correctly rendered in JavaScript
            const originalValues = {
              marque: "<%= v.getMarque() %>",
      modele: "<%= v.getModele() %> ",
      kilometrage: "<%= v.getKilometrage() %>",
              speed: "<%= v.getSpeed()  %>",
              acceleration: "<%= v.getAcceleration() %>",
              typeEnergie: "<%= v.getTypeEnergie()  %> ",
      image: "<%= v.getImage()  %> "
            };

            // Ensure the trackChanges function retrieves the correct values
            function trackChanges() {
              const changesSummary = document.getElementById('changesSummary');
              const changes = [];

              const marque = document.querySelector('input[name="marque"]').value.trim();
              console.log(marque);
              const modele = document.querySelector('input[name="modele"]').value.trim();
              const kilometrage = document.querySelector('input[name="kilometrage"]').value.trim();
              const speed = document.querySelector('input[name="speed"]').value.trim();
              const acceleration = document.querySelector('input[name="acceleration"]').value.trim();
              const typeEnergie = document.querySelector('select[name="typeEnergie"]').value.trim();
              const image = document.querySelector('input[name="image"]').value.trim();

              if (marque !== originalValues.marque) changes.push('Marque: '+ originalValues.marque+' → '+ marque);
              if (modele !== originalValues.modele) changes.push(`Modèle: "${originalValues.modele}" → "${modele}"`);
              if (kilometrage !== originalValues.kilometrage) changes.push(`Kilométrage: ${originalValues.kilometrage} → ${kilometrage} km`);
              if (speed !== originalValues.speed) changes.push(`Vitesse max: ${originalValues.speed} → ${speed} km/h`);
              if (acceleration !== originalValues.acceleration) changes.push(`Accélération: ${originalValues.acceleration} → ${acceleration} s`);
              if (typeEnergie !== originalValues.typeEnergie) changes.push(`Type d'énergie: "${originalValues.typeEnergie}" → "${typeEnergie}"`);
              if (image !== originalValues.image) changes.push(`URL de l'image modifiée`);

              if (changes.length === 0) {
                changesSummary.textContent = "Aucune modification effectuée.";
                document.getElementById('saveBtn').disabled = true;
                document.getElementById('saveBtn').classList.add('opacity-50');
              } else {
                changesSummary.innerHTML = changes.join('<br>');
                document.getElementById('saveBtn').disabled = false;
                document.getElementById('saveBtn').classList.remove('opacity-50');
              }
            }

            // Form animations
            document.addEventListener('DOMContentLoaded', () => {
              // Disable save button initially
              document.getElementById('saveBtn').disabled = true;
              document.getElementById('saveBtn').classList.add('opacity-50');

              // Add change listeners to all form fields
              const inputs = document.querySelectorAll('input:not([disabled]), select');
              inputs.forEach(input => {
                input.addEventListener('input', trackChanges);
                input.addEventListener('change', trackChanges);
              });
              // Initial call to set the summary
              trackChanges();
            });
          </script>
        </body>

        </html>