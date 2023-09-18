require 'csv'
class ImportRecordsController < ApplicationController
  before_action :set_import_record, only: %i[ show edit update destroy ]

  # GET /import_records or /import_records.json
  def index
    @import_records = current_user.import_records.all
  end

  # GET /import_records/1 or /import_records/1.json
  def show
  end

  # GET /import_records/new
  def new
    @import_record = ImportRecord.new
  end

  # GET /import_records/1/edit
  def edit
  end

  # POST /import_records or /import_records.json
  def create
    @import_record = ImportRecord.new(import_record_params)
    @import_record.user = current_user
    count = @import_record.do(current_user)
    @import_record.success = count

    respond_to do |format|
      if @import_record.save
        format.html { redirect_to import_record_url(@import_record), notice: "Import record was successfully created." }
        format.json { render :show, status: :created, location: @import_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /import_records/1 or /import_records/1.json
  def update
    respond_to do |format|
      if @import_record.update(import_record_params)
        format.html { redirect_to import_record_url(@import_record), notice: "Import record was successfully updated." }
        format.json { render :show, status: :ok, location: @import_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @import_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /import_records/1 or /import_records/1.json
  def destroy
    @import_record.destroy

    respond_to do |format|
      format.html { redirect_to import_records_url, notice: "Import record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_record
      @import_record = ImportRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def import_record_params
      params.require(:import_record).permit(:csv, :user_id, :success)
    end
end
