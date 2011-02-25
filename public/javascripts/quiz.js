// Like client.js in the mindy-node:
var CONFIG = {
	nick: "jsomers",
	id: null,
	focus: true
};

// TODO: How are Quiz objects structured?
// => Probably have a Quiz --> Question relationship.
// => Might want to build the Quiz adding admin interface first.
// => Placing quizzes in an extensible tree of categories.

// TODO: What does a session object look like?
// => Store in Redis?
// => Don't worry about how it's created (room stuff), just use one.
// => How to store on client side? Like CONFIG? See mindy.

// TODO: How to end a game? What is stored?

// TODO: Scramble the answers?
// => Come up with a simple random offset between 3 and 100. Call it f.
// => Scramble the answers according to f on the server, and send those
// => AND f to the client. On the keyup event, scramble the input using f
// => and correlate.

$(document).ready(function() {

    function mark_correct(q, ans) {
    	var q = $(".repositories > li[qid=" + q + "]").addClass("correct");
    	q.find("h3").html(ans).removeClass("hint");
    	q.find("ul.repo-stats").effect("highlight", {color: "yellow"}, 500);
    	q.effect("highlight", {color: "yellow"}, 500);
    	q.find("img").show();
    }

    $("#answer").keyup(function() {
    	var ans = $("#answer").val().toLowerCase();
    	var qid = answers[ans];
    	if (typeof(qid) != "undefined" && typeof(seen[qid]) == "undefined") {
    		mark_correct(qid, ans);
    		$("#answer").val("");
    		seen[qid] = true;
    		$.post("/dashes/mark_q/",
    		    {dash_id: dash_hash, quiz_id: quiz_id, qid: qid, plyr: CONFIG.nick},
    		    function(ret) {
                    console.log(ret);
    		    }
    		)
    	};
    });

    // Step 3:
    // Rename shit and clean up a bit.
    // Deillegalize template.
    // Merge into master and start hacking juggernaut, data, etc.
})
