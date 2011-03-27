leaderboard = {
    // Gets the rankings that are implicitly baked into the DOM.
    current: function() {
    	var leaderboard = {};
    	$(".diffstat").each(function(i, e) {
    		var player_name = $(e).find(".diffstat-summary").text();
    		var pointices = [];
    		$(e).find(".diffstat-bar span").each(function(j, f) {
    			if ( $(f).hasClass("correct") )
    				pointices.push(1)
    			else
    				pointices.push(0)
    		})
    		leaderboard[player_name] = {"place": i, "pointices": pointices}
    	})
	
    	return leaderboard;
    },

    ordinal: function(n) {
       var s = ["th","st","nd","rd"],
           v = n % 100;
       return n + ( s[(v - 20) % 10] || s[v] || s[0] );
    },

    // Creates a diffstat DOM element from a list of booleans.
    diffstat_bar: function(pointices) {
    	var bar = $("<span>").addClass("diffstat-bar");
    	for (var i = 0; i < pointices.length; i++) {
    		var dot = $("<span>•</span>")
    		if (pointices[i] == 1)
    			dot.addClass("correct")
    		bar.append( dot )
    	}
    	return bar;
    },

    // Counts the number of correct answers in a pointex list.
    n_correct: function(pointices) {
    	var n = 0;
    	for (var i = 0; i < pointices.length; i++) {
    		if (pointices[i] == 1)
    			n += 1;
    	}
    	return n;
    },

    // Creates jQ objects for a given row.
    build_row: function(pos, i) {
        return {
            li: $("<li>").addClass("source diffstat"),
            a: $("<a>").attr("href", "#").addClass("tooltipped leftwards"),
            bar: this.diffstat_bar(pos[1]),
            ct: $("<span>").addClass("diffstat-count").html(this.n_correct(pos[1])),
            name: $("<span>").addClass("diffstat-summary").html(pos[0]),
            place: $("<span>").addClass("place").html(this.ordinal(i + 1))
        }
    },

    flash: function(cur, old, el, iam) {
        if (cur != old) { // Player has changed positions.
    	    if (iam)
    	        color = (cur < old ? "green" : "red");
    	    else
    		    color = (cur < old ? "#ddffdd" : "#ffcccc");
    		el.effect("highlight", {color: color}, 1000);
    	}
    },
    
    // Retrieves the current values of the indicators which count how many
    // players have correctly answered a given question.
    current_ppl_counts: function() {
        var counts = [];
        $("li.forks a").each(function(i, e) {
            counts.push( parseFloat($(e).html()) );
        })
        return counts;
    },
    
    // Given a new leaderboard object, returns a list that counts how many players
    // have correctly answered a given question.
    new_ppl_counts: function(leaderboard) {
        var upd = new_filled_array(leaderboard[0][1].length, 0);
        for (var i = 0; i < leaderboard.length; i++) {
            var pts = leaderboard[i][1];
            for (var j = 0; j < pts.length; j++) {
                upd[j] += pts[j];
            }
        }
       return upd; 
    },
    
    // Updates the indicators which count how many players have correctly
    // answered a given question.
    update_ppl_indicators: function(counts) {
        var old = this.current_ppl_counts();
        $("li.forks a").each(function(i, e) {
            $(e).html(counts[i]);
            var li = $("li.simple:eq(" + i + ")");
            if (counts[i] > old[i] && !$(li).hasClass("correct")) {
                $(li).effect("highlight", {color: "#ffcccc"}, 300);
                $(e).effect("highlight", {color: "#ffcccc"}, 300);
            }
        })
    },
    
    // Takes a "leaderboard" like ["jsomers", [0, 1, 0...]], ["pingoaf", [...]]
	// and updates the DOM with the new information.
    new: function(leaderboard, ready, started) {
    	var old = this.current();

    	$("#repo_listing").empty();
        
    	for (var i = 0; i < leaderboard.length; i++) {
    	    var pos = leaderboard[i],
    		    row = this.build_row(pos, i),
    		    iam = (pos[0] == QUIZ.nick);
    		
    		if (iam)
    			row.li.addClass("me");
    		
    		if (ready.indexOf(pos[0]) != -1 && !started)
    		    row.li.addClass("ready");
    			
    		row.a.append(row.ct).append(row.bar).append(row.name).append(row.place)
    		row.li.append(row.a);
    		$("#repo_listing").append(row.li);
    		
    		if (Object.keys(old).length > 0) {
    		    try { 
    		        this.flash(i, old[pos[0]]["place"], row.li, iam)
    		    } catch(err) {};
		    }
    	};
    	this.update_ppl_indicators(this.new_ppl_counts(leaderboard));
    }
}