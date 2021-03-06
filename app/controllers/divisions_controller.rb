class DivisionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:today]
  before_action :set_division, only: [:show, :edit, :update, :destroy, :random, :get_captians]
  before_action :set_batch

  def today
    @division = Division.today

    if !@batch
      redirect_to new_batch_path
    elsif @division
      # @timer = @challenge.minutes_to_string
      @timer = '0:10'
      @challenge = @division.latest_challenge || Challenge.new
      render :show
    else
      @division = Division.new
      render :new
    end
  end

  def get_captians
    @division.generate_group_captains!
    @groups = @division.groups
  end

  def teams
    @division = Division.today
  end

  def index
    @divisiones = Division.all
  end

  def show
    @challenge = Challenge.new
  end

  def new
    @division = Division.new
  end

  def edit
  end

  def create
    @division = Division.new(division_params)
    @division.batch = @batch

    if @division.save
      if @division.is_today
        redirect_to today_path, notice: 'division was successfully created.'
      else
        redirect_to division_path(@batch, @division), notice: 'division was successfully created.'
      end
    else
      render :new
    end
  end

  def update
    if @division.update(division_params)
      if @division.is_today
        redirect_to today_path, notice: 'division was successfully updated.'
      else
        redirect_to division_path(@batch, @division), notice: 'division was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @division.destroy
    redirect_to divisiones_url, notice: 'division was successfully destroyed.'
  end

  private
    def set_division
      @division = Division.find(params[:id])
    end

    def set_batch
      if params[:batch_id]
        @batch = Batch.find_by_id(params[:batch_id])
      elsif params[:batch_num]
        @batch = Batch.find_by_num(params[:batch_id])
      else
        @batch = Batch.find_by_num(97)
      end
    end

    def division_params
      params.require(:division).permit(:number_of_groups)
    end

end
