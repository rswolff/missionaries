class MissionsController < ApplicationController
  # GET /missions
  # GET /missions.xml
  def index
    @missions = Mission.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missions }
    end
  end

  # GET /missions/1
  # GET /missions/1.xml
  def show
    @mission = Mission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js {
        #@mission.mailing_address = RedCloth.new(@mission.mailing_address).to_html
        render :json => {:address => @mission.mailing_address}
      }
    end
  end

  # GET /missions/new
  # GET /missions/new.xml
  def new
    @mission = Mission.new

    respond_to do |format|
      format.html {
        render :layout => 'modal_form'
      }
      
    end
  end

  # GET /missions/1/edit
  def edit
    @mission = Mission.find(params[:id])
  end

  # POST /missions
  # POST /missions.xml
  def create
    @mission = Mission.new(params[:mission])

    respond_to do |format|
      if @mission.save
        format.html { redirect_to(@mission, :notice => 'Mission was successfully created.') }
        format.js   { 
          
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
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.xml
  def update
    @mission = Mission.find(params[:id])

    respond_to do |format|
      if @mission.update_attributes(params[:mission])
        format.html { redirect_to(@mission, :notice => 'Mission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.xml
  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy

    respond_to do |format|
      format.html { redirect_to(missions_url) }
      format.xml  { head :ok }
    end
  end
end
