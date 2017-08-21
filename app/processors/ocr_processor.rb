class OCRProcessor
  PROCESSOR_LIST = [DocumentOcrProcessor, PtabOcrProcessor]

  def initialize
    @scheduler = Rufus::Scheduler.new
  end

  def schedule_ocr!
    PROCESSOR_LIST.each do |processor_klass|
      @scheduler.every(processor_klass::FREQUENCY) do
        begin
          processor_klass.new.process!
          ActiveRecord::Base.connection_pool.release_connection
        rescue => exception
          Rails.logger.error(exception)
        end
      end
    end
    @scheduler
  end
end