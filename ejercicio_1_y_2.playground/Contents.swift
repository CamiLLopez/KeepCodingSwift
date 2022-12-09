import UIKit

func getPrimes (arrayPosition: Int) -> [Int] {
    
     let firstPrime = 2
     
     var numbers = Array(firstPrime...arrayPosition)

     var currentPrimeIndex = 0

     while currentPrimeIndex < numbers.count {
        
         let currentPrime = numbers[currentPrimeIndex]

         var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
         numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })
         numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)

         currentPrimeIndex += 1
     }

    if numbers.count == 100 {
     return numbers
    }
    else if numbers.count > 100{
        let firstHundredPrimes = Array(numbers[0...99])
        return firstHundredPrimes
    }

    return numbers
    
}
                                       
func printLastTenPrimes(primesArray: [Int]) {
        
    let primesReversed: [Int] = primesArray.reversed()
            
    print(primesReversed[0...9])
}
                                       
//Ejercicio 2) sumar los primeros 50 numeros primos

func sumPrimesNumbers(primesArray: [Int]) -> Int {

    var firstFiftyPrimes = Array(primesArray[0...49])
    var sumPrimes: Int = firstFiftyPrimes.reduce(0, +)

    return sumPrimes
}
                                 
                                 
let getRandomPrimes = getPrimes(arrayPosition: 600)
printLastTenPrimes(primesArray: getRandomPrimes)
sumPrimesNumbers(primesArray: getRandomPrimes)
 
 
 



