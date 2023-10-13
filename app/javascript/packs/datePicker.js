$(document).ready(function () {
  console.log("in datePicker.js start");
  const checkinDate = $("#checkin-date");
  const checkoutDate = $("#checkout-date");

  checkoutDate.prop("disabled", true);

  checkinDate.on("input", function () {
    const checkinValue = new Date(checkinDate.val());
    if (!isNaN(checkinValue)) {
      const checkoutValue = new Date(checkinValue);
      checkoutValue.setDate(checkinValue.getDate() + 1);
      checkoutDate.attr("min", formatDate(checkoutValue));
      checkoutDate.val(formatDate(checkoutValue));
      checkoutDate.prop("disabled", false);
    } else {
      checkoutDate.val("");
      checkoutDate.prop("disabled", true);
    }
  });

  checkoutDate.on("input", function () {
    const checkinValue = new Date(checkinDate.val());
    const checkoutValue = new Date(checkoutDate.val());
    if (checkoutValue <= checkinValue) {
      const newDate = new Date(checkinValue);
      newDate.setDate(checkinValue.getDate() + 1);
      checkoutDate.val(formatDate(newDate));
    }
  });

  // Helper function to format a date as 'YYYY-MM-DD'
  function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
  }
});
