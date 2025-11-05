//
// Playground.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Playgrounds

#Playground {
  let myString = "à 👩‍❤️‍👨"

  //  print(myString.first!)
  //  print(myString.last!)
  //  print(myString.count)

  let indexOfFirstChar = myString.startIndex
  let firstChar = myString[indexOfFirstChar]

  let indexOfChar3 = myString.index(
    myString.startIndex,
    offsetBy: 2
  )
  let char3 = myString[indexOfChar3]

  let lastChar = myString[
    myString.index(
      myString.endIndex,
      offsetBy: -1
    )]

  print(firstChar)
  print(char3)
  print(lastChar)
}
