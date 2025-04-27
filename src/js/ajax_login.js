$(document).ready(function() {
    $('#sign-in-form').on('submit', function(event) {
        event.preventDefault(); // Prevent the form from submitting the traditional way

        var username = $('#sign-in-username').val();
        var password = $('#sign-in-password').val();

        $.ajax({
            url: 'src/php/login.php',
            type: 'POST',
            data: {
                nome: username,
                senha: password
            },
            success: function(response) {
                if (response == '1') {
                    window.location.href = 'https://www.google.com.br/';
                } else if (response == '0') {
                    alert('Login ou senha inválidos');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('Error: ' + textStatus + ' - ' + errorThrown);
            }
        });
    });
});
