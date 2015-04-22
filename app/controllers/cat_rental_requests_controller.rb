class CatRentalRequestsController < ApplicationController
  before_action :set_cat_rental_request, only: [:show, :approve, :deny, :destroy]
  before_action :ensure_cat_ownership, only: [:approve, :deny]

  # GET /cat_rental_requests
  # GET /cat_rental_requests.json
  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  # GET /cat_rental_requests/1
  # GET /cat_rental_requests/1.json
  def show
  end
  
  def approve
    current_request = CatRentalRequest.find_by_id(params[:id])
    current_request.approve!
    flash[:notices] = "Rental request successfully approved"
    redirect_to cat_rental_requests_url(current_request)
  end
  
  def deny
    current_request = CatRentalRequest.find_by_id(params[:id])
    current_request.deny!    
    flash[:notices] = "Rental request successfully denied"    
    redirect_to cat_rental_requests_url(current_request)
  end

  # GET /cat_rental_requests/new
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  # GET /cat_rental_requests/1/edit
  def edit
  end

  # POST /cat_rental_requests
  # POST /cat_rental_requests.json
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.renter_id = current_user.id
    respond_to do |format|
      if @cat_rental_request.save!
        format.html { redirect_to @cat_rental_request, notice: 'Cat rental request was successfully created.' }
        format.json { render :show, status: :created, location: @cat_rental_request }
      else
        flash[:notice]="Rental request unsuccessful"
         format.html { render :new }
         format.json { render json: @cat_rental_request.errors, status: :unprocessable_entity }
       end
    end
  end

  # PATCH/PUT /cat_rental_requests/1
  # PATCH/PUT /cat_rental_requests/1.json
  def update
    respond_to do |format|
      if @cat_rental_request.update(cat_rental_request_params)
        format.html { redirect_to @cat_rental_request, notice: 'Cat rental request was successfully updated.' }
        format.json { render :show, status: :ok, location: @cat_rental_request }
      else
        format.html { render :edit }
        format.json { render json: @cat_rental_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cat_rental_requests/1
  # DELETE /cat_rental_requests/1.json
  def destroy
    @cat_rental_request.destroy
    respond_to do |format|
      format.html { redirect_to cat_rental_requests_url, notice: 'Cat rental request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def ensure_cat_ownership
      unless current_user == @cat_rental_request.cat.owner
        flash[:notices] = "Not your cat"
        redirect_to cats_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_cat_rental_request
      @cat_rental_request = CatRentalRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_rental_request_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    end
end
