class Manager::ProductsController < Manager::ApplicationController

  respond_to :html

  # GET /manager/products
  def index
    @products = current_store.products
    @deleted_products = current_store.products.only_deleted
  end

  # GET /manager/products/new
  def new
    @product = current_store.products.build
  end

  # GET /manager/products/:id
  def show
    @product = Product.find(params[:id])
  end

  # POST /manager/products
  def create
    @product = current_store.products.build(product_params)
    if @product.save
      respond_with [:manager, @product], notice: t('manager.products.create.success')
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = t('manager.products.edit.success')
      respond_with [:manager, @product]
    else
      render :edit
    end
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to :back
  end
  
  def restore
    Product.restore(params[:id])
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :picture)
  end

end
