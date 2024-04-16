import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "checkbox"]

  minus() {
    if (this.quantityTarget.value == "0") {
      return
    }

    this.quantityTarget.value--

    if (this.quantityTarget.value == "0") {
      this.checkboxTarget.checked = false
    }
  }

  plus() {
    this.quantityTarget.value++
    this.checkboxTarget.checked = true
  }
}
