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

// blast displays a webpush notification to user, and allows him to click on it to join the room.
function blast(opt={}){
  var text = opt["text"]
  var url = opt["url"]

  if (window.Notification && Notification.permission === "granted") {
    var n = new Notification(text);
    n.onclick = function(event) {
      event.preventDefault(); // empêche le navigateur de donner le focus à l'onglet relatif à la notification
      window.open(url, '_blank'); //url is the actual url of the conference room
    }
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }

      if (status === "granted") {
        var n = new Notification(text);
        n.onclick = function(event) {
          event.preventDefault(); // empêche le navigateur de donner le focus à l'onglet relatif à la notification
          window.open(url, '_blank');
        }
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

      blast( {"text":`Incoming call from ${data.senderName}. Click here to accept`, "url": `/join?room=${data.roomName}`} );
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
