#= require jquery/countdown

window.Countdown = class Countdown extends Spine.Controller
	constructor: (container) ->
		super el: $(container)

		# attach countdown markup to container
		@el.html JST['shared/countdown']()
		@timer = $(@el).find('.countdown')

	onTimeout: =>
		console.log 'Time\'s up!'
		@clear()
		@trigger 'timeout'

	start: (seconds = 0) ->
		@clear() if @isRunning()
		now = new Date()	
		startDate = new Date(now.getTime() + (1000 * seconds))
		@createTimer(startDate)

	createTimer: (date) ->
		@timer.countdown
			until: date
			format: 'MS'
			compact: true
			onExpiry: @onTimeout
			layout: """
				<span class="image{m1}"></span>
				<span class="imageSep"></span>
				<span class="image{s10}"></span>
				<span class="image{s1}"></span>
			"""

	clear: -> @timer.countdown 'destroy'
	pause: -> @timer.countdown 'pause'
	resume: -> @timer.countdown 'resume'
	isRunning: -> @timer.hasClass 'hasCountdown'
