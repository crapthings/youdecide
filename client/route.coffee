Session.set 'errorMessage', null

#

Router.configure

	layoutTemplate: 'layout_default'
	loadingTemplate: 'loading'

#

Router.onBeforeAction ->
	Session.set 'errorMessage', null
	@next()
