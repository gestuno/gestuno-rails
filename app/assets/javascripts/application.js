//= require jquery
//= require popper
//= require bootstrap
//= require material-kit
//= require charge

//= require rails-ujs
//= require_tree .
//= require cable

//= require sweetalert2

navigator.serviceWorker.register('/sw.js');

function getCookie(cookieName) {
  const value = '; ' + document.cookie;
  const parts = value.split('; ' + cookieName + '=');
  if (parts.length === 2) return parts.pop().split(';').shift();
}

function showNotification(title, options) {
  navigator.serviceWorker.ready.then((registration) => {
    registration.showNotification(title, options);
  });
}

// `blast` displays a web push notification to a user and allows them to click on it to join the room
function blast(title, options = {}) {

  if (window.Notification && Notification.permission === 'granted') {

    showNotification(title, options);

  } else if (window.Notification && Notification.permission !== 'denied') {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }

      if (status === 'granted') {

        showNotification(title, options);

      } else {
        // noop - sweetalert is already used as backup
      }
    });
  } else {
    // noop - sweetalert is already used as backup
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
    text: 'Please accept your browser’s request to get notifications when someone calls you.'
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
      text: 'It looks like you’re browsing in private mode. To receive notifications, please switch to normal mode.'
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

// navigator.serviceWorker.addEventListener('message', e => {
//   if (e.data.tag === 'incomingCall') {
//     window.open(`/join?room=${e.data.otherData.roomName}`, '_blank');
//   }
// });

function SubscribeChannel() {
  App.cable.subscriptions.create({ channel: 'NotificationsChannel' },
  {
    received: data => {

      blast(`Incoming call from ${data.senderName}. Click to accept`,
        {
          tag: 'incomingCall',
          // requireInteraction: true, // TODO dismiss only after user interaction with either notification or swal
          vibrate: [
            1000, 1000, 1000, 3000,
            1000, 1000, 1000, 3000,
            1000, 1000, 1000, 3000,
            1000, 1000, 1000, 3000,
            1000, 1000, 1000, 3000,
            1000, 1000, 1000, 3000
          ],
          data: {
            url: `/join?room=${data.roomName}`
          }
        }
      );

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
