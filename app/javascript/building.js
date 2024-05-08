$('#add_room_type').on('click', function(){
    const AddRoomType = document.getElementById('add_room_type');
    const myModal = document.getElementById('roomModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddOwnerInput.focus();
    });
});
$('#update_room_type').on('click', function(){
        const AddRoomType = document.getElementById('update_room_type');
        const myModal = document.getElementById('updateRoomModal');
        

        myModal.addEventListener('shown.bs.modal', () => {
            AddOwnerInput.focus();
        });
});
$('#add_category').on('click', function(){
    const AddCategoryType = document.getElementById('add_category');
    const myModal = document.getElementById('categoryModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddOwnerInput.focus();
    });
});
$('#add_availability').on('click', function(){
    const AddCategoryType = document.getElementById('add_availability');
    const myModal = document.getElementById('availabilityModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddOwnerInput.focus();
    });
});

$('#book_room').on('click', function(){
    const BookRoom = document.getElementById('book_room');
    const myModal = document.getElementById('bookroomModal');
    

    myModal.addEventListener('shown.bs.modal', () => {
        AddOwnerInput.focus();
    });
});