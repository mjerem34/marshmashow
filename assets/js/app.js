import "phoenix_html"
import "hammerjs"
import "materialize-css"
import Turbolinks from 'turbolinks'

Turbolinks.start()
$(document).on('turbolinks:load', function() {
  $(document).on('click', '*[data-link]', function () {
    window.location = $(this).data("link")
  });
});
