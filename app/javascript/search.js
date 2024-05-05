$(document).ready(function() {
    $('#search-form').on('submit', function(event) {
      event.preventDefault(); // Prevent default form submission behavior
  
      $.ajax({
        url: searchBuildingsPath,
        type: 'GET',
        data: $(this).serialize(),
        success: function(response) {
            console.log(response)
          if ($(response).find('.building').length > 0) {
            $('#search-results').html(response);
            $('.grid-container').show();
          } else {
            $('#search-results').html('<p>No search results found.</p>');
            $('.grid-container').hide();
          }
        },
        error: function(xhr, status, error) {
          console.error("Error:", error); // Log any errors
        }
      });
    });
  });
  