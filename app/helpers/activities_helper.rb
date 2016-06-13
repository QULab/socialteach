module ActivitiesHelper
  def activity_icon(activity)
    return "fa-book" if activity.content.is_a?(ActivityLecture)
    return "fa-question"
  end

  # parses mardown and outputs html
  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new(escape_html: true, safe_links_only: true)
    markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true)
    return markdown.render(text).html_safe
  end
end
