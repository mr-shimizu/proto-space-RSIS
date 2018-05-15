$(document).on("turbolinks:load",function(){
  function buildHTML(comment){
        var html =
          "<div class='media'>\n" +
            "<div class='media-left'>\n" +
              "<a href=/users/" + comment.user_id + ">\n" +
                "<img alt='profile_photo' class='media-object' style='width: 64px; height: 64px;' src=" + comment.avatar_url +">\n" +
              "</a>\n" +
            "</div>\n" +
            "<div class='media-body'>\n" +
              "<h4 class='media-heading' id='top-aligned-media'>\n" +
                comment.user.name + "\n" +
                "<a rel='nofollow' data-method='delete' href=/prototypes/" + comment.prototype_id + "/comments/" +comment.id +">削除</a>\n" +
                "<a href=/prototypes/" + comment.prototype_id + "/comments/" + comment.id +"/edit>編集</a>\n" +
              "</h4>\n" +
              "<p>\n" +
                comment.content + "\n" +
              "</p>\n" +
            "</div>\n" +
          "</div>"
  return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        var html = buildHTML(data);
        $('#comments').append(html)
        $('#comment_field').val('')
      })
      .fail(function(){
        alert('error');
      })
  });
});
