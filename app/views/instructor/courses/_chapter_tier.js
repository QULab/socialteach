$(".btn").addClass('disabled');
$(".form-control").prop('disabled', true);
$("div.chapter[data-node-id='<%=chapter.id%>']").html("<%= j render 'instructor/courses/chapter_tier_form', chapter: chapter %>");
