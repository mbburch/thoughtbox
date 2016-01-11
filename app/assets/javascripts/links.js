$(document).ready(function() {
  listenForRead();
  listenForUnread();
});

function listenForRead() {
  $('.mark-read').click(function(event) {
    event.preventDefault();
    var link = $(event.target).closest('.link');
    updateLink(link, true);
    link.addClass('read');
    link.removeClass('unread');
  });
}

function listenForUnread() {
  $('.mark-unread').click(function(event) {
    event.preventDefault();
    var link = $(event.target).closest('.link');
    updateLink(link, false);
    link.addClass('unread');
    link.removeClass('read');
  });
}

function updateLink(link, status) {
  $.ajax({
    type: "PUT",
    dataType: "json",
    url: "/api/v1/links/" + link.attr('data-id') + ".json",
    data: { link: { read: status } },
    error: function(xhr) {
      console.log(xhr.responseText);
      alert("Something went wrong, please try again");
    }
  });
}