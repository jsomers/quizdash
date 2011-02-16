q_count = 0;

add_question = function() {
	div = $(".question:eq(0)").clone().addClass("next");
	q_count += 1;
	div.find("label").each(function(i, e) {
		var curr_for = $(e).attr("for");
		$(e).attr("for", curr_for.replace("0", q_count));
	});
	
	div.find("input").each(function(i, e) {
		var curr_id = $(e).attr("id");
		$(e).attr("id", curr_id.replace("0", q_count));
		var curr_name = $(e).attr("name");
		$(e).attr("name", curr_name.replace("0", q_count));
		$(e).val("");
	});
	
	div.find("a").remove();
	$("<a href=\"#\" class=\"remove_question\">(rm)</a>").insertAfter(div.find(".questions"))
	div.appendTo($("#questions"));
}

$(document).ready(function() {
	$("#add_question").click(function() {
		add_question();
		return false;
	});
	
	$(".remove_question").live("click", function() {
		$(this).parent().remove();
		return false;
	});
	
	$(".remove_existing_question").live("click", function() {
        var qid = $(this).parent().find("dd input:first").attr("id").split("_")[3]
        $("<input type='hidden' name='quiz[questions_attributes][" + qid + "][_destroy]' value='1'/>")
            .appendTo($("form"));
        console.log( $(this).parent().parent() );
		$(this).parent().parent().remove();
		return false;
	});
	
	$(".permissibles").live("keydown", function(e) {
		if (e.keyCode == "9" || e.keyCode == "13") {
			add_question();
			$(".question:last dd:eq(0) input").focus();
			return false;
		}
	})
});