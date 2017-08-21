class S3Downloader
  DEFAULT_THREAD_COUNT = 20
  DEFAULT_CHUNK_SIZE = 4096
  MODE = 'get_range'

  def initialize(options = {})
    @s3_key = options[:s3_key]
    @bucket = options[:bucket]
  end

  def download
    downloader = Aws::S3::FileDownloader.new({client: Aws::S3::Client.new})
    path = Rails.root.join("tmp/#{SecureRandom.uuid}")
    download_options = {
      thread_count: DEFAULT_THREAD_COUNT,
      chunk_size: DEFAULT_CHUNK_SIZE,
      bucket: @bucket,
      key: @s3_key,
      mode: MODE
    }
    downloader.download(path, download_options)
    path
  end
end
