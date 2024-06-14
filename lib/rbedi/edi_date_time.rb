module RBEDI
  class EDIDateTime
    CCYYMMDD_STRFTIME = "%Y%m%d"
    YYMMDD_STRFTIME = "%y%m%d"
    HHMMSS_STRFTIME = "%H%M%S"
    HHMM_STRFTIME = "%H%M"
    DEFAULT_OFFSET = DateTime.now.strftime("%z")

    def initialize(datetime_start, datetime_end = nil)
      if datetime_start.is_a?(EDIDateTime)
        @datetime_start = datetime_start.datetime_start
        @datetime_end = datetime_start.datetime_end
      else
        @datetime_start = datetime_start
        @datetime_end = datetime_end
      end
    end

    def self.now
      new(DateTime.now)
    end

    def self.now_range
      new(DateTime.now, DateTime.now)
    end

    def self.parse(date: "", time: "", offset: DEFAULT_OFFSET)
      start_date, end_date = date.split("-")
      start_time, end_time = time.split("-")

      if start_date.blank?
        date_strftime = ""
      else
        date_strftime = CCYYMMDD_STRFTIME if start_date.length == 8
        date_strftime = YYMMDD_STRFTIME if start_date.length == 6
      end

      if start_time.blank?
        time_strftime = ""
      else
        time_strftime = HHMMSS_STRFTIME if start_time.length == 6
        time_strftime = HHMM_STRFTIME if start_time.length == 4
      end

      start_datetime = DateTime.strptime("#{start_date}#{start_time}#{offset}", date_strftime + time_strftime + "%z")
      end_datetime = end_date || end_time ? DateTime.strptime("#{end_date}#{end_time}#{offset}", date_strftime + time_strftime + "%z") : nil

      new(start_datetime, end_datetime)
    end

    def ccyymmdd
      @datetime_end ? "#{@datetime_start.strftime(CCYYMMDD_STRFTIME)}-#{@datetime_end.strftime(CCYYMMDD_STRFTIME)}" : @datetime_start.strftime(CCYYMMDD_STRFTIME)
    end

    def yymmdd
      @datetime_end ? "#{@datetime_start.strftime(YYMMDD_STRFTIME)}-#{@datetime_end.strftime(YYMMDD_STRFTIME)}" : @datetime_start.strftime(YYMMDD_STRFTIME)
    end

    def hhmmss
      @datetime_end ? "#{@datetime_start.strftime(HHMMSS_STRFTIME)}-#{@datetime_end.strftime(HHMMSS_STRFTIME)}" : @datetime_start.strftime(HHMMSS_STRFTIME)
    end

    def hhmm
      @datetime_end ? "#{@datetime_start.strftime(HHMM_STRFTIME)}-#{@datetime_end.strftime(HHMM_STRFTIME)}" : @datetime_start.strftime(HHMM_STRFTIME)
    end

    attr_accessor :datetime_start, :datetime_end
  end
end
