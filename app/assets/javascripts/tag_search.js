$(document).on("turbolinks:load",function(){
  function appendTag(tag){
    var html = "<div> new div</div>" //
// <a href="/tags/${tag.name}">${tag.name}</a>
//
  $("#tag-search-result").append(html);
  };

  function appendNoTag(tag){
    var html = "<div> new div</div>"//
// <p class="tag__name">${tag}</p>
//
    $("#tag-search-result").append(html);
  };

  $("#tag-search-field").on("keyup", function(){
    var input = $("#tag-search-field").val();
    console.log(input)
    if (input.length !== 0){
      $.ajax({
        type: 'GET',
        url: '/tags/search',
        data: { keyword: input },
        dataType: 'json',
      })
      .done(function(tags){
        $("#tag-search-result").empty();
        if (tags.length !== 0){
          tags.forEach(function(tag){
          appendTag(tag);
          });
        }
        else {
          appendNoTag("一致するタグはありません");
        };
      })
      .fail(function(){
        alert("タグ検索に失敗しました")
      })
    }
  });
});
