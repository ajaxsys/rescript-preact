import eventBus from './event-bus.js';

class ComponentOne extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `<button id="send">Send Data</button>`;
        this.shadowRoot.querySelector('#send').addEventListener('click', () => this.sendData());
    }

    connectedCallback() {
        console.log('Component One connected to the DOM');
        const initialMessage = this.getAttribute('initial-message');
        if (initialMessage) {
            this.sendData(initialMessage);
        }
    }

    sendData(message = 'Hello from Component One') {
        const event = new CustomEvent('dataSent', {
            detail: { message },
            bubbles: true,
            composed: true
        });
        eventBus.dispatchEvent(event);
    }
}

customElements.define('component-one', ComponentOne);
