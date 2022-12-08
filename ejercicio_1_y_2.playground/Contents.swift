import UIKit

func getPrimes: (arrayPosition: Int) -> [Int] = {
    
     let firstPrime = 2
     guard rangeEndPosition >= firstPrime else {
         fatalError("End of range has to be greater than or equal to \(firstPrime)!")
     }
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
        let firstHundredPrimes = Array(numbers[0...99]
        return firstHundredPrimes
    }

    return numbers
    
}
                                       
func printLastTenPrimes: (primesArray: [Int]) = {
        
            let primesReversed: [Int] = primesArray.reversed()
            
            print primesReversed[0..9]
}
                                       
//Ejercicio 2) sumar los primeros 50 numeros primos

func sumPrimesNumbers: (primesArray: [Int]) = {

    let firstFiftyPrimes = Array(numbers[0...49]
    var sumPrimes = firstFiftyPrimes.reduce($0, +)
    print(sumPrimes)
            
}
let getRandomPrimes = getPrimes(arrayPosition: 500)
printLastTenPrimes(primesArray: getRandomPrimes)
sumPrimesNumbers(primesArray: getRandomPrimes)
 
 
 

