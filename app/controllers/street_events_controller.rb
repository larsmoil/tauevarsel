class StreetEventsController < ApplicationController
  # GET /street_events
  # GET /street_events.json
  def index
    @street_events = StreetEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @street_events }
    end
  end

  # GET /street_events/1
  # GET /street_events/1.json
  def show
    @street_event = StreetEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @street_event }
    end
  end

  # GET /street_events/new
  # GET /street_events/new.json
  def new
    @street_event = StreetEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @street_event }
    end
  end

  # GET /street_events/1/edit
  def edit
    @street_event = StreetEvent.find(params[:id])
  end

  # POST /street_events
  # POST /street_events.json
  def create
    @street_event = StreetEvent.new(params[:street_event])

    respond_to do |format|
      if @street_event.save
        format.html { redirect_to @street_event, notice: 'Street event was successfully created.' }
        format.json { render json: @street_event, status: :created, location: @street_event }
      else
        format.html { render action: "new" }
        format.json { render json: @street_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /street_events/1
  # PUT /street_events/1.json
  def update
    @street_event = StreetEvent.find(params[:id])

    respond_to do |format|
      if @street_event.update_attributes(params[:street_event])
        format.html { redirect_to @street_event, notice: 'Street event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @street_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /street_events/1
  # DELETE /street_events/1.json
  def destroy
    @street_event = StreetEvent.find(params[:id])
    @street_event.destroy

    respond_to do |format|
      format.html { redirect_to street_events_url }
      format.json { head :no_content }
    end
  end
end
