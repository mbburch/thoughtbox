$(document).ready(function() {
  fetchLinks();
  editTitle();
  editUrl();
  searchLinks();
  showUnread();
  showRead();
  showAll();
  alphaSort();
});

function fetchLinks() {
  $.ajax({
    type: 'GET',
    url: '/api/v1/links',
    success: function(links) {
      $.each(links, function(index, link) {
        renderLink(link);
      });
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}

function renderLink(link) {
  $('#all-links').prepend(
    "<div class='link read-" + link.read + "' data-read='" + link.read + "'data-id='" + link.id + "'>"
    + "<h3><span contenteditable='true' class='title'>" + link.title + "</span>"
    + ": <a contenteditable='true' class='url' href='" + link.url + "'>"
    + link.url
    + "</a>" + read(link) + "</h3></div>"
  );
  listenForRead();
  listenForUnread();
}

function read(link) {
  if (link.read) {
    return '<button class="mark-unread">Mark As Unread</button>';
  } else if (!link.read) {
    return '<button class="mark-read">Mark As Read</button>';
  }
}

function listenForRead() {
  $('.mark-read').click(function(event) {
    event.preventDefault();
    var link = $(event.target).closest('.link');
    var button = $(event.target).closest('button');
    button.removeClass('mark-read');
    button.addClass('mark-unread');
    button.text('Mark As Unread');
    link.removeClass('read-false');
    link.addClass('read-true');
    updateLink(link, true);
  });
}

function listenForUnread() {
  $('.mark-unread').click(function(event) {
    event.preventDefault();
    var link = $(event.target).closest('.link');
    var button = $(event.target).closest('button');
    button.removeClass('mark-unread');
    button.addClass('mark-read');
    button.text('Mark As Read');
    link.removeClass('read-true');
    link.addClass('read-false');
    updateLink(link, false);
  });
}

function updateLink(link, status) {
  var linkParams = { link: { read: status } };
  $.ajax({
    type: "PUT",
    dataType: "json",
    url: "/api/v1/links/" + link.attr('data-id') + ".json",
    data: linkParams,
    success: function(){
      link.attr('data-read', linkParams.link.read);
    },
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

function searchLinks() {
  $('#search').keyup(function(){
    var searchFor = $('#search').val().toLowerCase();

    $('.link').each(function(index, link) {
      var title = $(link).find('.title').text().toLowerCase();
      var body  = $(link).find('.url').text().toLowerCase();
      var match = (title + body).indexOf(searchFor) !== -1;
      $(link).toggle(match);
    });
  });
}

function showUnread() {
  $('.view-unread').click(function(event) {
    $('.read-true').hide();
    $('.read-false').show();
  });
}

function showRead() {
  $('.view-read').click(function() {
    $('.read-false').hide();
    $('.read-true').show();
  });
}

function showAll() {
  $('.view-all').click(function() {
    $('.read-false').show();
    $('.read-true').show();
  });
}

function alphaSort() {
  $('.sort').click(function() {
    var links = $('#all-links').children();
    var sorted = links.sort(function(a, b) {
      return $(a).find('.title').text().toLowerCase() > $(b).find('.title').text().toLowerCase();
    });
    $('#all-links').html(sorted);
  });
}
