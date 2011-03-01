### /play/quiz TODOs ###

Be sure to Juggernaut broadcast to the channel when a player joins (we're not doing that now!).

Flash the question red when someone else gets it (and increment the people counter).

Scale the question indicators so that, say, four of them would take up as much space as fifteen (they'd just be wider).

Quiz categories are not yet hooked up to the quiz crud interface.

How to end a game? What is stored?

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