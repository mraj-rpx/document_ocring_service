FactoryGirl.define do
  factory :pat_assign, class: PatAssignmentAttachment do
    sequence(:id)
    sequence(:assignment_id)
    s3_pdf_url 's3://rpx-docs/a.pdf'
  end
end
