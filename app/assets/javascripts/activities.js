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

$(document).ready(ready);
$(document).on('page:load', ready);
