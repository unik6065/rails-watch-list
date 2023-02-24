import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie-list"
export default class extends Controller {

  show(){
    var element = document.getElementById('add-movie-container');
    element.classList.add('show');
    element.classList.remove('hide');
  }
}
