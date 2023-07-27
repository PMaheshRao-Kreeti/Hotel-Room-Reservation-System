// Function to enable/disable form fields based on check-in and check-out dates
$(document).ready(function () {
  const checkInDateInput = $('#booking_check_in_date');
  const checkOutDateInput = $('#booking_check_out_date');
  const guestNameInput = $('#booking_guest_name');
  const numberOfGuestsInput = $('#booking_no_of_guests');
  const roomTypeSelect = $('#booking_room_type');
  const bookButton = $('#book-button');
  const hotelId = document.getElementById('hotel_name').dataset.hotelId; 


  function toggleFormFields() {
    const checkInDate = new Date(checkInDateInput.val());
    const checkOutDate = new Date(checkOutDateInput.val());

    if (checkInDate && checkOutDate && checkOutDate >= checkInDate) {
      guestNameInput.prop('disabled', false);
      numberOfGuestsInput.prop('disabled', false);
      roomTypeSelect.prop('disabled', false);
      bookButton.prop('disabled', false);
      

    } else {
      guestNameInput.prop('disabled', true);
      numberOfGuestsInput.prop('disabled', true);
      roomTypeSelect.prop('disabled', true);
      bookButton.prop('disabled', true);
    }
  }

  // Attach change event listeners to the check-in and check-out date inputs
  checkInDateInput.change(toggleFormFields);
  checkOutDateInput.change(toggleFormFields);
});
