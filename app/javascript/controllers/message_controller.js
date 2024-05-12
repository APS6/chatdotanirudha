import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "contentDiv", "popup", "innerDiv" ]
  handleFocus() {
    const messageDiv = this.element

    const handlekeydown = (e) => {
      const triggerRect = messageDiv.getBoundingClientRect();
      if (e.key == "Enter") {
        this.application.getControllerForElementAndIdentifier(this.popupTarget, 'popup').show({clientX: triggerRect.left + triggerRect.width - 28, clientY: triggerRect.top + 16})
        removeListener()
      }
    }
    const removeListener = () => {
      this.element.removeEventListener('keydown', handlekeydown)
    }

    this.element.addEventListener('keydown', handlekeydown)

  }
  hidePopup() {
    this.application.getControllerForElementAndIdentifier(this.popupTarget, 'popup').hide()
  }

}
