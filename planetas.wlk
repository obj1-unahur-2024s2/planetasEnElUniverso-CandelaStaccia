import personas.*
import construcciones.*


class Planeta {
    const property habitantes = []
    const property construcciones = []  

    method delegacionDiplomatica() {
        return (self.habitantesDestacados() + [self.habitanteConMasRecursos()]).asSet()
    }

    method habitantesDestacados() = habitantes.filter({h => h.esDestacada()})

    method habitanteConMasRecursos() = habitantes.max({h => h.recursos()})

    method esValioso() = construcciones.sum({c => c.valor()}) > 100

    method construir(unaConstruccion) {
        construcciones.add(unaConstruccion)
    }

    method trabajar(unTiempo) {
        self.delegacionDiplomatica().forEach({h => h.trabajar(self, unTiempo)})
    }

    method invadir(unPlaneta, unTiempo) {
       // self.obligarATrabajar(unPlaneta.delegacionDiplomatica(), unTiempo) //no va pq en trabajar hice un self.delegacion y obliga a la otra, no a la propia
        unPlaneta.delegacionDiplomatica().forEach({h => h.trabajar(self, unTiempo)})
    }

    /*
    method obligarATrabajar(unaDelegacion, unTiempo) {
        unaDelegacion.trabajar(unTiempo)
    }*/
}