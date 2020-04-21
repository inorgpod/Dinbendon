// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import ax from "axios"

export default class extends Controller {
  static targets = ["icon"]

  initialize() {
    this.clicked = false; //預設一個boolean 
  }
  heart(e) {
    e.preventDefault();

    const csrfToken = document.querySelector('[name=csrf-token]').content 
    ax.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken //暫時從網頁檢查器抓下這段使下面ax.post合法的Token
    let item_id = document.querySelector('#item_id').value;

    ax.post('/api/v1/items/${item_id}/favorite') 
    .then(function(resp){
      if(resp.data.status ==="favorited"){
        this.iconTarget.classList.remove('far')
        this.iconTarget.classList.add('fas')
      }else{
        this.iconTarget.classList.remove('fas')
        this.iconTarget.classList.add('far')
      }
      // console.log(resp.data);
    })

    .catch(function(err){
      console.log(err);
    })

  // console.log('heart is clicked');
  // console.log(this.iconTarget);
  if (this.clicked){
    this.iconTarget.classList.remove('fas')
    this.iconTarget.classList.add('far')
    this.clicked = false
    } else{
    this.iconTarget.classList.remove('far')
    this.iconTarget.classList.add('fas')//用js的語法置換class的屬性
    this.clicked = true
    }
  }
}
