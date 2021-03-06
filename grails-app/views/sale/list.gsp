<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, bootstrap-js, bootstrap-collapse, saleFilter, jquery-ui"/>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<div class="pull-right">
				<g:link action="createSaleToClient" class="btn btn-primary">Vender</g:link>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-9">
			<g:if test="${sales}">
				<h4>Ventas</h4>
				<table class="table table-hover">
					<thead>
						<th width="1">#</th>
						<th>
							<g:if test="${request.method == 'GET' || (!params?.from && !params?.to)}">
								Hora
							</g:if>
							<g:else>
								Fecha de venta
							</g:else>
						</th>
						<th>Cliente</th>
						<th>Total de compra</th>
						<th>Tipo de compra</th>
						<th>Vendedor</th>
					</thead>
					<tbody>
						<g:each in="${sales}" var="sale" status="index">
							<tr class="${sale.canceled ? 'active' : ''}">
								<td>
									<g:link action="show" id="${sale.id}">
										${index + 1}
									</g:link>
								</td>
								<td>
									<g:if test="${request.method == 'GET' || (!params?.from && !params?.to)}">
										<g:formatDate date="${sale.dateCreated}" formatName="hour.date.format"/>
									</g:if>
									<g:else>
										<g:formatDate date="${sale.dateCreated}" formatName="custom.date.format"/>
									</g:else>
								</td>
								<td>
									<g:if test="${sale.instanceOf(ni.sb.SaleToClient)}">
										${sale.client}
									</g:if>
								</td>
								<td>${sale.balance}</td>
								<td>
									<g:if test="${sale.instanceOf(ni.sb.SaleToClient)}">
										${sale.typeOfPurchase}
									</g:if>
									<g:else>
										Contado
									</g:else>
								</td>
								<td>${sale.user.fullName}</td>
							</tr>
						</g:each>
						<g:if test="${request.method == 'POST'}">
							<tr>
								<td colspan="3">MONTO</td>
								<td colspan="3">${amount}</td>
							</tr>
						</g:if>
					</tbody>
				</table>
			</g:if>
			<g:else>
				<h4>Sin ventas que mostrar</h4>
			</g:else>
		</div>

		<div class="col-md-3">
			<h4>Diario</h4>
			<table class="table">
				<tbody>
					<tr>
						<td>Monto vendido</td>
						<td>
							${todaySaleAmount}
						</td>
					</tr>
					<tr>
						<td>Monto gasto diario</td>
						<td>${amountOfDailyExpenses}</td>
					</tr>
					<tr>
						<td>Monto en caja</td>
						<td>${inBox}</td>
					</tr>
				</tbody>
			</table>

			<h4 id="filterSale" style="cursor:pointer;">Filtrar</h4>
			<div id="filterSales">
				<g:form action="list" >
					
					<h5>Fechas</h5>
					<div class="form-group">
						<label for="from" class="sr-only">Desde</label>
						<g:textField name="from" value="${params?.from}" class="form-control" placeholder="Desde"/>
					</div>
					<div class="form-group">
						<label for="to" class="sr-only">Hasta</label>
						<g:textField name="to" value="${params?.to}" class="form-control" placeholder="Hasta"/>
					</div>
					
					<h5>Clientes</h5>
					<g:select name="clients" from="${clients}" optionKey="id" multiple="true" class="form-control"/>

					<h5>Tipo de pago</h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="cash" value="Contado" checked="${params?.cash ? true : false}"/>
							Contado
						</label>
					</div>
					<div class="checkbox">
						<label>
							<g:checkBox name="credit" value="Credito" checked="${params?.credit ? true : false}"/>
							Credito
						</label>
					</div>

					<h5>Estado</h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="isPending" value="Pendiente" checked="${params?.isPending ? true : false}"/>
							Pendiente
						</label>
					</div>
					<div class="checkbox">
						<label>
							<g:checkBox name="isCanceled" value="Cancelado" checked="${params?.isCanceled ? true : false}"/>
							Cancelado
						</label>
					</div>

					<h5>Anulado</h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="canceled" value="true" checked="${params?.canceled ? true : false}"/>
							Anulado
						</label>
					</div>

					<h5>Vendedores</h5>
					<g:each in="${users}" var="user">
						<div class="checkbox">
							<label>
								<g:checkBox name="users" value="${user.id}" checked="${params?.users?.contains(user.id.toString()) ? true : false}"/>
								${user.fullName}
							</label>
						</div>
					</g:each>

					<g:submitButton name="filter" value="Filtrar" class="btn btn-primary btn-block"/>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
