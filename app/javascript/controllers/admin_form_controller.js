import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin-form"
export default class extends Controller {
  static targets = ["name", "url", "title", "displayTitle"]

  connect() {
    console.log(this.element)
    console.log(this.element.querySelector("#post_category_name"));
    console.log(this.titleTarget);
    console.log(this.displayTitleTarget);
  }

  dasherize() {
    if(this.hasNameTarget && this.hasUrlTarget) {
      this.urlTarget.value = this.nameTarget.value.split(" ").join("-");
    }

    if(this.hasTitleTarget && this.hasDisplayTitleTarget) {
      this.displayTitleTarget.value = this.titleTarget.value.split(" ").join("-");
    }
  }
}
