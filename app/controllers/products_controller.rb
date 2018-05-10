class ProductsController < ApplicationController
  before_action :set_user

  # GET /products
  # GET /products.json
  def index
    @products = @user.products
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @products }
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product=@user.products.find(params[:id])
  end

  # GET /products/new
  def new
    @user=User.find(params[:user_id])
    @product = @user.products.new
  end

  # GET /products/1/edit
  def edit
    @product=@user.products.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @user=User.find(params[:user_id])
    @product = @user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to user_products_path(@user), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product=@user.products.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to user_products_path(@user), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product=@user.products.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to user_products_path(@user), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :weight, :price, :user_id)
    end
end
