package ni.sb

class Item implements Serializable {
  Product product
  Integer quantity
  BigDecimal purchasePrice
  BigDecimal sellingPrice
  BigDecimal total

	Date dateCreated
	Date lastUpdated

  static constraints = {
    product nullable:false
    quantity nullable:false, min:1
    purchasePrice nullable:false, min:0.1, scale:2, validator:{ purchasePrice, item ->
      if (purchasePrice >= item.sellingPrice) {
        "notValid"
      }
    }
    sellingPrice nullable:false, min:0.1, scale:2
    total nullable:false
  }

  def beforeUpdate() {
    total = purchasePrice * quantity
    purchaseOrder.balance += total
  }

  static mapping = {
  	version false
  }

  static belongsTo = [purchaseOrder:PurchaseOrder]

  String toString() { product }
}
