
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "submitButton", "closeBtn" ]
  connect () {
   if (window.innerWidth > 768) {
     this.inputTarget.focus()
   }
   this.resize()
  }
  reset() {
   this.element.reset()
   this.resize()
  }
  resize() {
    const input = this.inputTarget
    input.style.height = "auto";
    input.style.height = `${input.scrollHeight + 2}px`
  }
  submit(e){
    e.preventDefault()
    this.submitButtonTarget.click()
  }
  close() {
    if (this.closeBtnTarget) {
      this.closeBtnTarget.click()
    }
  }
}