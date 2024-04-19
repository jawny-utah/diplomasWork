import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wrapper", "container", "content", "background"]

  initialize() {
    this.body = document.querySelector("body")

    this.modalOpened = false
  }

  view(e) {
    if(this.modalOpened == false) {
      if(e.target.getAttribute("data-url")) {
        this.getContent(e.target.getAttribute("data-url"))
      }
      this.wrapperTarget.insertAdjacentHTML('afterbegin', this.template())
      this.modalOpened = true
      this.body.style.overflow = "hidden"
    }
  }

  close(e) {
    e.preventDefault()

    if (this.modalOpened) {
      if (this.hasContainerTarget) {
        this.containerTarget.remove()
        this.modalOpened = false
        this.body.style.overflow = "auto"
      }
    }
  }

  closeBackground(e) {
    if (e.target === this.backgroundTarget) { this.close(e) }
  }

  closeWithKeyboard(e) {
    if (e.keyCode === 27) {
      this.close(e)
    }
  }

  getContent(url) {
    fetch(url).
      then(response => {
        if (response.ok) {
          return response.text()
        }
      })
      .then(html => {
        this.contentTarget.innerHTML = html
      })
  }

  template() {
    return `
      <div data-open-modal-target='container'>
        <div style='background-color: #9f9f9f8c; backdrop-filter: blur(4px);' class='modal-wrapper fixed top-0 right-0 w-full h-full rounded z-20 overflow-auto shadow-xl' data-open-modal-target='background' data-action='click->open-modal#closeBackground'>
          <div style='display: flex; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); height: 50%;' id='modal' data-open-modal-target='content'>
          <span class='loader-spinner m-2'></span>
        </div>

        <button data-action='click->open-modal#close' class='absolute top-0 right-0 w-6 h-6 text-white z-20 m-2'>
          <svg width='24' height='24' viewBox='0 0 24 24' fill='none'>
            <path d='M6 18L18 6M6 6L18 18' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' />
          </svg>
        </button>
        </div>
      </div>
    `
  }
}
