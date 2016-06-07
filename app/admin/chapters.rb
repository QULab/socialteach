ActiveAdmin.register Chapter do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :course
      f.input :tier
      f.input :shortname
      f.input :predecessors
      f.input :successors
    end
    f.actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :description, :course_id, :tier, :shortname, predecessors: [], successors: []
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
