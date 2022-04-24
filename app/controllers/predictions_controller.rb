class PredictionsController < ApplicationController
  before_action :set_prediction, only: %i[ show ]
  before_action :set_rounds
  before_action :set_drivers
  before_action :authenticate_user!

  # GET /predictions or /predictions.json
  def index
    @latest_prediction = Prediction.latest_round_prediction_for(user: current_user)
    @latest_results_data = {
      top_five: Result.top_five_from_latest_round.map(&:driver),
      dnf: Result.dnf_from_latest_round.map(&:driver),
      round: Round.latest_round
    }
    @next_round_prediction = Prediction.next_round_prediction_for(user: current_user)
  end

  # GET /predictions/new
  def new
    @prediction = Prediction.new
  end

  # POST /predictions or /predictions.json
  def create
    attrs = prediction_params.merge({ user: current_user })
    attrs.delete(:authenticity_token)
    @prediction = Prediction.new(attrs)

    respond_to do |format|
      if @prediction.save
        format.html { redirect_to '/', notice: "Tu predicción se guardó correctamente." }
        format.json { render :show, status: :created, location: @prediction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_prediction
      @prediction = Prediction.find(params[:id])
    end

    def set_rounds
      @rounds ||= Round.remaining_rounds_of_current_season
    end

    def set_drivers
      @drivers ||= Driver.current_season.all.load
    end

    # Only allow a list of trusted parameters through.
    def prediction_params
      @permitted_params ||= params.require(:prediction).permit(:round_id).merge(
        params.permit(:authenticity_token, :first_id, :second_id, :third_id, :fourth_id, :fifth_id, :dnf_id)
      )
    end
end
