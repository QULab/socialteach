class BaseController < InheritedResources::Base
  respond_to :json, :html
end
