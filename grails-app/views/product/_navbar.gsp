<ul class="nav nav-tabs">
	<li class="${actionName == 'createProduct' ? 'active' : ''}">
		<g:link action="createProduct" params="[providerId:providerId]">Producto</g:link>
	</li>

	<li class="${actionName == 'createMedicine' ? 'active' : ''}">
		<g:link action="createMedicine" params="[providerId:providerId]">Medicamento</g:link>
	</li>
</ul>
<br>
