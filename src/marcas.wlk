class Marca {
	var property lupulo  
	var property pais
	var property precio 
	
}

class CervezaRubia inherits Marca {
	var property graduacion
}

class CervezaNegra inherits Marca {
	method graduacion() = mundo.graduacionReglamentaria().min(lupulo * 2)
}

class CervezaRoja inherits CervezaNegra {
	override method graduacion() = super() * 1.25
}

class Jarra {
	const property capacidad
	const property carpa
	const property marca 
	
	method alcohol() = capacidad * marca.graduacion() / 100
	
	method precio() = marca.precio() * capacidad
	
	method esGrande() = capacidad >= 1
	
	method pais() = marca.pais()
}

object mundo {
	var property graduacionReglamentaria = 1 
}
