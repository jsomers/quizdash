current_leaderboard = function() {
	// Gets the rankings that are implicitly baked into the DOM.
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
}

ordinal = function(n) {
   var s = ["th","st","nd","rd"],
       v = n % 100;
   return n + ( s[(v - 20) % 10] || s[v] || s[0] );
}

diffstat_bar = function(pointices) {
    // Creates a diffstat DOM element from a list of booleans.
	var bar = $("<span>").addClass("diffstat-bar");
	for (var i = 0; i < pointices.length; i++) {
		var dot = $("<span>•</span>")
		if (pointices[i] == 1)
			dot.addClass("correct")
		bar.append( dot )
	}
	return bar;
}

n_correct = function(pointices) {
    // Counts the number of correct answers in a pointex list.
	var n = 0;
	for (var i = 0; i < pointices.length; i++) {
		if (pointices[i] == 1)
			n += 1;
	}
	return n;
}

test_up = [
	["jsomers", [0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0]],
	["pingoaf", [1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0]],
	["nsrivast", [1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0]],
	["silberd0llar", [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1]]
]

test_down = [
	["pingoaf", [1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0]],
	["nsrivast", [1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0]],
	["jsomers", [0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0]],
	["silberd0llar", [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1]]
]

build_row = function(pos, i) {
    // Creates jQ objects for a given row.
    return {
        li: $("<li>").addClass("source diffstat"),
        a: $("<a>").attr("href", "#").addClass("tooltipped leftwards"),
        bar: diffstat_bar(pos[1]),
        ct: $("<span>").addClass("diffstat-count").html(n_correct(pos[1])),
        name: $("<span>").addClass("diffstat-summary").html(pos[0]),
        place: $("<span>").addClass("place").html(ordinal(i + 1))
    }
}

flash = function(cur, old, el, iam) {
    if (cur != old) { // Player has changed positions.
	    if (iam)
	        color = (cur < old ? "green" : "red");
	    else
		    color = (cur < old ? "#ddffdd" : "#ffcccc");
		el.effect("highlight", {color: color}, 1000);
	}
}

append_slot = function(slot) {
    var old = current_leaderboard();
    var i = (old ? Object.keys(old).length : 0);
    var pos = slot,
        row = build_row(pos, i);
    row.li.addClass("me");
    row.a.append(row.ct).append(row.bar).append(row.name).append(row.place)
	row.li.append(row.a);
	$("#repo_listing").append(row.li);
}

new_leaderboard = function(leaderboard) {
	// Takes a "leaderboard" like ["jsomers", [0, 1, 0...]], ["pingoaf", [...]],
	// updates the DOM with the new information, and animates the transitions.
	
	// TODO: Animate (e.g., slide) the transitions?
	// TODO: Color of background highlight should be based on position.
	// < 5 = red, 3-5 = yellow, 2 = blue, 1 = green.
	// TODO: Maybe the dots themselves should flash? Change blindness?
	
	var old = current_leaderboard()

	$("#repo_listing").empty()

	for (var i = 0; i < leaderboard.length; i++) {
	    var pos = leaderboard[i],
		    row = build_row(pos, i),
		    iam = pos[0] == CONFIG.nick;
		if (iam)
			row.li.addClass("me");
		row.a.append(row.ct).append(row.bar).append(row.name).append(row.place)
		row.li.append(row.a);
		$("#repo_listing").append(row.li);
		if (Object.keys(old).length > 0)
		    flash(i, old[pos[0]]["place"], row.li, iam);
	};
}