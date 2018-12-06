self.onnotificationclick = (e) => {
  // console.log('On notification click: ', e.notification.tag);

  e.preventDefault();

  // self.clients.matchAll().then(clients => {
  //   clients.forEach(client => {
  //     // client.postMessage({
  //     //   tag: e.notification.tag,
  //     //   otherData: e.notification.data
  //     // });
  //   });
  // });

  e.waitUntil(clients.matchAll({
    type: "window"
  }).then(function(clientList) {
    // for (var i = 0; i < clientList.length; i++) {
    //   var client = clientList[i];
    //   if (client.url === '/' && 'focus' in client)
    //     return client.focus();
    // }
    if (clients.openWindow)
      return clients.openWindow(e.notification.data.url);
  }));

  e.notification.close();

  // // This looks to see if the current is already open and
  // // focuses if it is
  // e.waitUntil(clients.matchAll({
  //   type: "window"
  // }).then(function(clientList) {
  //   for (var i = 0; i < clientList.length; i++) {
  //     var client = clientList[i];
  //     if (client.url == '/' && 'focus' in client)
  //       return client.focus();
  //   }
  //   if (clients.openWindow)
  //     return clients.openWindow('/');
  // }));


};

// addEventListener('fetch', e => {
//   e.waitUntil(async function() {
//     // Exit early if we don't have access to the client.
//     // Eg, if it's cross-origin.
//     if (!e.clientId) return;

//     // Get the client.
//     const client = await clients.get(e.clientId);
//     // Exit early if we don't get the client.
//     // Eg, if it closed.
//     if (!client) return;

//     // Send a message to the client.

//   }());
// });

