$(document).on("turbolinks:load",function(){
  function buildHTML(comment){
        var html = "<div> new div</div>"//<div class="media">
                      // <div class="media-left">
                      //   <a href="/users/${comment.user_id}"><img alt="profile_photo" class="media-object" style="width: 64px; height: 64px;" src=${comment.avatar_url}>
                      //   </a></div>
                      //   <div class="media-body">
                      //     <h4 class="media-heading" id="top-aligned-media">
                      //       ${comment.user.name}
                      //       <a rel="nofollow" data-method="delete" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">削除</a>
                      //       <a href="/prototypes/${comment.prototype_id}/comments/${comment.id}/edit">編集</a>
                      //     </h4>
                      //     <p>
                      //       ${comment.content}
                      //     </p>
                      //   </div>
                      // </div>

  return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        let html = buildHTML(data);
        $('#comments').append(html)
        $('#comment_field').val('')
      })
      .fail(function(){
        alert('error');
      })
  });
});
