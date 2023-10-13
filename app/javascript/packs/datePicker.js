document.addEventListener("DOMContentLoaded", function () {
  const checkinDate = document.getElementById("checkin-date");
  const checkoutDate = document.getElementById("checkout-date");

  checkoutDate.disabled = true;

  checkinDate.addEventListener("input", function () {
    const checkinValue = new Date(checkinDate.value);
    if (!isNaN(checkinValue)) {
      const checkoutValue = new Date(checkinValue);
      checkoutValue.setDate(checkinValue.getDate() + 1);
      checkoutDate.min = formatDate(checkoutValue);
      checkoutDate.value = formatDate(checkoutValue);
      checkoutDate.disabled = false;
    } else {
      checkoutDate.value = "";
      checkoutDate.disabled = true;
    }
  });

  checkoutDate.addEventListener("input", function () {
    const checkinValue = new Date(checkinDate.value);
    const checkoutValue = new Date(checkoutDate.value);
    if (checkoutValue <= checkinValue) {

      const newDate = new Date(checkinValue);
      newDate.setDate(checkinValue.getDate() + 1);
      checkoutDate.value = formatDate(newDate);
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
