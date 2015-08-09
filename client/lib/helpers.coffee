#

helper = Template.registerHelper

#

helper 'system', ->
	System.findOne { init: true }

#

helper 'fromNow', (date) ->
	moment(date).fromNow()

#

helper 'errorMessage', -> Session.get 'errorMessage'
