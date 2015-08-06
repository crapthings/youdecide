#

Router.route '/topics/new', ->
	@render 'newTopic'
,
	name: 'newTopic'


#

Router.route '/topics/view/:_id', ->
	@render 'viewTopic'

,
	name: 'viewTopic'
