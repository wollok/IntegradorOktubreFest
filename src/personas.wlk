import carpas.*

class Persona {

	var peso = 70
	const jarras = []
	var property leGustaMusicaTradicional = false
	var aguante = 1
	var property pais

	method alcoholIngerido() = jarras.sum{ j => j.alcohol() }

	method estaEbrio() {
		return self.alcoholIngerido() * peso > aguante
	}


	method quiereEntrar(carpa) = pais.leGusta(carpa) and self.leGustaMusicaTradicional() == carpa.tieneBandaDeMusica()

	method tomarJarra(jarra) {
		jarras.add(jarra)
	}

	method esEmpedernido() = self.estaEbrio() and jarras.all({ jarra => jarra.esGrande() })

	method esPatriota() = jarras.all({ jarra => jarra.pais() == self.pais() })

	method sesCompatibleCon(otra) = self.cantidadMarcasIguales(otra) > self.marcasCompradas().size()/2
	method cantidadMarcasIguales(otra) = self.marcasCompradas().count{marca=> otra.comproMarca(marca)}
	method comproMarca(marca) = self.marcasCompradas().contains(marca)
	method marcasCompradas() = jarras.map{jarra=>jarra.marca()}.asSet()
	
	method carpasDondeComproCerveza() = jarras.map{ jarra => jarra.carpa()}.asSet()
	
	method estaEntrandoEnVicio() = (1..jarras.size()).all({ pos => jarras.get(pos).capacidad() >= jarras.get(pos - 1).capacidad() })

	method gastoTotal() = jarras.sum{ jarra =>  jarra.precio()}
	
	method cervezaMasCara() = jarras.max{ jarra =>  jarra.precio()}
}

object belgica {
	method leGusta(carpa)  = carpa.marca().lupulo() > 4
}

object republicaCheca {
	method leGusta(carpa) = carpa.marca().graduacion() > 8
}

object alemania { 
	method leGusta(carpa) = carpa.cantidadPersonas().even()
}
