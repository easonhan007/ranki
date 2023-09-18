# == Schema Information
#
# Table name: import_records
#
#  id         :integer          not null, primary key
#  csv        :text
#  user_id    :integer          not null
#  success    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ImportRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
