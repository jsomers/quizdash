Make sure to broadcast the mark_q event to all the players in the channel. Also, be sure to re-sort the leaderboard somewhere.

1. When an answer goes through, POST the changes via the Dash controller.
2. When we receive a new object via the juggernaut channel (get the channel settings right, btw), update the leaderboard and the question people counts.

Javascripts with erb in them? How about write functions that take pure JS variables and set those variables in an html.erb template. Or just use an html partial.

Scale the question indicators so that, say, four of them would take up as much space as fifteen (they'd just be wider).

- quiz and question model validations and form errors; clear empty questions callback.
- ENTER key behavior in text boxes (catch key event and do a focus or something (maybe nothing) if not last input)
- shouldn't be able to delete all questions when editing a quiz
- polluting namespace with these javascripts loaded via application.html.erb? Object-ize them?

- gem bundle?

- refactor, prune, and clean

- to start juggernaut:
	1. Start redis: redis-server ~/projects/redis-2.0.4/redis.conf
	2. Start juggernaut: cd ~/juggernaut; sudo node server.js
	3. Head to /jugtest/land.
- play with data shifting around
- get individual game working independently of game room
	- without time element (but keep it in mind). basics:
		1. Show up and choose handle. Populates leaderboard entry.
		2. Wait for other players to do the same.
		3. Event when I enter a correct response.
		4. Event when that pushes to the others.
	- with time element

- automatically generating quizzes from a subset of the questions tied to that quiz. randomly select them or choose cleverly.
- matchmaking options? discuss with freedman and silber.
- sessions -> migrate to accounts (pre-populate signup with chosen handle and save the session stats)

- get a version that works up and hosted quickly
- use juggernaut
- each game is a channel
- discover channels by browsing
- abstract away from quiz content
- the "quizdash" is the dashboard of _your_ quiz performance
- extra points for guessing something that no one else has guessed
- admin interface for easily adding new quizzes
- every quiz is a json object:
 	- a set of blanks to be filled in
	- permissible answers for each blank (must these be specified manually?)
	- label
	- description
	- time limit
- channels are independent of games/quizzes
- min of two players before a channel's status can be okayed to go, then there's a countdown, a period during which other people can join that game, and games with more players (up to a max) are sorted st they have higher priority (but not a total lock, some randomness involved)
- memcached for channel status and ids and such?
- players have a handle and also a short message / quote
- how to avoid keeping people waiting in a waiting area for too long, but not give away the content of the upcoming game? Also want to give people a chance to read the instructions.
- sessions and player disconnects?
- submitting an answer sends a message which on_success validates back to user and to everyone else and on_fail does nothing
- syncing games and managing timers
- histogram with everyone's progress. or, they could show activity on the site more generally!
- your position out of n players
- flash colors in the spots when other players get there (how to represent this?)
	- one idea is a bunch of small multiples, each of which looks like a minified version of the whole board, each tied to a person's name then the slots there would be filled in and the mini-boxes as a whole would be sorted according to who was doing what.
	- perhaps cleaner would be something like github's little commit dots, one for each slot and a set for each player, that are gradually filled in as players answer questions.
- login for users, stats, etc.
- can RAILS handle all these concurrent connections? How to scale?
- first blood (fps game mechanics) / badges for end of match / flawless victory! (first to answer every question)
- calling out a tough question (~wager)
- blanking out other people's questions / fuck with their typing
- daily doubles
- party mode / matchmaking