class Coffee
	sugar: "medium"
	size: "single"
	decaf: false
	etc: []

class Cappuccino extends Coffee
	freddo: false
	crema: false
	powder: false

	@getName: ->
		name = if freddo then "Freddo Cappuccino" else "Cappuccino"

class Espresso extends Coffee
	name: "espresso"
	freddo: false
	powder: false

	@getName: ->
		name = if freddo then "Freddo Espresso" else "Espresso"

class Nes extends Coffee
	name: "Νες"

class Frappe extends Coffee
	name: "Φραπές"

class French extends Coffee
	name: "Γαλλικός"

class Greek extends Coffee
	name: "Ελληνικός"


module.exports.Cappuccino = Cappuccino
module.exports.Espresso = Espresso
module.exports.Nes = Nes
module.exports.Frappe = Frappe
module.exports.French = French
module.exports.Greek = Greek
