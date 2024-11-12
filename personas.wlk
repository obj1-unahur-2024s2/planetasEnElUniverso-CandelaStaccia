import construcciones.*
class Persona {
    var monedas = 20
    var edad
    const property inteligencia

    method recursos() = monedas

    method esDestacada() = edad.between(18, 65) || monedas > 30

    method ganarMonedas(unaCantidad) {
        monedas = monedas + unaCantidad
    }

    method gastarMonedas(unaCantidad) {
        monedas = 0.max(monedas - unaCantidad)
    }

     method cumplirAnios() {
        edad = edad + 1
    }

    method trabajar(unPlaneta, unTiempo) {}
}


class Productor inherits Persona {
    const property tecnicas = ["cultivo"] 

    override method recursos() = super() * tecnicas.size()

    override method esDestacada() = super() || tecnicas.size() > 5

    method conoce(unaTecnica) = tecnicas.contains(unaTecnica)

    method realizarTecnica(unaTecnica, unTiempo) {
        if(self.conoce(unaTecnica))
            self.ganarMonedas(unTiempo * 3)
        else
            self.gastarMonedas(1)
    }

    method aprender(unaTecnica) {
        tecnicas.add(unaTecnica)
    }

    method viveEn(unPlaneta) = unPlaneta.habitantes().contains(self)

    override method trabajar(unPlaneta, unTiempo) {
        if(self.viveEn(unPlaneta))
            self.realizarTecnica(tecnicas.last(), unTiempo)
    }
}


class Constructor inherits Persona {
    var construcciones 
    const region

    override method recursos() = super() + 10 * construcciones

    override method esDestacada() = construcciones > 5

    override method trabajar(unPlaneta, unTiempo) {
        unPlaneta.construir(region.construccion(self, unTiempo))
        self.gastarMonedas(5)
        self.registrarConstruccion() //self.ganarMonedas(1)
    }

    method registrarConstruccion() {
        construcciones = construcciones + 1
    }
}

object montania {
    method construccion(unConstructor, unTiempo) {
        return new Muralla(longitud = unTiempo / 2)
    }
}

object costa {
    method construccion(unConstructor, unTiempo) {
        return new Museo(superficie = unTiempo, indiceImportancia = 1)
    }
}

object llanura {
    method construccion(unConstructor, unTiempo) {
        if(unConstructor.esDestacada()) {
            return new Museo(superficie = unTiempo, indiceImportancia = 3) // con un nivel entre 1 y 5, proporcional a sus recursos??
        }      
        else {
            return new Muralla(longitud = unTiempo / 2)
        }
            
    }
}

object ciudad {
    method construccion(unConstructor, unTiempo) {
        if(unConstructor.inteligencia().between(20, 80))
            return new Museo(superficie = unTiempo * 2, indiceImportancia = 4)
        else 
            return new Muralla(longitud = 0.max(unTiempo - 20))
    }
}