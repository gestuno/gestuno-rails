//= require jquery
//= require popper
//= require bootstrap
//= require material-kit

//= require rails-ujs
//= require_tree .
//= require cable






function SubscribeChannel(){
  App.cable.subscriptions.create(
  {channel: 'NotificationsChannel'},
  {
    received: function(data) {
      alert("hey!");
      console.log(data);
    }
  });
}
