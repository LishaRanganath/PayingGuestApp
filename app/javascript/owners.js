$(document).ready(function(){
    $('form#new_owner_form').on('ajax:success', function(event) {
        // Increment the owner count
        let currentCount = parseInt($('#deactive_owners_count').text());
        $('#deactive_owners_count').text(currentCount + 1);
  
        // // You can also perform other actions here, like closing the modal
        // $('#exampleModal').modal('hide');
    });
 });
