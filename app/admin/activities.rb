ActiveAdmin.register Activity do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :chapter
      f.input :tier
      f.input :shortname
      f.input :levelpoints
      f.input :predecessors
    end
    f.actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :chapter_id, :tier, :shortname, :levelpoints, predecessor_ids: []
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
