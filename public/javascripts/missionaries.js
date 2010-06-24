function parse_option_string(value, text, selected){
	option = "";
	if (selected == 'true'){
		option = "<option value='" + value + "' selected='selected'>" + text + "</option>";
	} else {
		option = "<option value='" + value + "'>" + text + "</option>";		
	}
	return option;
}

function create_mission_id_select_options(responseText){
	
	console.log("creating_mission_id_select_options");
	
	options_text = "";
	
	for(i = 0; i < responseText.length; i++){
		options_text = options_text + parse_option_string(responseText[i]["id"], responseText[i]["name"], responseText[i]["selected"]);
	}
	
	console.log("options created as: " + options_text);
	
	return options_text;
}

function set_mission_id_select_and_close(responseText, statusText, xhr, $form){
	
	console.log("setting mission_id_select with responseText: " + responseText);
	
	options_text = create_mission_id_select_options(responseText);
	
	console.log("the options_text is: " + options_text);
		
	$('select#missionary_mission_id').html(options_text);
	
	console.log("attempting to close colorbox");
	
	$.fn.colorbox.close();
	$.fn.colorbox.remove();	
}

$(function(){
	//ajaxSubmit form	
	$("a#new_mission").colorbox({
		'onComplete': function(){ $("form#new_mission").ajaxForm({dataType: 'json', 'success':  set_mission_id_select_and_close });}
	});
	
	//set anticipated LOS
	$("#missionary_courtesy_title").change(function(){
		if ($(this).val() == "Elder") {
			$("#missionary_length_of_service_in_months").val("24");
		} else {
			$("#missionary_length_of_service_in_months").val("18");
		}	
	});
	
	$("select#missionary_mission_id").change(function(){
		//get the mission address
		$.getJSON("/missions/" + $(this).val(), function(data){
			console.log(data.mission.name);
			$("#mission_address").html(data.mission.address);
		})
		
		console.log("the value of missionary_mission_id: " + $("select#missionary_mission_id").val());
		
		//toggle form controls
		if ($("select#missionary_mission_id").val() == " "){
		  $(".toggle").attr("disabled", "disabled"); 	
		} else {
		  $(".toggle").removeAttr("disabled");	
		}
	})
});