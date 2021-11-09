import personas.*
import marcas.*

class Carpa{

	var limiteAdmicion = 100
	var property tieneBandaDeMusica = false
	var property marca 
	const personas = []
	var recargo = recargoFijo

	method cantidadPersonas() = personas.size()

	method dejaEntrar(persona) = limiteAdmicion > self.cantidadPersonas() and not persona.estaEbrio()

	method bastanteLlena() =  self.cantidadPersonas() > limiteAdmicion / 2  
	
	method ingresarPersona(persona) {
		self.validarIngreso(persona)
		personas.add(persona)
	}
	method validarIngreso(persona){
		if (not persona.quiereEntrar(self)) 
			self.error("La persona no quiere entrar a la carpa") 
		if (not self.dejaEntrar(persona))
			self.error("La carpa no deja entrar a la persona")
	}
	method servirJarra(capacidad, persona) {
		self.validarPertenencia(persona)
		persona.tomarJarra(new Jarra(capacidad = capacidad, marca = marca, carpa = self))
	}

	method validarPertenencia(persona){
		if (not personas.contains(persona)) 
			self.error("La persona no está en la carpa")
	}
	method ebriosEmpedernidos() = personas.count{ per => per.esEmpedernido() }

	method esHomogenea() = personas.all{ per => per.nacionalidad() == personas.anyOne().nacionalidad() }
	
	method asistentesALosQueNoSeLesSirvio() = personas.filter({ per => not per.comproEn(self) })
	
	method precio() = marca.precio() * recargo.importe(self)
	
	method cantidadPersonasEbrias() = personas.count({ per => per.estaEbria() })
	
	method muchasPersonasEbrias() = self.cantidadPersonasEbrias() / self.cantidadPersonas() > 0.75

}

object recargoFijo {
	method importe(carpa) = 1.3
}

object recargoCantidad {
	method importe(carpa) = if (carpa.bastanteLlena()) 1.4 else 1.25
}

object recargoEbriedad {
	method importe(carpa) = if(carpa.muchasPersonasEbrias()) 1.5 else 1.2
}

