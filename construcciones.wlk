class Construccion {
    method valor()
} //?


class Muralla inherits Construccion {
    const longitud

    override method valor() = 10 * longitud
}

class Museo inherits Construccion {
    const superficie
    const property indiceImportancia

    method initialize() {
        if(not indiceImportancia.between(1, 5))
            self.error("No se puede instanciar")
    }

    override method valor() = superficie * self.indiceImportancia()
}