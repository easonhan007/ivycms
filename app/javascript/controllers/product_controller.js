import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["primary"]

  connect() {
    // console.log(this.primaryTarget);
  }

  switch(e) {
    this.primaryTarget.src = e.target.src;
  }
}
