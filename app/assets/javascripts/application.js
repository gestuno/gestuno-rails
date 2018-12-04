//= require jquery
//= require popper
//= require bootstrap
//= require material-kit

//= require rails-ujs
//= require_tree .
//= require cable

//= require sweetalert2

// `blast` displays a web push notification to a user and allows them to click on it to join the room
function blast(options={}) {
  const text = options["text"]
  const url = options["url"]

  if (window.Notification && Notification.permission === "granted") {
    const n = new Notification(text);
    n.onclick = function(event) {
      event.preventDefault();
      window.open(url, '_blank'); //url is the actual url of the conference room
    }
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }

      if (status === "granted") {
        const n = new Notification(text);
        n.onclick = function(event) {
          event.preventDefault();
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


function authorize() {
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


function SubscribeChannel() {
  App.cable.subscriptions.create({ channel: 'NotificationsChannel' },
  {
    received: data => {

      blast({
        text: `Incoming call from ${data.senderName}. Click to accept`,
        url: `/join?room=${data.roomName}`
      });

      swal({
        title: "Incoming call",
        text: `Incoming call from ${data.senderName}. Accept?`,
        showCancelButton: true,
        confirmButtonText: 'Accept',
        cancelButtonText: 'Decline'
      })
      .then(action => {

        /*
          on confirm: `{value: true}`
          on cancel: `{dismiss: "cancel" || "overlay" || "esc"}`
        */

         if (action.value) window.location = `/join?room=${data.roomName}`;
      });

    }
  });
}

authorize();
