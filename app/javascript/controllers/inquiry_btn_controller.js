
// <%= render('home/inquiry_btn') %>
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inquiry-btn"
export default class extends Controller {
  connect() {
  }

  to_form(e) {
    e.preventDefault();
    document.querySelector("#inquiry_email").focus();
  }
}
