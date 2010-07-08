function getMissionAddress(mission_id){
	$.getJSON("/missions/" + mission_id, function(data){
		$("#mission_address").html(data.address);
	});	
}

function toggleControls(){
	//toggle form controls
	if ($("select#missionary_mission_id").val() == " "){
	  $(".toggle").attr("disabled", "disabled"); 	
	} else {
	  $(".toggle").removeAttr("disabled");
	}
}

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
	options_text = "";
	for(i = 0; i < responseText.length; i++){
		options_text = options_text + parse_option_string(responseText[i]["id"], responseText[i]["name"], responseText[i]["selected"]);
	}
	return options_text;
}

function set_mission_id_select_and_close(responseText, statusText, xhr, $form){
	options_text = create_mission_id_select_options(responseText);		
	mission_select = $('select#missionary_mission_id');
	mission_select.html(options_text);
	getMissionAddress(mission_select.val());	
	toggleControls();
}

$(function(){
	//ajaxSubmit form	
	$("a#new_mission").colorbox({
		'onComplete': function(){ 
			$("form#new_mission").ajaxForm({
				dataType: 'json', 
				'success':  set_mission_id_select_and_close
			});
		}
	});
	
	$("a.colorbox").colorbox();
	
	//set anticipated LOS
	$("#missionary_courtesy_title").change(function(){
		if ($(this).val() == "Elder") {
			$("#missionary_length_of_service_in_months").val("24");
		} else {
			$("#missionary_length_of_service_in_months").val("18");
		}	
	});
	
	//get mission address
	$("select#missionary_mission_id").change(function(){
		//get the mission address
		getMissionAddress($(this).val());
		console.log("toggling form controls.");
		toggleControls();	
	});
});