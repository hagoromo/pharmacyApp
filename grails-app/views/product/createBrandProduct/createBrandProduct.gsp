<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Crear Producto de marca</title>
	<r:require modules="bootstrap-css, bootstrap-collapse, app"/>
</head>
<body>
	<g:render template="toolbar"/>
	<ul class="nav nav-tabs">
		<li class="${actionName == 'createProduct' ? 'active' : ''}">
			<g:link event="createProduct" params="[providerId:providerId]">Producto</g:link>
		</li>
		<li class="${actionName == 'createMedicine' ? 'active' : ''}">
			<g:link event="createMedicine" params="[providerId:providerId]">Medicamento</g:link>
		</li>
		<li class="${actionName == 'createBrandProduct' ? 'active' : ''}">
			<g:link event="createBrandProduct" params="[providerId:providerId]">Marca</g:link>
		</li>
	</ul>
	<br>

	<div class="row">
		<div class="col-md-6">
			<g:form autocomplete="off">
				<g:hiddenField name="providerId" value="${providerId}"/>
				<g:render template="form"/>
			
				<g:submitButton name="confirm" value="Agregar" class="btn btn-primary"/>
			</g:form>
			<br>
			
			<g:form autocomplete="off">
				<div class="form-group">
					<input list="brands" name="brand" id="brand" class="form-control" placeholder="Marcas">
					<datalist id="brands">
						<g:each in="${brands}" var="brand">
							<option value="${brand}">
						</g:each>
					</datalist>
				</div>
			
				<g:submitButton name="addBrand" value="Agregar marca" class="btn btn-primary"/>
			</g:form>
		</div>

		<div class="col-md-6">
			<g:each in="${brandsAndDetails}" var="brand">
				<div class="row">
					<div class="col-md-6">${brand.keySet()}</div> 
					<div class="col-md-6">
						<g:link event="deleteBrand" params="[brand:brand]" class="btn btn-default btn-xs pull-right">
							<span class="glyphicon glyphicon-trash"></span>
						</g:link>
					</div>
				</div>

				<g:form>
					<g:hiddenField name="brand" value="${brand.keySet()}"/>
					<div class="form-group">
						<g:textField name="measure" class="form-control input-sm" placeholder="Medida"/>
					</div>

					<g:submitButton name="addMeasure" value="Agregar medida" class="btn btn-primary btn-xs"/>
				</g:form>

				<g:each in="${brand.values()}" var="measure">
					
				</g:each>
			</g:each>
		</div>
	</div>
</body>
</html>
