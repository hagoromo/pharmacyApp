package ni.sb

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.webflow.execution.RequestContext
import org.springframework.webflow.execution.RequestContextHolder
import grails.converters.JSON

@Secured(["ROLE_ADMIN"])
class PurchaseOrderController {
  def presentationService

	static defaultAction = "list"
	static allowedMethods = [
		list:"GET",
    getPresentationsByProduct:"GET",
    getMeasuresByPresentation:"GET"
	]

  def list() {
  	[orders:PurchaseOrder.list()]
  }

  def createFlow = {
  	init {
  		action {
  			List<Item> items = []

  			[items:items]
  		}

  		on("success").to "createPurchaseOrder"
  	}

  	createPurchaseOrder {
  		on("confirm") {
  			params.deadline = params.date("deadline", "yyyy-MM-dd")
  			def purchaseOrder = new PurchaseOrder(params)

  			if (!purchaseOrder.validate()) {
  				purchaseOrder.errors.allErrors.each { error ->
  					log.error "[$error.field: $error.defaultMessage]"
  				}

  				return error()
  			}

  			[purchaseOrder:purchaseOrder]
  		}.to "administeredItems"

  		on("cancel").to "done"
  	}

  	administeredItems {
  		on("addItem") {
        def item = new Item(params)

        if (item.hasErrors()) {
          item.errors.allErrors.each { error ->
            log.error "[$error.field: $error.defaultMessage]"
          }

          return error()
        }
        flow.purchaseOrder.addToItems item

        flow.items << item
 			}.to "administeredItems"

 			on("deleteItem") {
        flow.items -= flow.items[params.int("index")]
			}.to "administeredItems"

			on("cancel").to "done"
  	}

  	done() {
  		redirect action:"list"
  	}
  }

  def getPresentationsByProduct(Integer productId) {
    def results = presentationService.presentationsByProduct productId

    if (!results) {
      render { status:false }
    } else {

      render results as JSON
    }
  }

  def getMeasuresByPresentation(Integer presentationId) {
    def results = presentationService.getMeasuresByPresentation(presentationId)

    if (!results) {
      render { status:false }
    } else {
      render results as JSON
    }
  }
}
