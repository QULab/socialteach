var ready = function() {

$('.feedback-container button').click(function(event){
  var data = JSON.stringify({answer: event.target.value});
  console.log(data)
  $.ajax({
          url:  window.location.href.replace('/result', '') + "/feedback",
          method: "POST",
          data: {answer: event.target.value},
          dataType: "json",
          success: function() {
            $('.feedback-container button').attr('disabled', true);
            $(event.target).addClass('btn-success');
          }
      });
    })
};

$(document).ready(ready);
$(document).on('page:load', ready);
