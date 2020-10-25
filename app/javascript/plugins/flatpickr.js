import flatpickr from "flatpickr";
import {fr as French} from "flatpickr/dist/l10n/fr.js";

flatpickr.localize(flatpickr.l10ns.fr);
flatpickr(".datepicker", {
  altInput: true,
  altFormat: "d/m/Y",
  dateFormat: "Y-m-d",
  defaultDate: new Date().toISOString().slice(0, 10),
  locale: { firstDayOfWeek: 1 }
});
