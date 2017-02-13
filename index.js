var botkit = require('botkit');
var fbConfig = require('config').get("facebook");

var controller = botkit.facebookbot({
	access_token: fbConfig.access_token,
	verify_token: fbConfig.verify_token,
});

var bot = controller.spawn({
});

controller.setupWebserver(8888,function(err,webserver) {
  controller.createWebhookEndpoints(controller.webserver, bot, function() {
		console.log('This bot is online!!!');
  });
});

controller.hears(['hello'], 'message_received', function(bot, message) {
	bot.reply(message, 'Hey there.');
});
