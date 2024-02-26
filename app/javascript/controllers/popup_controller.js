import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "overlay"]
  show() {
    const content = this.contentTarget
    const overlay = this.overlayTarget

    content.style.left = event.clientX + 'px';
    content.style.top = event.clientY + 'px';

    content.style.display = 'flex';
    overlay.style.display = 'block'
  }
  
  hide() {
     this.contentTarget.style.display = 'none';
     this.overlayTarget.style.display = 'none'
  }
}
