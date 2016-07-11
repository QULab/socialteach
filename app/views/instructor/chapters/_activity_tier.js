$(".btn").addClass('disabled');
$(".form-control").prop('disabled', true);
$("div.activity[data-node-id='<%=activity.id%>']").html("<%= j render 'instructor/chapters/activity_tier_form', activity: activity %>");
