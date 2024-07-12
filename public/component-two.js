import eventBus from './event-bus.js';

class ComponentTwo extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `<div id="display">Waiting for data...</div>`;
    }

    connectedCallback() {
        console.log('Component Two connected to the DOM');
        eventBus.addEventListener('dataSent', (event) => {
            console.log('Data received in Component Two:', event.detail.message);
            this.shadowRoot.querySelector('#display').textContent = event.detail.message;
        });
    }
}

customElements.define('component-two', ComponentTwo);
