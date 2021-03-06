<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Distribuidores</title>
	<r:require modules="bootstrap-css, bootstrap-collapse"/>
</head>
<body>
	<div class="row">
		<div class="col-md-10">
			<g:if test="${dealers}">
				<g:each in="${dealers}" var="dealer">
					<h4><g:link action="show" params="[id:dealer.id]">${dealer.name}</g:link></h4>
					<table class="table table-condensed table-hover">
						<colgroup>
							<col span="1" style="width: 20%;">
							<col span="1" style="width: 80%;">
						</colgroup>
						<tbody>
							<g:each in="${dealer.telephones}" var="telephone">
								<tr>
									<td>${telephone.key.capitalize()}</td>
									<td>${telephone.value}</td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</g:each>
			</g:if>
			<g:else>
				<p>Nada que mostrar</p>
			</g:else>
		</div>
		<div class="col-md-2">
			<g:form action="list" autocomplete="off">
				<g:render template="form"/>
				<g:submitButton name="send" value="Agregar" class="btn btn-primary btn-block"/>
			</g:form>
		</div>
	</div>

	<style>
		.table tbody tr td, .table thead tr th {
    	border: none;
		}
	</style>
</body>
</html>