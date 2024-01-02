import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  connect() {
    var href = this.element.querySelector('.btn').href;
    this.element.addEventListener('click', function() {
      window.location.href = href;
    })
  }

  show_modal(e) {
    e.preventDefault();
    document.querySelector('#inquiry_modal').showModal();
  }
}
