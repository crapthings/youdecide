#

Router.route '/hottest', ->

	@render 'hottest',

		data: ->

			topicsOfTheMonth: ->
				Topics.find { totm: true },
					sort:
						'stats.likes': -1
						'stats.comments': -1
						'stats.views': -1
					limit: 30
,

	name: 'hottest'

	waitOn: ->

		subs.subscribe 'topicsOfTheMonth',
			sort:
				'stats.likes': -1
				'stats.comments': -1
				'stats.views': -1
			limit: 30
