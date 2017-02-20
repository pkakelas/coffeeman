greek = require 'greek-utils'
models = require './models.coffee'
keywords = require './keywords.coffee'

Array.prototype.first =	() -> @[0]

class Intention
  constructor: (@count, @coffee) ->

coffees = {
  cappuccino: models.Cappuccino,
  espresso: models.Espresso,
  nes: models.Nes,
  frappe: models.Frappe,
  french: models.French,
  greek: models.Greek
}

phraseFiltered = []
rawIntentions = []
intentions = []

phrase = greek.toGreeklish("Θέλω ένα freddo cappuccino μέτριο και ένα νες γλυκό").split " "

#console.log 'Greeklish phrase', phrase

for word, index in phrase #not interesting words
  for keyword in [keywords.types..., keywords.decaf..., keywords.size..., keywords.sugar..., keywords.count..., keywords.etc...]
    phraseFiltered.push do keyword.first if word.toLowerCase() in keyword

#console.log 'Filtered Phrase: ',  phraseFiltered

for word, index in phraseFiltered #separate coffee intentions
  for num in keywords.count
    if word in num
      intention = phraseFiltered.splice(0, index)
      rawIntentions.push(intention) if intention.length

rawIntentions.push phraseFiltered

#console.log 'Raw Intentions', rawIntentions

#Get first column of all data
types = keywords.types.map((type) -> type[0])
sugars = keywords.sugar.map((sugar) -> sugar[0])
decaf = keywords.decaf.map((decaf) -> decaf[0])
sizes = keywords.size.map((size) -> size[0])
etc = keywords.etc.map((etc) -> etc[0])
counts = keywords.count.map((count) -> count[0])

for intention, index in rawIntentions
  coffee = null
  unprocceced = [[]]


  if intention[0] in counts
    intention.count = intention[0]

  for word, index in intention
    if word in Object.keys coffees
      coffee = new coffees[word]
      intention.splice(index, 1)
      break

  for word in intention
    if word in sugars
      coffee.sugar = word
    else if word in sizes
      coffee.size = word
    else if word in decaf
      coffee.decaf = true
    else if word == "freddo" && (coffee.name == "espresso" || coffee.name == "cappuccino")
      coffee.freddo = true
    else
      if unprocceced[index]?
        unprocceced[index].push word
      else
        unprocceced[index] = [word]

    coffee.etc = unprocceced[index] if unprocceced[index]?

  count = if intention[0] in counts then intention[0] else 1

  intentions[index] = new Intention(count, coffee)

console.log intentions
