$(document).ready(function(){
	$('#more').on("click",function(){
		$('#more').hide();
		$('#inf').show();
	});

	$('#less').click("click",function(){
		$('#inf').hide();
		$('#more').show();
	});

	$('#search').bind('railsAutocomplete.select', function(event, data){
		$('#search-form').submit()
	});

	$('#tabs').tab();
	// ricerca automatica ad ogni lettera
	// $("#search_books_form #search_query").keyup(function(){
	// 	var val = $(this).val();
	// 	if(val.length > 4){
	// 		$.post("<%= books_gbsearch_path %>", { query: val }, function(data){
	// 			$("#content").html(data);
	// 		});	
	// 	}
	// });
});


