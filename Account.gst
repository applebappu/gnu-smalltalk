Object subclass: Account [
	| balance |
	<comment: 'I represent a place to deposit and withdraw money.'>
	Account class >> new [
		<category: 'instance creation'>
		| r |
		r := super new.
		r init.
		^r
	]
	init [
		<category: 'initialization'>
		balance := 0
	]
	printOn: stream [
		<category: 'printing'>
		super printOn: stream.
		stream nextPutAll: ' with balance: '.
		balance printOn: stream
	]
	spend: amount [
		<category: 'moving money'>
		balance := balance - amount
	]
	deposit: amount [
		<category: 'moving money'>
		balance := balance + amount
	]
]

Account subclass: Savings [
	| interest |
	init [
		<category: 'initialization'>
		interest := 0.
		^super init
	]
	interest: amount [
		interest := interest + amount
		self deposit: amount
	]
	clearInterest [
		| oldinterest |
		oldinterest := interest.
		interest := 0.
		^oldinterest
	]
]

Account subclass: Checking [
	| checknum checksleft history |
	init [
		<category: 'initialization'>
		checksleft := 0.
		history := Dictionary new.
		^super init
	]
	newChecks: number count: checkcount [
		<category: 'spending'>
		checknum := number
		checksleft := checkcount
	]
	writeCheck: amount [
		<category: 'spending'>
		| num |

		"Sanity check that we have checks left in our checkbook."
		(checksleft < 1)
			ifTrue: [ ^self error: 'Out of checks' ].

		"Make sure we've never used this check number before."
		num := checknum.
		(history includesKey: num)
			ifTrue: [ ^self error: 'Duplicate check number' ].

		"Record the check number and amount."
		history at: num put: amount.

		"Update our next checknumber, checks left, and balance."
		checknum := checknum + 1.
		checksleft := checksleft -1.
		self spend: amount.
		^num
	]
	printOn: stream [
		super printOn: stream.
		', checks left: ' printOn: stream.
		checksleft printOn: stream.
		', checks written: ' printOn: stream.
		(history size) printOn: stream.
	]
	check: num [
		| c |
		c := history
			at: num
			ifAbsent: [ ^self error: 'No such check #' ].
		^c
	]
	printChecks [
		history keysAndValuesDo: [ :key :value |
			key print.
			' - ' print.
			value printNl.
		]
	]
]
