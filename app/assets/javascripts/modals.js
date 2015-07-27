$(document).ready(function(){

	$(document).click(function(event) {
		var target = $(event.target);
		var thisElement = event.target.className;
		
		if( !$('.date-picker-container').is(':visible') ){

			if( thisElement == 'date'){
				$('.date-picker-container').show();
			}
		}

		else{
			if( thisElement == 'cancel'){
				$('.date-picker-container').hide();
			}
		
			else if( (thisElement == 'date-picker') || ( !target.parents('.date-picker').length)  ){
				$('.date-picker-container').hide();	
			}	
		}
		
	});

	/* Date Picker */
	$(".dates span").click(function(){
		if ( !$( this ).hasClass( "inactive" ) ) {
			$(".dates span").removeClass("selected");
			$(this).addClass("selected");
		}
	});	
	$(".dates span.selected").click(function(){
		$(this).removeClass("selected");
	});	

	$(".time-container label").click( function(){
		if( !$(this).prev("input:checkbox").is(':checked')){
			$(this).prev("input:checkbox").prop('checked', true);
		
		}
		else{
			$(this).prev("input:checkbox").prop('checked', false);
		}
	});


});