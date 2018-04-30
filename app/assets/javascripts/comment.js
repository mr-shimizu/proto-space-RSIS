$(document).on("turbolinks:load",function(){
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
