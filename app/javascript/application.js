// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

window.addEventListener("turbo:frame-missing", (event) => {
  event.preventDefault();
  window.location.reload();
});
