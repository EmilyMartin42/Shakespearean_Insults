"use strict";

const checkboxes = document.querySelectorAll('details > p > input');
window.addEventListener('DOMContentLoaded', (event) => {
    /* Attach event listeners to checkboxes */
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', filterInsults, false)
    }
});
function filterInsults() {
    //Get the @id values of the checkboxes that are unchecked
    var checked_boxes_array = Array. from (checkboxes).filter(item => item.checked).map(item => item.id);    
    /* Find all insults (ins)
     * Hide each insult (momentarily)
     * Show each insult that contains an checked @id  value
     *  */
    const insults = document.getElementsByClassName('insult');
    for (var i = 0; i < insults.length; i++) {
        insults[i].style.display = 'none';
        if (Array. from (insults[i].classList).some(item => checked_boxes_array.includes(item))) {
            insults[i].style.display = 'block';
        }
    }
}