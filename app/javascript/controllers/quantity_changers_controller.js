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

  changeCheckbox() {
    if (this.checkboxTarget.checked && (this.quantityTarget.value == "0" || this.quantityTarget.value == "")) {
      if (this.quantityTarget.value == "0") {
        this.quantityTarget.value++
      } else {
        this.quantityTarget.value = 0
      }
    } else if (!this.checkboxTarget.checked && this.quantityTarget.value != "0" && this.quantityTarget.value !== "") {
      this.quantityTarget.value = 0
    }
  }

  updateQuantity(event) {
    if (!this.checkboxTarget.checked && event.target.value !== "0" && event.target.value !== "") {
      this.checkboxTarget.checked = true
    } else if ((this.quantityTarget.value == "0" || this.quantityTarget.value == "") && this.checkboxTarget.checked) {
      this.checkboxTarget.checked = false
    }
  }
}
