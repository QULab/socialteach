(function() {
  var ready = function() {
    var codeMirror = CodeMirror.fromTextArea($('#lecture-text').get(0),
        {
          mode: 'markdown',
          theme: 'ttcn',
          lineNumbers: true,
          lineWrapping: true,
          viewportMargin: Infinity,
        }
        );
  };

  var set_textarea_content = function() {
    var codemirror = $('#lecture-text');
    var text = codemirror.val();
    var preview = $('#preview-text');

    var api_url = codemirror.data("markdown-api");
    if (api_url) {
      $.post(api_url, { "text": text }, function(data) {
        preview.html(data);
      });
    } else {
      preview.html(text)
    }
  }

  var add_event_handler = function() {
    $("#toggle-preview-link").on("click", function() {
      set_textarea_content();
    });
  };

  $(document).ready(ready);
  $(document).ready(add_event_handler);
  $(document).on('page:load', ready);
})()

