class EventBus extends EventTarget {
  dispatchEvent(event) {
      super.dispatchEvent(event);
  }

  addEventListener(type, listener, options) {
      super.addEventListener(type, listener, options);
  }

  removeEventListener(type, listener, options) {
      super.removeEventListener(type, listener, options);
  }
}

const eventBus = new EventBus();
export default eventBus;
