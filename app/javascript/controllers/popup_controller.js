import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "overlay", "firstBtn"]
  show(event) {
    const content = this.contentTarget
    const overlay = this.overlayTarget
    this.firstBtnTarget.focus()
    content.style.left = event.clientX + 'px';
    content.style.top = event.clientY + 'px';
    content.style.display = 'flex';
    overlay.style.display = 'block'
  }
  showactions(event) {
    const content = this.contentTarget
    const overlay = this.overlayTarget
    this.firstBtnTarget.focus()
    content.style.left = event.clientX + 'px';
    content.style.top = event.clientY + 'px';
    content.style.display = 'flex';
  }
  
  hide() {
     this.contentTarget.style.display = 'none';
     this.overlayTarget.style.display = 'none';
     this.element.focus()
  }
}
