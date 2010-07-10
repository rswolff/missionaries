class MissionariesController < ApplicationController
  respond_to :html, :js
  
  # GET /missionaries
  # GET /missionaries.xml
  def index
    if params[:unit_id]
      unit_id = params[:unit_id]
      @awaiting_call = Missionary.in_unit(unit_id).awaiting_call
      @serving = Missionary.in_unit(unit_id).serving
      @call_received = Missionary.in_unit(unit_id).call_received
    else
      @awaiting_call = Missionary.awaiting_call
      @serving = Missionary.serving
      @call_received = Missionary.call_received      
    end
  end

  # GET /missionaries/1
  # GET /missionaries/1.xml
  def show
    @missionary = Missionary.find(params[:id])
  end

  # GET /missionaries/new
  # GET /missionaries/new.xml
  def new
    @missionary = Missionary.new
  end

  # GET /missionaries/1/edit
  def edit
    respond_with(@missionary = Missionary.find(params[:id]))
  end

  # POST /missionaries
  # POST /missionaries.xml
  def create
    respond_with(@missionary = Missionary.new(params[:missionary]))
  end

  # PUT /missionaries/1
  # PUT /missionaries/1.xml
  def update
    @missionary = Missionary.find(params[:id])
  end

  # DELETE /missionaries/1
  # DELETE /missionaries/1.xml
  def destroy
    @missionary = Missionary.find(params[:id])
    @missionary.destroy
  end
  
  def returned
    @missionaries = Missionary.returned
  end
  
  def receive_call
    @missionary = Missionary.find(params[:id])
    @missionary.receive_call
  end
  
  def enter_mission_call
    @missionary = Missionary.find(params[:id])
  end
  
  def set_apart
    @missionary = Missionary.find(params[:id])
  end
  
  def release
    @missionary = Missionary.find(params[:id])
  end
  
  def languages
    @languages = Missionary.languages
  end
  
  def map
    @markers = Missionary.serving.map {|missionary| [missionary.mission.lat, missionary.mission.lng]}
    render :layout => 'map'
  end

end
