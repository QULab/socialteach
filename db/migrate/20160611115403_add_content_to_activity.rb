class AddContentToActivity < ActiveRecord::Migration
  def change
    add_reference :activities, :content, polymorphic: true, index: true

    Activity.reset_column_information

    Activity.find_each do |act|
      act.content = ActivityLecture.new(text: "Empty lecture")
      act.save!
    end
    change_column_null :activities, :content_id, false
    change_column_null :activities, :content_type, false
  end
end
