import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-flash"
export default class extends Controller {
  connect() {
    let thisRef = this

    this.monitorSwipe()
    setTimeout(function() {
      thisRef.context.element.style.display = 'none'
    }, 3000);
  }
   monitorSwipe() {
     let thisRef = this

    this.element.addEventListener('touchstart', handleTouchStart, false);
    this.element.addEventListener('touchmove', handleTouchMove, false);

    let xDown = null;
    let yDown = null;

    function handleTouchStart(event) {
      xDown = event.touches[0].clientX;
      yDown = event.touches[0].clientY;
    }

    function handleTouchMove(event) {
      if (!xDown || !yDown) {
        return;
      }

      const xUp = event.touches[0].clientX;
      const yUp = event.touches[0].clientY;

      const xDiff = xDown - xUp;
      const yDiff = yDown - yUp;

      if (Math.abs(xDiff) < Math.abs(yDiff)) {
        if (yDiff > 4) {
          thisRef.element.style.display = 'none'
          thisRef.element.removeEventListener('touchstart', handleTouchStart);
          thisRef.element.removeEventListener('touchmove', handleTouchMove);
        }
      }
      // Reset values
      xDown = null;
      yDown = null;
    }
  }
  close() {
    this.element.style.display = 'none'
  } 

}
