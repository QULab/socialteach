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

  def get_last_completed(questionnaire)
    questionnaire.completed_questionnaires.where(user_id: current_user.id).order("created_at").last
  end

  def given_answer_status(completed_question, answer)
    answer_given = given_answer?(completed_question, answer)
    if answer.correct
      return 'correct' if answer_given
      return 'missing'
    else
      return 'wrong' if answer_given
      return 'ok'
    end
  end

  def given_answer?(completed_question, answer)
    completed_question.answers.include?(answer)
  end

# counts the correct amount of answers and returns the ratio between total questions and correct answers
  def calc_ratio_of_correct_answers(questionnaire)
    user_id = current_user.id
    @question_counter = 0
    @correct_answers_counter = 0

    # Iterate over questionare and get the questions
    questionnaire.m_questions.each_with_index do |question, i|
          
      CompletedMQuestion.create(
            m_question_id: question.id, 
            user_id: user_id, 
            answer_id: params[:question][i.to_s.to_sym][:answer_id])
        
      # retrieve answers of the user and the correct answer for the question
      answer_id = params[:question][i.to_s.to_sym][:answer_id]
      correct_answer_id = question.correct_answer_id
  
      # compare user input and actual correct answer
      if answer_id.to_i == correct_answer_id.to_i
        @correct_answers_counter += 1
      end
          
      # DEBUG
      logger.debug "Question: #{question.text}"
      logger.debug "Question-ID: #{question.id}"
      logger.debug "Answer-ID: #{answer_id}"
      logger.debug "Correct-Answer-ID: #{correct_answer_id}"
          
      @question_counter += 1
    end
      
    @ratio = calc_correct_answer_ratio(@question_counter, @correct_answers_counter)
        
    end
    
    
    def calc_correct_answer_ratio(total_amount_of_questions, total_amount_of_correct_answers)
       
        logger.debug "Total amount of questions: #{total_amount_of_questions}"
        logger.debug "Total amount of correct answers #{total_amount_of_correct_answers}"
        ratio = total_amount_of_correct_answers.to_f/total_amount_of_questions.to_f
        
        logger.debug "Ratio: #{ratio}" 
        
        ratio.to_f
    end
    
    
    
    
    
=begin
    course_enrollment and activity have an difficulty level.
    An course_enrollment has the default difficulty level of 3
    The difficulty scala starts from 0 and goes up to 5.
    the difficulty level 0 can be compared to the diffidulty "very easy"
    and the difficulty level 5 can be compared to "very difficult" tasks.
=end
    
    # ratio - percentage of correct answers
    def difficulty_adaption_ruleset(ratio)
        
        # no change of difficulty level of the course
        difficulty_adaption = 0
        
        if (ratio >= 0.9)
           
            difficulty_adaption = 2
        
        # 0.6 - 0.9
        elsif ratio >= 0.6 and ratio < 0.9
            
            difficulty_adaption = 1
            
        # 0.3 - 0.6
        elsif ratio >= 0.3 and ratio < 0.6
            
            difficulty_adaption = 0
        
        # 0.1 - 0.3
        elsif ratio >= 0.1 and ratio < 0.3
            difficulty_adaption = -1
            
        # 0 - 0.1
        else ratio >= 0 and ratio < 0.1 
            
            difficulty_adaption = -2
        end
        
        logger.debug "Difficulty-Adaption-Value: #{difficulty_adaption}"
        difficulty_adaption
    end

end
