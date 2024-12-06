# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# Bootstrap
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

# FullCalendar
pin "@fullcalendar/core", to: "https://ga.jspm.io/npm:@fullcalendar/core@6.1.8/index.js"
pin "@fullcalendar/daygrid", to: "https://ga.jspm.io/npm:@fullcalendar/daygrid@6.1.8/index.js"
pin "@fullcalendar/interaction", to: "https://ga.jspm.io/npm:@fullcalendar/interaction@6.1.8/index.js"
pin "@fullcalendar/timegrid", to: "https://ga.jspm.io/npm:@fullcalendar/timegrid@6.1.8/index.js"
