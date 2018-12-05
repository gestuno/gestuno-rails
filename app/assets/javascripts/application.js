//= require jquery
//= require popper
//= require bootstrap
//= require material-kit
//= require charge

//= require rails-ujs
//= require_tree .
//= require cable

//= require sweetalert2

function getCookie(cookieName) {
  const value = '; ' + document.cookie;
  const parts = value.split('; ' + cookieName + '=');
  if (parts.length === 2) return parts.pop().split(';').shift();
}

// `blast` displays a web push notification to a user and allows them to click on it to join the room
function blast(options={}) {
  const text = options['text']
  const url = options['url']

  if (window.Notification && Notification.permission === 'granted') {
    const n = new Notification(text);
    n.onclick = function(event) {
      event.preventDefault();
      window.open(url, '_blank'); //url is the actual url of the conference room
    }
  } else if (window.Notification && Notification.permission !== 'denied') {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }

      if (status === 'granted') {
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

function checkBrowserPrivateMode(ifPrivate, ifNormal) {
  const fs = window.RequestFileSystem || window.webkitRequestFileSystem;

  fs(window.TEMPORARY,
     100,
     domFs => ifNormal && ifNormal(), //on success
     err => ifPrivate && ifPrivate()
  );
}

function browserRequestPermission() {
  Notification.requestPermission(status => {
    if (Notification.permission !== status) {
      Notification.permission = status;
    }
  });
}

function promptAndRequestPermission() {
  swal({
    title: 'Call notifications',
    text: 'Please accept your browserʼs request to get notifications when someone calls you.'
  })
  .then(action => {
    browserRequestPermission();
  });
  localStorage.setItem('notificationMsgAlreadyShown', true);
}

function displayPrivateModeMessage() {

  if (!sessionStorage.privateModeMsgAlreadyShown) {
    swal({
      title: 'Private mode',
      text: 'It looks like youʼre browsing in private mode. To receive notifications, please switch to normal mode.'
    });
    sessionStorage.setItem('privateModeMsgAlreadyShown', true);
  }

}

function authorize() {
  window.addEventListener('load', () => {
    if (getCookie('signed_in') && window.Notification && Notification.permission !== 'granted') {

      if (!localStorage.notificationMsgAlreadyShown) {
        checkBrowserPrivateMode(
          displayPrivateModeMessage, // if private mode
          promptAndRequestPermission // if normal mode
        );
      } else {
        browserRequestPermission();
      }

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
        title: 'Incoming call',
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
