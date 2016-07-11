module ActivitiesHelper
  def activity_icon(activity)
    return "fa-book" if activity.content.is_a?(ActivityLecture)
    return "fa-graduation-cap" if activity.content.is_a?(ActivityAssessment)
    return "fa-check-square-o" if activity.content.is_a?(ActivityExercise)
    # return "fa-users" if activity.content.is_a?(ActivityChallenge)
    return "fa-question"
  end

  # parses mardown and outputs html
  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new(escape_html: true, safe_links_only: true)
    markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true)
    return markdown.render(text).html_safe
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    button_tag(name, onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "btn btn-success btn-block", type: 'button')
  end
end
