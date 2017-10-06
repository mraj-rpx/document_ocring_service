class S3Uploader
  def initialize(ocr_text)
    @ocr_text = ocr_text
  end

  def save_to_s3(s3_key)
    s3_resource = Aws::S3::Resource.new
    s3_object = s3_resource.bucket(ENV['AWS_OCR_BUCKET']).object(s3_key)
    s3_object.put(body: @ocr_text)
  end
end
