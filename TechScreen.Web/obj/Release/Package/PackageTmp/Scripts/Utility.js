$(document).ready(function () {
    startvalidation();
});


function startvalidation() {

    $('.number').keydown(function (event) {
        // Allow only backspace and delete
        if (
        event.keyCode == 8
        || event.keyCode == 9
        || event.keyCode == 16
        || event.keyCode == 17
        || event.keyCode == 18
        || event.keyCode == 35
        || event.keyCode == 36
        || event.keyCode == 37
        || event.keyCode == 38
        || event.keyCode == 39
        || event.keyCode == 40
        || event.keyCode == 45
        || event.keyCode == 46
        ) {
            // let it happen, don't do anything
        }
        else {
            // Ensure that it is a number and stop the keypress
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                event.preventDefault();
            }
        }
    });
    $('.alphabet').keydown(function (event) {
        // Allow only backspace and delete
        if (
        event.keyCode == 8
        || event.keyCode == 9
        || event.keyCode == 16
        || event.keyCode == 17
        || event.keyCode == 18
        || event.keyCode == 35
        || event.keyCode == 36
        || event.keyCode == 37
        || event.keyCode == 38
        || event.keyCode == 39
        || event.keyCode == 40
        || event.keyCode == 45
        || event.keyCode == 46
        ) {
            // let it happen, don't do anything
        }
        else {
            // Ensure that it is a number and stop the keypress
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {

            }
            else
                event.preventDefault();
        }
    });
}