$(function() {
  // Initialize variables
  var $window = $(window);
  var socket = io('http://localhost:8025');

  socket.on('sk', function (data) {
    console.log(data);
    socket.emit('my other event', { my: 'data' });
  });

});