$(document).on("turbolinks:load",function(){
    $(`.upload-fields`).on("change", function(){
      if (this.files && this.files[0]) {
        let img = $(this).siblings('img')
        let obj = new FileReader();
        obj.onload = function(data){
          img.attr('src', data.target.result);
        }
        obj.readAsDataURL(this.files[0]);
      };
    });
});
