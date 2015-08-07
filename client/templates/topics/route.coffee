#

Router.route '/topics/new', ->
	@render 'newTopic'
,
	name: 'newTopic'

#

Router.route '/topics/view/:_id', ->
	@layout 'layout_topic'
	@render 'viewTopic',
		data: ->
			topic:
				Topics.findOne @params._id

			commentsLeft:
				Comments.find { topicId: @params._id, left: true },
					sort:
						createdAt: -1

			commentsRight:
				Comments.find { topicId: @params._id, left: false },
					sort:
						createdAt: -1
,
	name: 'viewTopic'
	waitOn: ->
		subs.subscribe 'findTopic', @params._id
		subs.subscribe 'findLeftComments', @params._id
		subs.subscribe 'findRightComments', @params._id
