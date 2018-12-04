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
function blast(text){
  if (window.Notification && Notification.permission === "granted") {
    var n = new Notification(text);
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }

      if (status === "granted") {
        var n = new Notification(text);
      } else {
        alert(text);
      }
    });
  } else {
    alert(text);
  }
}


function authorize(){
  window.addEventListener('load', function () {
    if (window.Notification && Notification.permission !== "granted") {
      Notification.requestPermission(function (status) {
        if (Notification.permission !== status) {
          Notification.permission = status;
        }
      });
    }
  });
}


function SubscribeChannel(){
  App.cable.subscriptions.create({ channel: 'NotificationsChannel' },
  {
    received: data => {
      // if (confirm(`Incoming call from ${data.senderName}. Accept?`)) {
      //   window.location = `/join?room=${data.roomName}`;
      // }
      blast( `Incoming call from ${data.senderName}. Accept?`);
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

authorize();
