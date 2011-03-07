### /play/quiz TODOs ###

Roadmap: self-contained games with timers with manual countdown start -> tweak -> matchmaking/rooms

How timers will work
	Quizzes should have a "time limit" field
	At a certain point the server should fire off a "start countdown" event to the clients in the channel
	Countdown runs just using Javascript timer; clients locked out for ten seconds or so
	At t - 5 seconds no new clients are allowed to join the dash
	When clients are freed, they start playing, the quiz timer starts counting down
	At that moment we fire a message to the server saying that the dash has started at this timestamp
	Quiz timers are just regular Javascript clocks
	Every time the dash is touched its "last-touch" timestamp changes
	On every Juggernaut event the quiz timers are updated with the new ("last-touch" - "first-touch") calculated time
	Game is stopped for a client either when their clock hits zero or when the calculated time shows zero, whichever happens first

What's stored when you end a dash?

Scale the question indicators so that, say, four of them would take up as much space as fifteen (they'd just be wider).

Quiz categories are not yet hooked up to the quiz crud interface.

Matchmaking and rooms

Scramble the answers?
	Come up with a simple random offset between 3 and 100. Call it f.
	Scramble the answers according to f on the server, and send those
	AND f to the client. On the keyup event, scramble the input using f
	and correlate.

### /quiz/* TODOs ###

Quiz and question model validations and form errors; clear empty questions callback.

ENTER key behavior in text boxes (catch key event and do a focus or something (maybe nothing) if not last input)

Shouldn't be able to delete all questions when editing a quiz

### Room TODOs ###

Min of two players before a channel's status can be okayed to go, then there's a countdown, a period during which other people can join that game, and games with more players (up to a max) are sorted st they have higher priority (but not a total lock, some randomness involved)

How to avoid keeping people waiting in a waiting area for too long, but not give away the content of the upcoming game? Also want to give people a chance to read the instructions.

Player disconnects?

### Reference info ###

To start juggernaut:
	1. Start redis: redis-server ~/projects/redis-2.0.4/redis.conf
	2. Start juggernaut: cd ~/juggernaut; sudo node server.js
	3. Head to /jugtest/land.

### Code-level issues ###

Gem bundle?

Can Rails handle all these concurrent connections? How to scale?

### Gameplay features ###

Syncing games and managing timers

Matchmaking options? discuss with freedman and silber.

Extra points for guessing something that no one else has guessed

First blood (fps game mechanics) / badges for end of match / flawless victory! (first to answer every question)

Calling out a tough question (~wager)

Blanking out other people's questions / fuck with their typing

Daily doubles

### General site features ###

Sessions -> migrate to accounts (pre-populate signup with chosen handle and save the session stats)

Discover channels by browsing

Automatically generating quizzes from a subset of the questions tied to that quiz. Randomly select them or choose cleverly.

The "quizdash" is the dashboard of _your_ quiz performance

Players have a handle and also a short message / quote

Histogram with everyone's progress. or, they could show activity on the site more generally!

Login for users, stats, etc.

Party mode / matchmaking

De-illegalize templates