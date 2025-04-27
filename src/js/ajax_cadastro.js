$(document).ready(function() {
    $('#sign-up-form').on('submit', function(event) {
        event.preventDefault();
  
        const username = $('#sign-up-username').val();
        const email = $('#sign-up-email').val();
        const password = $('#sign-up-password').val();
  
        // Basic validation
        if (!username || !email || !password) {
            alert("All fields are required!");
            return;
        }
  
        $.ajax({
            url: 'src/php/cadastrar.php',
            type: 'POST',
            data: {
                username: username,
                email: email,
                password: password
            },
            success: function(response) {
                alert(response);
                // Optionally, clear the form or redirect
                $('#sign-up-form')[0].reset();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('Error: ' + textStatus + ' - ' + errorThrown);
                alert("An error occurred. Please try again.");
            }
        });
    });
  });
  