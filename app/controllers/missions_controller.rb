class MissionsController < ApplicationController
  respond_to :html, :js
  # GET /missions
  # GET /missions.xml
  def index
    @missions = Mission.all
  end

  # GET /missions/1
  # GET /missions/1.xml
  def show
    @mission = Mission.find(params[:id])
    respond_with(@mission) do |format|
      format.js {@mission.to_json}
    end
  end

  # GET /missions/new
  # GET /missions/new.xml
  def new
    @mission = Mission.new
  end

  # GET /missions/1/edit
  def edit
    @mission = Mission.find(params[:id])
  end

  # POST /missions
  # POST /missions.xml
  def create
    @mission = Mission.new(params[:mission])
    if @mission.save
      respond_with(@mission) do |format|
        format.js {  
          missions = Array.new

          Mission.all.each do |m|      
            mission = Hash.new
            mission[:id] = m.id
            mission[:name] = m.name           
          
            if m.id == @mission.id
              mission[:selected] = "true"
            else
              mission[:selected] = "false"
            end
          
            missions << mission
          end
        
          render :json => missions.sort_by { |mission| mission[:name]}
        }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.xml
  def update
    @mission = Mission.find(params[:id])
  end

  # DELETE /missions/1
  # DELETE /missions/1.xml
  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy
  end
end
