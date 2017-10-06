class BusPredictionsFormatter
  attr_reader :predictions, :formatted_predictions, :errors

  def initialize(raw_predictions)
    @predictions = raw_predictions
    @formatted_predictions = {}
    @errors = {}
  end

  def execute
    error_check
    return errors if errors.present?

    format_predictions
    formatted_predictions
  end

  private

  def error_check
    if prediction_error
      @errors['stop_number'] = prediction_error.fetch('stpid', nil)
      @errors['route']       = prediction_error.fetch('rt', nil)
      @errors['message']     = prediction_error.fetch('msg', nil)
    end
  end

  def prediction
    predictions['prd']&.first
  end

  def prediction_error
    predictions['error']&.first
  end

  def format_predictions
    @formatted_predictions['route']        = prediction.fetch('rt', nil)
    @formatted_predictions['stop_number']  = prediction.fetch('stpid', nil)
    @formatted_predictions['minutes']      = prediction.fetch('prdctdn', nil)
    @formatted_predictions['arrival_time'] = formatted_arrival_time
    @formatted_predictions['delayed']      = prediction.fetch('dly', nil)
    @formatted_predictions['distance']     = formatted_distance
    @formatted_predictions['vehicle_id']   = prediction.fetch('vid', nil)
  end

  def formatted_arrival_time
    prediction.fetch('prdtm', nil)&.to_datetime.strftime("%I:%M%p on %m/%d/%Y")
  end

  def formatted_distance
    prediction.fetch('dstp', nil)&.to_s + " feet away"
  end
end
