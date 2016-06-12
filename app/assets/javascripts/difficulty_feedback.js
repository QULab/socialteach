var ready = function() {

$('.feedback-container button').click(function(event){
  var data = JSON.stringify({answer: event.target.value});
  console.log(data)
  $.ajax({
          url:  "/completed_questionnaire/new",
          method: "POST",
          data: {answer: event.target.value},
          dataType: "json",
          success: function(data) {
            $('.feedback-container button').attr('disabled', true);
            $(event.target).addClass('btn-success');
          }
      });
    })
};

$(document).ready(ready);
$(document).on('page:load', ready);
