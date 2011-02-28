var CONFIG = {
	nick: "jsomers",
	id: null,
	focus: true
};

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
    
    function new_filled_array(len, val) {
	    var rv = new Array(len);
	    while (--len >= 0) {
	        rv[len] = val;
	    }
	    return rv;
	}
	
	if (typeof jug !== "undefined") {
    	jug.on("connect", function() {
    		$.get("/dashes/get/" + dash_hash, 
    			function(ret) {
    				dash = JSON.parse(ret);
    				new_leaderboard(dash.board);
				
    				CONFIG.nick = prompt("Enter your handle, please", "zero_cool");
    				//CONFIG.nick = "player " + Math.floor(Math.random() * 101);
    				var pointices = new_filled_array(n_questions, 0);
    				var slot = [CONFIG.nick, pointices];
        
    				$.post("/dashes/add_slot/", 
    					{dash_id: dash_hash, slot: JSON.stringify(slot)},
    					function(ret) {
    						dash = JSON.parse(ret);
    						append_slot(slot);
    					}
    				);
    			}
    		)
		
    	});

    	jug.subscribe("/" + dash_hash, function(ret) {
    		console.log(ret);
    		dash = JSON.parse(ret);
    		new_leaderboard(dash.board);
    	})
	}

	var s = function(msg) {
		$.post("/play/msg", {txt: msg}, 
			function(data) {
				console.log(data);
			}
		)
	}
})
