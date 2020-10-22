import flatpickr from "flatpickr";

flatpickr(".datepicker", {
  altInput: true,
  altFormat: "d/m/Y",
  dateFormat: "Y-m-d",
  defaultDate: new Date().toISOString().slice(0, 10)
});
