$(document).ready(function() {
  fetchLinks();
  listenForRead();
  listenForUnread();
  editTitle();
  editUrl();
});

function fetchLinks() {
  $.ajax({
    type: 'GET',
    url: '/api/v1/links',
    success: function(links) {
      $.each(links, function(index, link) {
        renderLink(link);
      });
    }
  });
}

function renderLink(link) {
  $('#all-links').prepend(
    "<div class='link' data-id='" + link.id + "'>"
    + "<h3><span contenteditable='true' class='title'>" + link.title + "</span>"
    + ": <a contenteditable='true' class='url' href='" + link.url + "'>"
    + link.url
    + "</a></h3></div>"
  );
}

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

function editUrl() {
  $('#all-links').on('click', '.url', function() {
    var linkElement = event.toElement;
    var urlElement = $(this).attr('contenteditable', 'true');
    urlElement.focus();
    urlElement.keypress(function() {
      if (event.keyCode === 13) {
        var $link = $(urlElement.parent().parent());
        var $url = linkElement.textContent;
        var linkParams = {link: { url: $url }};

        $.ajax({
          type: 'PUT',
          url: '/api/v1/links/' + $link.attr('data-id'),
          data: linkParams,
          success: function() {
            console.log("Success");
            $link.find('.url').text(linkParams.link.url);
          },
          error: function(xhr) {
            console.log(xhr.responseText);
          }
        });
      }
    });
  });
}
