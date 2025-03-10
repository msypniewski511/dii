// // Entry point for the build script in your package.json
// //= require rails-ujs
// import Rails from '@rails/ujs'
// Rails.start()
// import '@hotwired/turbo-rails'
// import './controllers'
// import $ from 'jquery'

// // Bootstrap & other plugins
// import * as bootstrap from 'bootstrap'
// import '@popperjs/core' // Ensure Popper.js is loaded
// import { createPopper } from '@popperjs/core'
// import 'bootstrap'
// import 'bootstrap/dist/js/bootstrap.bundle.min'
// import 'bootstrap-icons/font/bootstrap-icons.css'

// // FullCalendar
// import { Calendar } from '@fullcalendar/core'
// import dayGridPlugin from '@fullcalendar/daygrid'
// import interactionPlugin from '@fullcalendar/interaction'

// import Chart from 'chart.js/auto'
// import 'trix'
// import '@rails/actiontext'

// import './plugins/fullcalendar.min.js'
// import './plugins/fullcalendar' // <-- Make sure this is correct
// import './plugins/swot_chart.js'
// import './plugins/line_chart.js'

// import { Turbo } from '@hotwired/turbo-rails'
// Turbo.session.drive = false

// import './argon-dashboard'

// document.addEventListener('turbo:load', function () {
//   document.querySelectorAll('.dropdown-toggle').forEach((dropdown) => {
//     new bootstrap.Dropdown(dropdown)
//   })
// })
// Entry point for the build script in your package.json
//= require rails-ujs

// Rails & Turbo Setup
import Rails from '@rails/ujs'
Rails.start()
import '@hotwired/turbo-rails'
import { Turbo } from '@hotwired/turbo-rails'
Turbo.session.drive = false

import './controllers'
import $ from 'jquery'

// ✅ Use only this Bootstrap import (includes Popper.js)
import 'bootstrap/dist/js/bootstrap.bundle.min'
import 'bootstrap-icons/font/bootstrap-icons.css' // Keep this if you use Bootstrap Icons

// ✅ FullCalendar Imports (Ensure Plugins Load Correctly)
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'

// ✅ Other JavaScript Plugins
import Chart from 'chart.js/auto'
import 'trix'
import '@rails/actiontext'

// ✅ Plugin Files (Ensure These Files Exist in `app/javascript/plugins/`)
import './plugins/fullcalendar'
import './plugins/swot_chart'
import './plugins/line_chart'

// ✅ Argon Dashboard (Ensure This Is Loaded)
import './argon-dashboard'
import './argon-dashboard.js'

// ✅ Fix Bootstrap Dropdowns on Turbo Navigation
document.addEventListener('turbo:load', function () {
  document.querySelectorAll('.dropdown-toggle').forEach((dropdown) => {
    new bootstrap.Dropdown(dropdown)
  })
})
document.addEventListener('turbo:load', function () {
  document
    .querySelectorAll('[data-bs-toggle="dropdown"]')
    .forEach((dropdown) => {
      dropdown.addEventListener('show.bs.dropdown', function (event) {
        const dropdownInstance = bootstrap.Dropdown.getOrCreateInstance(
          event.target
        )

        if (dropdownInstance._popper && dropdownInstance._popper.state) {
          const preventOverflowModifier =
            dropdownInstance._popper.state.options.modifiers.find(
              (modifier) => modifier.name === 'preventOverflow'
            )

          if (preventOverflowModifier) {
            preventOverflowModifier.enabled = false
            dropdownInstance._popper.update()
          }
        }
      })
    })

  // Reinitialize all dropdowns for Turbo Drive
  document.querySelectorAll('.dropdown-toggle').forEach((dropdownToggleEl) => {
    new bootstrap.Dropdown(dropdownToggleEl)
  })
})
document.addEventListener('DOMContentLoaded', function () {
  const darkModeToggle = document.getElementById('dark-version')
  const savedDarkMode = localStorage.getItem('darkMode')

  if (savedDarkMode === 'enabled') {
    document.body.classList.add('dark-version')
    document.getElementById('sidenav-main').classList.remove('bg-white')
    document.getElementById('sidenav-main').classList.add('bg-dark')
    document.getElementById('sidenav-main').classList.add('bg-default')

    if (darkModeToggle) {
      darkModeToggle.setAttribute('checked', 'true')
    }
  } else {
    document.body.classList.remove('dark-version')
    if (darkModeToggle) {
      darkModeToggle.removeAttribute('checked')
    }
  }
})

// document.addEventListener("DOMContentLoaded", function () {
//   var ctx = document.getElementById('portersChart').getContext('2d');
//   var chart = new Chart(ctx, {
//       type: 'radar',
//       data: {
//           labels: ['New Entrants', 'Supplier Power', 'Buyer Power', 'Substitutes', 'Industry Rivalry'],
//           datasets: [{
//               label: 'Porter’s Five Forces',
//               data: [<%= @porter_analysis.threat_of_new_entrants %>, <%= @porter_analysis.supplier_power %>, <%= @porter_analysis.buyer_power %>, <%= @porter_analysis.threat_of_substitutes %>, <%= @porter_analysis.industry_rivalry %>],
//               backgroundColor: 'rgba(54, 162, 235, 0.2)',
//               borderColor: 'rgba(54, 162, 235, 1)',
//               borderWidth: 2
//           }]
//       },
//       options: {
//           scale: {
//               ticks: { beginAtZero: true, max: 5 }
//           }
//       }
//   });
// })
