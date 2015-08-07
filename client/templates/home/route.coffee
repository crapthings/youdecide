#

Router.route '/', ->

	@render 'home',

		data: ->

			topicsOfTheDay: ->
				Topics.find { totd: true },
					sort:
						'stats.likes': -1
						'stats.comments': -1
						'stats.views': -1
,

	name: 'home'

	waitOn: ->

		subs.subscribe 'topicsOfTheDay',
			sort:
				'stats.likes': -1
				'stats.comments': -1
				'stats.views': -1
			limit: 30
