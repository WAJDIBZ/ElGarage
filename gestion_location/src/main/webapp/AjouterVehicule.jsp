<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Ajouter un Véhicule | ELGarage</title>
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
      0% { transform: translateY(0px); }
      50% { transform: translateY(-10px); }
      100% { transform: translateY(0px); }
    }
    .float {
      animation: float 3s ease-in-out infinite;
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
    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-full max-w-6xl h-px bg-gradient-to-r from-transparent via-primary-300 to-transparent opacity-30"></div>
  </div>

  <div class="w-full max-w-4xl z-10">
    <!-- Header with animated icon -->
    <div class="mb-6 text-center">
      <div class="inline-block float mb-4">
        <svg class="w-20 h-20 car-icon mx-auto" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#0284c7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M14 16H9m10 0h3v-3.15a1 1 0 0 0-.84-.99L16 11l-2.7-3.6a1 1 0 0 0-.8-.4H5.24a2 2 0 0 0-1.8 1.1l-.8 1.63A6 6 0 0 0 2 12.42V16h2"></path>
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
        <h2 class="text-2xl md:text-3xl font-bold text-white flex items-center animate-fade-in">
          <svg class="w-6 h-6 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M12 4v16m-8-8h16"></path>
          </svg>
          Ajouter un Véhicule
        </h2>
        <p class="text-primary-100 mt-1 opacity-90">Entrez les détails du nouveau véhicule</p>
      </div>

      <!-- Form body -->
      <div class="bg-white p-6 md:p-8">
        <form id="vehicleForm" action="VoitureServlet" method="post" class="animate-slide-up">
          <input type="hidden" name="action" value="ajouter"/>
          <input type="hidden" id="matricule" name="matricule" value="">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Left column -->
            <div class="space-y-6">
              <div class="form-group" data-step="1">
                <label class="block text-sm font-medium text-gray-700 mb-1">Matricule</label>
                <div class="relative">
                  <input type="text" name="matricule" required id="displayMatricule" readonly
                         class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect>
                      <path d="M8 8h8"></path>
                      <path d="M8 12h8"></path>
                      <path d="M8 16h2"></path>
                    </svg>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>


              <div class="form-group" data-step="2">
                <label class="block text-sm font-medium text-gray-700 mb-1">Marque</label>
                <div class="relative">
                  <input type="text" name="marque" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
                      <line x1="7" y1="7" x2="7.01" y2="7"></line>
                    </svg>
                  </div>
                </div>
              </div>

              <div class="form-group" data-step="3">
                <label class="block text-sm font-medium text-gray-700 mb-1">Modèle</label>
                <div class="relative">
                  <input type="text" name="modele" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                      <circle cx="8.5" cy="8.5" r="1.5"></circle>
                      <polyline points="21 15 16 10 5 21"></polyline>
                    </svg>
                  </div>
                </div>
              </div>

              <div class="form-group" data-step="4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Type d'Énergie</label>
                <div class="relative">
                  <select name="typeEnergie" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none appearance-none">
                    <option value="">Sélectionner</option>
                    <option value="Essence">Essence</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Électrique">Électrique</option>
                    <option value="Hybride">Hybride</option>
                    <option value="GPL">GPL</option>
                  </select>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"></path>
                    </svg>
                  </div>
                  <div class="absolute right-3 top-3 text-gray-400 pointer-events-none">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <polyline points="6 9 12 15 18 9"></polyline>
                    </svg>
                  </div>
                </div>
              </div>
            </div>

            <!-- Right column -->
            <div class="space-y-6">
              <div class="form-group" data-step="5">
                <label class="block text-sm font-medium text-gray-700 mb-1">Kilométrage (km)</label>
                <div class="relative">
                  <input type="number" name="kilometrage" min="0" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <circle cx="12" cy="12" r="10"></circle>
                      <path d="M16.2 7.8l-2 6.3-6.4 2.1 2-6.3z"></path>
                    </svg>
                  </div>
                </div>
              </div>

              <div class="form-group" data-step="6">
                <label class="block text-sm font-medium text-gray-700 mb-1">Vitesse max (km/h)</label>
                <div class="relative">
                  <input type="number" name="speed" min="0" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M12 2v4m0 12v4M4.93 4.93l2.83 2.83m8.48 8.48l2.83 2.83M2 12h4m12 0h4M4.93 19.07l2.83-2.83m8.48-8.48l2.83-2.83"></path>
                    </svg>
                  </div>
                </div>
              </div>

              <div class="form-group" data-step="7">
                <label class="block text-sm font-medium text-gray-700 mb-1">Accélération (0→100 km/h en s)</label>
                <div class="relative">
                  <input type="number" step="0.1" name="acceleration" min="0" required
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                    </svg>
                  </div>
                </div>
              </div>

              <div class="form-group" data-step="8">
                <label class="block text-sm font-medium text-gray-700 mb-1">URL Image</label>
                <div class="relative">
                  <input type="text" name="image"
                    class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
                  <div class="absolute left-3 top-3 text-primary-500">
                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                      <circle cx="8.5" cy="8.5" r="1.5"></circle>
                      <polyline points="21 15 16 10 5 21"></polyline>
                    </svg>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group" data-step="9">
            <label class="block text-sm font-medium text-gray-700 mb-1">Tarif (par jour)</label>
            <div class="relative">
              <input type="number" step="0.01" name="tarif" min="0" required
                     class="input-field w-full border border-gray-300 pl-10 pr-3 py-3 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none"/>
              <div class="absolute left-3 top-3 text-primary-500">
                <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z"></path>
                  <text x="6" y="16" font-size="10" fill="currentColor">T</text>
                </svg>
              </div>
            </div>
          </div>


          <!-- Form footer -->
          <div class="mt-8 flex flex-col sm:flex-row justify-between items-center">
            <div class="text-xs text-gray-500 mb-4 sm:mb-0">
              <div class="flex items-center">
                <svg class="w-4 h-4 mr-1 text-primary-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                </svg>
                Toutes les données sont sécurisées
              </div>
            </div>
            <div class="flex space-x-4">
              <a href="GererVehicules.jsp"
                class="px-5 py-3 border border-gray-300 rounded-lg text-gray-600 font-medium hover:bg-gray-50 transition-colors duration-300 flex items-center">
                <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M19 12H5M12 19l-7-7 7-7"></path>
                </svg>
                Annuler
              </a>
              <button type="submit"
                class="px-6 py-3 bg-primary-600 rounded-lg text-white font-medium hover:bg-primary-700 transition-colors duration-300 flex items-center shadow-lg shadow-primary-500/30">
                <svg class="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M5 12h14M12 5l7 7-7 7"></path>
                </svg>
                Ajouter
              </button>
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

    // Generate matricule in the format 789TUN2023
    // Generate matricule in the format 789TUN2025

      document.addEventListener('DOMContentLoaded', () => {
      const year = new Date().getFullYear(); // Get the current year
      const randomNumber = Math.floor(100 + Math.random() * 900); // Generate a random 3-digit number
      const matricule =  randomNumber + 'TUN' + year; // Concatenate to form the matricule
      document.getElementById('matricule').value = matricule; // Set the hidden input value
      document.getElementById('displayMatricule').value = matricule; // Display the value in the visible input
    });


  // Progress bar animation
  const progressBar = document.getElementById('progressBar');
  window.addEventListener('scroll', () => {
  const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrolled = (winScroll / height) * 100;
  progressBar.style.width = scrolled + '%';
  });

  // Form animations
  document.addEventListener('DOMContentLoaded', () => {
  // Staggered animation for form groups
      gsap.from('.form-group', {
        opacity: 0,
        y: 20,
        stagger: 0.1,
        duration: 0.5,
        ease: 'power2.out',
        delay: 0.3
      });

      // Form input animations
      const inputs = document.querySelectorAll('.input-field');
      inputs.forEach(input => {
        input.addEventListener('focus', () => {
          gsap.to(input, {
            scale: 1.02,
            duration: 0.3,
            ease: 'power2.out'
          });
        });

        input.addEventListener('blur', () => {
          gsap.to(input, {
            scale: 1,
            duration: 0.3,
            ease: 'power2.out'
          });
        });
      });

      // Submit button hover effect
      const submitBtn = document.querySelector('button[type="submit"]');
      submitBtn.addEventListener('mouseenter', () => {
        gsap.to(submitBtn, {
          scale: 1.05,
          duration: 0.3,
          ease: 'power2.out'
        });
      });

      submitBtn.addEventListener('mouseleave', () => {
        gsap.to(submitBtn, {
          scale: 1,
          duration: 0.3,
          ease: 'power2.out'
        });
      });

      // Form validation animation
      const form = document.getElementById('vehicleForm');
      form.addEventListener('submit', (e) => {
        if (form.checkValidity()) {
          e.preventDefault();

          gsap.to('.form-card', {
            y: -20,
            opacity: 0,
            duration: 0.5,
            ease: 'power2.in',
            onComplete: () => {
              form.submit();
            }
          });
        }
      });

      // Background animations
      gsap.to('.bg-primary-200', {
        x: '10%',
        y: '5%',
        duration: 20,
        repeat: -1,
        yoyo: true,
        ease: 'sine.inOut'
      });

      gsap.to('.bg-primary-300', {
        x: '-8%',
        y: '-5%',
        duration: 18,
        repeat: -1,
        yoyo: true,
        ease: 'sine.inOut',
        delay: 2
      });
    });
  </script>
</body>
</html>