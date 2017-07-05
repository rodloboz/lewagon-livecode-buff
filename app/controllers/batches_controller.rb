class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy]

  def index
    @batches = Batch.all
  end

  def show
  end

  def new
    @batch = Batch.new
  end

  def edit
  end

  def create
    @batch = Batch.new(batch_params)

    if @batch.save
      redirect_to @batch, notice: 'Batch was successfully created.'
    else
      render :new
    end
  end

  def update
    if @batch.update(batch_params)
      redirect_to @batch, notice: 'Batch was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @batch.destroy
    redirect_to batches_url, notice: 'Batch was successfully destroyed.'
  end

  private
    def set_batch
      @batch = Batch.find(params[:id])
    end

    def batch_params
      params.fetch(:batch, {})
    end
end
