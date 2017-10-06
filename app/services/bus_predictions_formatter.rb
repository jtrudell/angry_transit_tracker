class BusPredictionsFormatter
  attr_reader :predictions, :format_predictions, :errors

  def initialize(raw_predictions)
    @predictions = raw_predictions
    @formatted_predictions = nil
    @errors = nil
  end

  def execute
    error_check
    return errors if errors.present?

    format_predictions
  end

  private

  def error_check
    if predictions['error']
      @errors = predictions['error'].first
      @errors['stop_number'] = @errors.delete('stpid')
      @errors['route'] = @errors.delete('rt')
      @errors['message'] = @errors.delete('msg')
    end
  end

  def format_predictions
    prediction = predictions['prd'].first
    formatted_prediction = {}
    formatted_prediction['route'] = prediction['rt']
    formatted_prediction['stop_number'] = prediction['stpid']
    formatted_prediction['minutes'] = prediction['prdctdn']
    formatted_prediction['arrival_time'] = prediction['prdtm'].to_datetime.strftime("%I:%M%p on %m/%d/%Y")
    formatted_prediction['delayed'] = prediction['dly']
    formatted_prediction['distance'] = prediction['dstp'].to_s + " feet away"
    formatted_prediction['vehicle_id'] = prediction['vid']
    formatted_prediction
  end
end
