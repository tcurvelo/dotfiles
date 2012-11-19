
$("body").append("<div id='counter'></div>");

$("#counter").css({ 
	"background-color"	: "#F8F8F8",
	"border"		: "1px solid #DDD",
	"border-radius"		: "15px",
	"padding"		: "10px",
	"position"		: "fixed",
	"right"			: "0.5em",
	"top"			: "2em"
});

function article_count(){
	var n_articles=$(".tableViewCell").length;
	if(n_articles>1)
		$("#counter").text( n_articles + " articles").show();
	else
		$("#counter").hide();
}

$(".archiveButton").add(".deleteLink").click(article_count);

$(document).ready(article_count);
