var stdin = process.openStdin();
var mapsConfig = require('config').get("google_maps");

var googleMapsClient = require('@google/maps').createClient({
	key: mapsConfig.key
});

var responses = {
	"found": "Η διεύθυνση σου είναι %s. Όροφος?",
	"foundMany": "Η διεύθυνση που μου έδωσες δεν είναι πολύ συγκεκριμένη. Προσπάθησε να μου δώσεις μια πιο ολοκληρωμένη διεύθυνση.",
	"notFound": "Δεν βρήκα τη διεύθυνση σου. Θέλεις να γίνεις πιο σαφής?"
};

console.log("Gimme the address");

stdin.addListener("data", function(address) {
	googleMapsClient.geocode({
		address: address.toString()
	}, function(err, res) {
		switch (res.json.results.length) {
			case 0:
				console.log(responses.notFound + "\n");
				break;
			case 1:
				var place = res.json.results[0];
				if (place.types[0] == 'street_address') {
					console.log(responses.found + "\n", place.formatted_address);
				}
				else {
					console.log(responses.foundMany + "\n"); //No address number have been specified
				}
				break;
			default:
				console.log(responses.foundMany + "\n");
		}
	});
});
