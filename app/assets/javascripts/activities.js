(function() {
  var codeMirror;
  var ready = function() {
    var textArea = $('#lecture-text').get(0);
    if (textArea) {
    codeMirror = CodeMirror.fromTextArea(textArea,
        {
          mode: 'markdown',
          theme: 'ttcn',
          lineNumbers: true,
          lineWrapping: true,
          viewportMargin: Infinity,
        }
        );
  }};

  var set_textarea_content = function() {
    var textarea = $('#lecture-text');
    var text = codeMirror.doc.getValue();
    var preview = $('#preview-text');

    var api_url = textarea.data("markdown-api");
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
  $(document).on('page:load', add_event_handler);
})()

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}
