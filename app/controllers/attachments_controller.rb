class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end
  def download
    @attachment = Attachment.where(id: params[:id]).first
    if @attachment.present?
      if @attachment.data.present?
        send_data @attachment.data, type: 'text/plain', disposition: 'attachment', filename:'data.txt'
      else
        redirect_to attachments_url, alert: 'Attachment not converted yet.'
      end
    else
      redirect_to attachments_url, alert: 'Attachment not found, please try again later.'
    end
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)
    type = Type.where(id: params[:attachment][:type_id]).first

    respond_to do |format|
      if @attachment.save

        save_path = Rails.root.join('tmp', "#{@attachment.id}" + '.txt')
        File.open(save_path, 'wb') do |file|
          file << params[:attachment][:sequence]
        end

        saved_file = `sreformat #{type.name.downcase} #{Rails.root.join('tmp', "#{@attachment.id}" + '.txt')}`
        @attachment.update(data: saved_file)
        format.html { redirect_to @attachment, notice: 'Sequence was successfully converted.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:sequence, :type_id)
    end
end
