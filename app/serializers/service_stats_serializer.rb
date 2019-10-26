module ServiceStatsSerializer
  class MedicalService
    include ActionView::Helpers::NumberHelper
    attr_accessor :model, :starts_from, :ends_to

    def initialize(starts_from:, ends_to:)
      @starts_from = starts_from.to_time.beginning_of_day
      @ends_to = ends_to.to_time.end_of_day
    end

    def serializable_hash
      {
        direction: direction,
        count: current_record.count,
        prev: prev_record.count,
        diff_percentage: diff_percentage,
        range: range
      }
    end

    private

    def current_record
      @current_records ||= ClientRecord.where(created_at: starts_from..ends_to)
    end

    def prev_record
      diff = (ends_to.to_date - starts_from.to_date).to_i
      s = (starts_from - diff.days).beginning_of_day
      e = starts_from.end_of_day
      @prev_records ||= ClientRecord.where(
        created_at: s..e
      )
    end

    def direction
      if current_record.count > prev_record.count
        :up
      else
        :down
      end
    end

    def diff_percentage
      diff = if prev_record.count > current_record.count
              percent_of(current_record.count, prev_record.count)
            else
              percent_of(prev_record.count, current_record.count)
            end
      "#{direction == :up ? '+' : '-'}"\
      "#{number_to_percentage(diff, precision: 0)}"
    end

    def range
      "#{starts_from.strftime('%A, %B %e, %Y')} "\
      "- #{ends_to.strftime('%A, %B %e, %Y')}"
    end

    def percent_of(a, n)
      return 0 unless a > 0
      a.to_f / n.to_f * 100.0
    end
  end
end
