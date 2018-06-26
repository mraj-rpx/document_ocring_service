class S3Uploader
  def initialize(ocr_text)
    @ocr_text = ocr_text
  end

  def save_to_s3(s3_key, opts = {})
    bucket_name = opts[:bucket_name]
    bucket_name = ENV['AWS_OCR_BUCKET'] if bucket_name.blank?

    s3_resource = Aws::S3::Resource.new
    s3_object = s3_resource.bucket(bucket_name).object(s3_key)
    s3_object.put(body: @ocr_text)
  end
end
