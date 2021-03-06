package ni.sb

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class BrandController {
	static defaultAction = "show"
	static allowedMethods = [
		show:"GET",
		update:"POST",
    delete:"GET",
    addBrand:"POST"
	]

  def show(Integer id) {
  	def brandProduct = BrandProduct.get id

  	if (!brandProduct) {
  		response.sendError 404
  	}

    def brands = brandProduct.brands
  	def distinctBrands = Brand.distinctBrands.list()
    def availableBrands = distinctBrands - brands.name

  	[brandProduct:brandProduct, brands:brands, availableBrands:availableBrands]
  }

  //@params id: brandProduct id
  def update(Integer id) {
  	def brandProduct = BrandProduct.get id

  	if (!brandProduct) {
  		response.sendError 404
  	}

  	brandProduct.name = params?.name

  	if (!brandProduct.save()) {
  		chain action:"show", params:[id:id]
  		return
  	}

  	flash.message = "Producto actualizado"
  	redirect action:"show", id:id
  }

  def delete(Integer id) {
    def brand = Brand.get id

    if (!brand) {
      response.sendError 404
    }

    def brandProduct = brand.brandProduct

    brandProduct.removeFromBrands brand

    redirect action:"show", id:brandProduct.id
  }

  //@params id: brandProduct id
  def addBrand(Integer id) {
    def brandProduct = BrandProduct.get id

    if (!brandProduct) { response.sendError 404 }

    if (params?.brand && params?.details) {
      def details = params?.details?.tokenize(",")
      def brand = new Brand(name:params?.brand, details:details)

      brandProduct.addToBrands brand
      brandProduct.save(flush:true)
    }

    redirect action:"show", id:id
  }
}
