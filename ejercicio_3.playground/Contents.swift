import UIKit

let players: [String] = ["Vinicius", "Messi", "Ronaldo", "Pedri", "Mbappe","Modric", "Militao", "Morata", "Valverde", "Benzema", "Piqué"]
let vowels = ["a","á", "e","é", "i","í", "o","ò", "u","ú","Ü"]
var playersWithTwoMoreVowels: [String] = []



players.forEach { player in
    var vowelCount: Int = 0
    var playerLower = player.lowercased()
    for vowel in vowels {
        playerLower.forEach{ character in
            if (vowel.contains(character)){
                vowelCount += 1
            }
        }
    }
    
    if(vowelCount>2){
        playersWithTwoMoreVowels.append(playerLower)
    }
}

print(playersWithTwoMoreVowels)
