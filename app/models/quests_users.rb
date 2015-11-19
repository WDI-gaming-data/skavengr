class QuestsUsers < ActiveRecord::Base
  belongs_to :quest
  belongs_to :user
end
