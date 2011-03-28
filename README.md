### /play/quiz TODOs ###

Redis dash handling -- how to deal with blanks, back buttons, and lingering objects

How to deal with people coming in in the middle of a game? Spin off a new game? How to wait?

Deploy
	Have to start redis server
		cd /usr/local/src/redis-2.2.2/src; ./redis-server 
	Have to start juggernaut
		cd /usr/local/src/npm/node_modules/juggernaut; node server.js
	Have to open port 8080 on web role through security group
	Can we close port 8080 on app role?
	Can we bring back SSL support?
	Can we bring back monit? (Remember port change to 8090 and AWS security group)

Matchmaking and rooms (first cut)
	One room per quiz
	Start by voting
	When game ends the dash data is stored then destroyed
	Either "click here to play again" or go somewhere else
	
Scale the question indicators so that, say, four of them would take up as much space as fifteen (they'd just be wider).
	Also scale the input boxes

CSV upload interface and backend code.

Stats of individual questions answered

Put question IDs in the mix so that we know which questions were answered.

More complex version of how timers could work
	At a certain point the server should fire off a "start countdown" event to the clients in the channel (do this manually for now)
	Clients locked out for ten seconds or so
	When clients are freed, they start playing, the quiz timer starts counting down
	At that moment we fire a message to the server saying that the dash has started at this timestamp
	Every time the dash is touched its "last-touch" timestamp changes
	Let's examine the difference between ("last-touch" - "first-touch") and the regular Javascript clock
	Synchronize if necessary -- sync to fastest time?
	Just end the game either when your clock runs out or when someone else's has (and they've sent a "time's up" message)

What's stored when you end a dash?
	Probably want to store people's scores. Might as well just leave the Dash object.

Quiz categories are not yet hooked up to the quiz crud interface.

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

### Key metrics ###

How many players are there?

How many people who start a game finish it?

How many people who finish one game play another?

Histogram of game streaks

How do these metrics correlate with performance?

Keep a dashboard that's updated dynamically (even using Juggernaut) with simple Redis counts on events

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