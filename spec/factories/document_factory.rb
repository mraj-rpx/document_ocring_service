FactoryGirl.define do
  factory :document do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'documents', 'test.pdf'), 'text/pdf') }
  end
end
