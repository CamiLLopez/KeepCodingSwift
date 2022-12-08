import UIKit

/* Crear un enumerado que permita indicar la posición en el campo de un jugador
 de fútbol, por ejemplo: Portero, Lateral Derecho, Central, Lateral Izquierdo,
 Mediocentro, Extremo Derecha, Extremo Izquierda, Delantero, etc */

enum FutbolPlayers {
    case portero
    case lateralDerecho
    case central
    case lateralIzquierdo
    case mediocentro
    case extremoDerecha
    case extremoIzquierda
    case delantero
    case defensaCentral
    case defensaLateral
    case mediocentroDefensivo
    
}

let messi: FutbolPlayers = .delantero
let tagliafico: FutbolPlayers = .lateralIzquierdo

