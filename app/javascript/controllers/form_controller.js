
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "submitButton" ]
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
}