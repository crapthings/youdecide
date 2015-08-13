#

Session.setDefault 'errorMessage', null

#


Router.onBeforeAction ->
	Session.set 'errorMessage', null
	@next()

#

Router.onAfterAction ->

	Meteor.defer ->

		jdenticon()

		autosize($ 'textarea')

#

Router.onAfterAction ->
	if Meteor.userId() and @ready()
		console.log @
		Meteor.call 'incTopicView', @params._id
,
	only: ['viewTopic']
