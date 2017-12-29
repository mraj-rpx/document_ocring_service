class S3Downloader
  DEFAULT_THREAD_COUNT = 20
  DEFAULT_CHUNK_SIZE = 4096
  MODE = 'auto'

  def initialize(options = {})
    @s3_key = options[:s3_key]
    @bucket = options[:bucket]
  end

  def download
    downloader = Aws::S3::FileDownloader.new({client: Aws::S3::Client.new})
    tempfile = Tempfile.new([SecureRandom.hex(2), '.pdf'])

    download_options = {
      thread_count: DEFAULT_THREAD_COUNT,
      chunk_size: DEFAULT_CHUNK_SIZE,
      bucket: @bucket,
      key: @s3_key,
      mode: MODE
    }
    downloader.download(tempfile.path, download_options)
    tempfile
  end
end
