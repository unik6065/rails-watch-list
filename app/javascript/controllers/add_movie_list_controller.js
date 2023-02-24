import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie-list"
export default class extends Controller {
  connect() {
    console.log('Hello from add movie controller')
  }
}
