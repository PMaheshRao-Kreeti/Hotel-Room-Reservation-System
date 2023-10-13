$(document).ready(function () {
  const checkInDateInput = $("#booking_check_in_date");
  const checkOutDateInput = $("#booking_check_out_date");
  const guestNameInput = $("#booking_guest_name");
  const numberOfGuestsInput = $("#booking_no_of_guests");
  const roomTypeSelect = $("#booking_room_type");
  const bookButton = $("#book-button");
  const hotelId = document.getElementById("hotel_name").dataset.hotelId;

  function toggleFormFields() {
    const checkInDate = new Date(checkInDateInput.val());
    const checkOutDate = new Date(checkOutDateInput.val());

    if (checkInDate && checkOutDate && checkOutDate >= checkInDate) {
      guestNameInput.prop("disabled", false);
      numberOfGuestsInput.prop("disabled", false);
      roomTypeSelect.prop("disabled", false);
      bookButton.prop("disabled", false);
    } else {
      guestNameInput.prop("disabled", true);
      numberOfGuestsInput.prop("disabled", true);
      roomTypeSelect.prop("disabled", true);
      bookButton.prop("disabled", true);
    }
  }

  checkInDateInput.change(toggleFormFields);
  checkOutDateInput.change(toggleFormFields);

  function handleCheckOutDateChange(selectedDate) {
    const checkInDateInput = $("#booking_check_in_date");
    const checkOutDateInput = $("#booking_check_out_date");
    const bookButton = $("#book-button");
    const hotelId = document.getElementById("hotel_name").dataset.hotelId;
    const divAlert = document.getElementById("nobooking");

    if (checkInDateInput.val() === "") {
      alert("Please enter check-in date before entering checkout date");
      checkOutDateInput.val("");
      return;
    }
    $.ajax({
      url: "/availibility_checking",
      method: "POST",
      data: {
        check_in_date: checkInDateInput.val(),
        check_out_date: selectedDate,
        hotel_id: hotelId,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        const roomTypeSelect = $("#booking_room_type");

        response.forEach(function (roomType) {
          const option = $("<option></option>")
            .text(roomType)
            .attr("value", roomType);
          roomTypeSelect.append(option);
        });

        const numberOfOptions = roomTypeSelect[0].options.length;
        console.log(typeof numberOfOptions);
        if (numberOfOptions === 1) {
          bookButton.prop("disabled", true);
          divAlert.style.display = "block";
        }
        roomTypeSelect.prop("disabled", false);
      },
      error: function (xhr, status, error) {
        alert("Check-in failed. Please try again");
      },
    });
  }

  function setMinCheckOutDate(selectedCheckInDate) {
    const checkOutDateField = document.querySelector(
      'input[name="booking[check_out_date]"]'
    );
    const checkInDateValue = new Date(selectedCheckInDate);
    const oneDayInMilliseconds = 24 * 60 * 60 * 1000;
    const minCheckOutDate = new Date(
      checkInDateValue.getTime() + oneDayInMilliseconds
    );

    const minCheckOutDateString = minCheckOutDate.toISOString().slice(0, 10);

    checkOutDateField.min = minCheckOutDateString;
  }

  $("#booking_check_in_date").change(function () {
    setMinCheckOutDate(this.value);
  });

  $("#booking_check_out_date").change(function () {
    handleCheckOutDateChange(this.value);
  });
});
