class FtpServersController < ApplicationController
  before_action :set_ftp_server, only: [:show, :edit, :update, :destroy]

  # GET /ftp_servers
  # GET /ftp_servers.json
  def index
    @ftp_servers = FtpServer.all
  end

  # GET /ftp_servers/1
  # GET /ftp_servers/1.json
  def show
    @brand = @ftp_server.brand
  end

  # GET /ftp_servers/new
  def new
    @ftp_server = FtpServer.new
  end

  # GET /ftp_servers/1/edit
  def edit
  end

  # POST /ftp_servers
  # POST /ftp_servers.json
  def create
    @ftp_server = FtpServer.new(ftp_server_params)

    respond_to do |format|
      if @ftp_server.save
        format.html { redirect_to @ftp_server, notice: 'Ftp server was successfully created.' }
        format.json { render :show, status: :created, location: @ftp_server }
      else
        format.html { render :new }
        format.json { render json: @ftp_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ftp_servers/1
  # PATCH/PUT /ftp_servers/1.json
  def update
    respond_to do |format|
      if @ftp_server.update(ftp_server_params)
        format.html { redirect_to @ftp_server, notice: 'Ftp server was successfully updated.' }
        format.json { render :show, status: :ok, location: @ftp_server }
      else
        format.html { render :edit }
        format.json { render json: @ftp_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ftp_servers/1
  # DELETE /ftp_servers/1.json
  def destroy
    @ftp_server.destroy
    respond_to do |format|
      format.html { redirect_to ftp_servers_url, notice: 'Ftp server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submit_csv
    @ftp_server = FtpServer.find(params[:ftp_server_id])
    if CoOpReimbursementsSubmitter.new(@ftp_server, params[:ftp_server][:csv]).execute
      flash[:notice] = "Success"
    else
      flash[:alert] = "Error"
    end
    redirect_to ftp_server_path(@ftp_server)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ftp_server
      @ftp_server = FtpServer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ftp_server_params
      params.require(:ftp_server).permit(:brand_id, :url, :port, :username, :password)
    end
end
