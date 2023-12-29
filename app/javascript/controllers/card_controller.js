import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  connect() {
    var href = this.element.querySelector('.btn').href;
    console.log(href);
    this.element.addEventListener('click', function() {
      window.location.href = href;
    })
  }
}
