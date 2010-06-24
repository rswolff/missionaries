function parse_option_string(value, text, selected){
	
	console.log(selected);
	
	option = "";
	if (selected == 'true'){
		option = "<option value='" + value + "' selected='selected'>" + text + "</option>";
	} else {
		option = "<option value='" + value + "'>" + text + "</option>";		
	}
	
	console.log("The options are: " + option);
	
	return option;
}

function set_options(responseText, statusText, xhr, $form){
	
	
	console.log("in set_options");
	options_text = "";
	
	for(i = 0; i < responseText.length; i++){
		console.log("The value of selected is: " + responseText[i]["selected"]);
		options_text = options_text + parse_option_string(responseText[i]["id"], responseText[i]["name"], responseText[i]["selected"]);
	}
	
	console.log(options_text);
	$('body').data('new_mission', true);
	$('body').data('options', options_text);

}

function setOptions(){	
	$('select#missionary_mission_id').html($('body').data('options'));	
}

$(function(){	
	$("a#new_mission").colorbox({
		'onComplete': function(){ $("form#new_mission").ajaxForm({dataType: 'json', 'success':  set_options });},
		'onClosed'  : setOptions
	});
	
	$("#missionary_courtesy_title").change(function(){
		if ($(this).val() == "Elder") {
			$("#missionary_length_of_service_in_months").val("24");
		} else {
			$("#missionary_length_of_service_in_months").val("18");
		}	
	});
});