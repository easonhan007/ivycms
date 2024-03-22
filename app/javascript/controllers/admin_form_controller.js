import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin-form"
export default class extends Controller {
  static targets = ["name", "url", "title", "displayTitle", "md", "richEditor", "mdEditor"]

  connect() {
    if(this.mdTarget.checked) {
      this.richEditorTarget.classList.add("hidden");
    } else {
      this.mdEditorTarget.classList.add("hidden");
    }
  }

  dasherize() {
    if(this.hasNameTarget && this.hasUrlTarget) {
      this.urlTarget.value = this.nameTarget.value.split(" ").join("-");
    }

    if(this.hasTitleTarget && this.hasDisplayTitleTarget) {
      this.displayTitleTarget.value = this.titleTarget.value.split(" ").join("-");
    }
  }

  toggleEditor() {
    this.richEditorTarget.classList.toggle("hidden");
    this.mdEditorTarget.classList.toggle("hidden");
  }
}
