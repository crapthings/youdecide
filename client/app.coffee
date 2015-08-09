
Router.onAfterAction ->

	Meteor.defer ->

		jdenticon()

		autosize($ 'textarea')
