package ni.sb

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN", "ROLE_USER"])
class SaleController {
  def springSecurityService

	static defaultAction = "list"
	static allowedMethods = [
		list:"GET"
	]

  def list() {
  	def today = new Date()

  	[sales:Sale.salesFromTo(today, today + 1).list()]
  }

  def getItemsByProduct(Product product) {
    def query = Item.where {
      product == product
    }

    def items = query.list()

    items
  }

  def createSaleToClientFlow = {
    init {
      action {
        def clients = Client.where {
          status == true
        }

        [clients:clients.list()]
      }

      on("success").to "selectCustomer"
    }

    selectCustomer {
      on("confirm") { SelectCustomer command ->
        if (command.hasErrors()) {
          command.errors.allErrors.each { error ->
            log.error "[$error.field: $error.defaultMessage]"
          }

          return error()
        }

        [client:command.client, typeOfPurchase:command.typeOfPurchase]
      }.to "managePurchase"

      on("cancel").to "done"
    }

    managePurchase {
      on("selectCustomer").to "selectCustomer"
    }

    done() {
      redirect controller:"sale", action:"list"
    }
  }
}

class SelectCustomer implements Serializable {
  Client client
  String typeOfPurchase

  static constraints = {
    importFrom SaleToClient
  }
}

class SelectProductCommand implements Serializable {
  Product product

  static constraints = {
    product nullable:false, validator: { product ->
      if (!product.status) {
        "selectProductCommand.product.notValidProduct"
      }
    }
  }
}

class SaleDetailCommand implements Serializable {
  Item item
  Presentation presentation
  String measure
  Integer quantity
  BigDecimal total = 1

  static constraints = {
    importFrom SaleDetail
  }
}
