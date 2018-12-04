//= require jquery
//= require popper
//= require bootstrap
//= require material-kit

//= require rails-ujs
//= require_tree .
//= require cable

//= require sweetalert2

// notifications_#{current_user.id}"

// const swal = require('sweetalert');

function SubscribeChannel(){
  App.cable.subscriptions.create({ channel: 'NotificationsChannel' },
  {
    received: data => {
      // if (confirm(`Incoming call from ${data.senderName}. Accept?`)) {
      //   window.location = `/join?room=${data.roomName}`;
      // }

      swal({
        title: "Incoming call",
        text: `Incoming call from ${data.senderName}. Accept?`,
        showCancelButton: true,
        confirmButtonText: 'Accept',
        cancelButtonText: 'Decline'
      })
      .then(accepted => {
         if (accepted) window.location = `/join?room=${data.roomName}`;
      });

    }
  });
}
