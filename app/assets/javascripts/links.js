$(document).ready(function() {
  listenForRead();
  listenForUnread();
  editTitle();
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
    }
  });
}

function editTitle() {
  $('#all-links').on('click', '.title', function() {
    var linkElement = event.toElement;
    var titleElement = $(this).attr('contenteditable', 'true');
    titleElement.focus();
    titleElement.keypress(function() {
      if (event.keyCode === 13) {
        var $link = $(titleElement.parent().parent());
        var $title = linkElement.textContent;
        var linkParams = {link: { title: $title }};

        $.ajax({
          type: 'PUT',
          url: '/api/v1/links/' + $link.attr('data-id'),
          data: linkParams,
          success: function() {
            console.log("Success");
            $link.find('.title').text(linkParams.link.title);
          },
          error: function(xhr) {
            console.log(xhr.responseText);
          }
        });
      }
    });
  });
}