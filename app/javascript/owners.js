// $(document).ready(function(){
//     $('form#new_owner_form').on('ajax:success', function(event) {
//         // Increment the owner count
//         let currentCount = parseInt($('#deactive_owners_count').text());
//         $('#deactive_owners_count').text(currentCount + 1);
  
//         // // You can also perform other actions here, like closing the modal
//         $('#exampleModal').modal('hide');
//     });
//     window.addEventListener('beforeunload', function(event) {
//         console.log('Page is reloading');
//     });
//  });
$(document).ready(function(){
    $('form#new_owner_form').on('submit', function(event) {
        event.preventDefault(); // Prevent the default form submission
        
        // Serialize form data
        var formData = $('form#new_owner_form').serialize();
        
        // Submit form via AJAX
        $.ajax({
            url: 'localhost:3000/owners',
            type: 'POST',
            data: formData,
            success: function() {
                // Increment the owner count
                let currentCount = parseInt($('#deactive_owners_count').text());
                $('#deactive_owners_count').text(currentCount + 1);
                
                // // You can also perform other actions here, like closing the modal
                // $('#exampleModal').modal('hide');
            },
            error: function(xhr, status, error) {
                // Handle errors if necessary
            }
        });
    });
    
    
});

$('#add_owner_input').on('click', function(){
    const AddOwnerInput = document.getElementById('add_owner_input');
    const myModal = document.getElementById('exampleModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddOwnerInput.focus();
    });
});

$('#add_building_input').on('click', function(){
    const AddBuildingInput = document.getElementById('add_owner_input');
    const myModal = document.getElementById('myModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddBuildingInput.focus();
    });
});

$('#edit_owner').on('click', function(){
    const EditOwnerInput = document.getElementById('edit_owner');
    const myModal = document.getElementById('editModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        EditOwnerInput.focus();
    });
});