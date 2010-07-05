class MissionariesController < ApplicationController
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
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missionaries }
    end
  end

  # GET /missionaries/1
  # GET /missionaries/1.xml
  def show
    @missionary = Missionary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @missionary }
    end
  end

  # GET /missionaries/new
  # GET /missionaries/new.xml
  def new
    @missionary = Missionary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @missionary }
    end
  end

  # GET /missionaries/1/edit
  def edit
    @missionary = Missionary.find(params[:id])  
  end

  # POST /missionaries
  # POST /missionaries.xml
  def create
    @missionary = Missionary.new(params[:missionary])

    respond_to do |format|
      if @missionary.save
        format.html { redirect_to(@missionary, :notice => 'Missionary was successfully created.') }
        format.xml  { render :xml => @missionary, :status => :created, :location => @missionary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @missionary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /missionaries/1
  # PUT /missionaries/1.xml
  def update
    @missionary = Missionary.find(params[:id])

    respond_to do |format|
      if @missionary.update_attributes(params[:missionary])
        format.html { redirect_to(@missionary, :notice => 'Missionary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @missionary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /missionaries/1
  # DELETE /missionaries/1.xml
  def destroy
    @missionary = Missionary.find(params[:id])
    @missionary.destroy

    respond_to do |format|
      format.html { redirect_to(missionaries_url) }
      format.xml  { head :ok }
    end
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
    respond_to do |format|
      format.html {
        render :layout => 'modal_form'
      }
    end
  end
  
  def release
    @missionary = Missionary.find(params[:id])
    respond_to do |format|
      format.html {
        render :layout => 'modal_form'
      }
    end    
  end
  
  def languages
    @languages = Missionary.languages
  end

end
