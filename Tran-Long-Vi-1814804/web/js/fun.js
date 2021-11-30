document.addEventListener('DOMContentLoaded', function( ) {
    let button = document.querySelector('.btnAddNew');
    let form = document.querySelector('.formAddNew');
    button.onclick = function() {
        form.classList.toggle("d-none");
    }
}, false );