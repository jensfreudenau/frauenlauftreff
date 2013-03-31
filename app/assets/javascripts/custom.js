$(document).ready(function() {
    $.timepicker.regional['de'] = {
                    hourText: 'Stunde',
                    minuteText: 'Min.',
                    amPmText: ['AM', 'PM'] ,
                    closeButtonText: 'Beenden',
                    nowButtonText: 'Aktuelle Zeit',
                    deselectButtonText: 'Wischen' }
    $.timepicker.setDefaults($.timepicker.regional['de']);
    $('#profile_start_time, #profile_end_time').timepicker({

      showPeriodLabels: false,
      hours: {
            starts: 0,                // First displayed hour
            ends: 23                  // Last displayed hour
      },
      minutes: {
              starts: 0,                // First displayed minute
              ends: 45,                 // Last displayed minute
              interval: 15               // Interval of displayed minutes
          }
    });
});