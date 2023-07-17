////function show_hide_password(target) {
////	var input = document.getElementById('password-input');
////	if (input.getAttribute('type') == 'password') {
////		target.classList.add('view');
////		input.setAttribute('type', 'text');
////	} else {
////		target.classList.remove('view');
////		input.setAttribute('type', 'password');
////	}
////	return false;
////}


// Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
    'use strict'

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.querySelectorAll('.needs-validation')

    // Loop over them and prevent submission
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })
})()

function validate(input) {
    if (/^\s/.test(input.value)) {
        input.value = "";
    }

}