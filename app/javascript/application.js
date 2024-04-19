// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import SlimSelect from 'slim-select'

new SlimSelect({
  select: '#slim-select'
})

window.addEventListener('turbo:frame-render', function (event) {
  console.log('fired')
  new SlimSelect({
    select: '#slim-select'
  })
})
