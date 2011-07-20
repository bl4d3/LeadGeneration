$(document).ready(function() {
	$( ".containers ul" ).sortable({
		beforeStop: function (event, ui) { 
			draggedItem = ui.item;
			draggedItemId = draggedItem.attr("id");
			parentId = $('#'+draggedItemId).parent().attr("id");
			var childrenIds = [];

			$('#'+parentId).children().each(function ()
			{
				if($(this).attr("id")!=null && $(this).attr("id")!=""){
			    	childrenIds.push($(this).attr("id"));
			    }
			});			
			$("#doing_op").html("Ordering...");
			$("#doing_op").show("fast");
			$.get("containers/order", { pId: parentId, sIds: childrenIds.join(',') } );
		}
	});
	
	$("#company_department_tokens").tokenInput("/departments.json", {
	    crossDomain: false,
	    prePopulate: $("#company_department_tokens").data("pre"),
	  });
	
	init_show_deliver();
	
	$( "#search_estimate_created_at_gte" ).datepicker();
	$( "#search_estimate_created_at_lte" ).datepicker();
	
	$( "#search_created_at_gte" ).datepicker();
	$( "#search_created_at_lte" ).datepicker();
	
	if ($('#company_department_tokens').length > 0){
		$('#company_department_tokens').blur();
		$('html, body').animate({scrollTop:0});
	}
	
	$("#checkboxes_category input[type=checkbox]").attr('checked', true);
  
	
});

function init_show_deliver(){
	$('.show_deliver').click(function() {
		$('#deliver_'+$(this).attr("id")).toggle("slow")
		return false;
	});
}

function remove_fields(link) {
	$(link).siblings("input[type=hidden]:first").attr('value', '1');
	$(link).parents(".nested_el:first").hide();  
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

function hideEl(id){
	setTimeout(function() {
	    $('#'+id).fadeOut('fast');
	}, 2000); // <-- time in milliseconds
}

function bangme(id){
	$('#what_is_happen').html('...caricamento');
	$('#what_is_happen').show();
	$.ajax({
		url: '/frontends/aggregator_show/?id='+id, 
		type: 'get', 
		dataType: 'script',
		success: function(data) {
			$('html,body').animate({scrollTop: $("#company_anchor").offset().top},'slow');
			$('#what_is_happen').hide();
		 	}
	});
}


function toggle(div)
{
	$("#"+div).toggle("slow");
	return false;
}

$("#select_all_category").live('click', function () {
    if ($('#select_all_category:checked').length)
    {
        $("#checkboxes_category input[type=checkbox]").attr('checked', true);
        $("#categories_status").html("Deseleziona tutti")
    }
    else
    {
        $("#checkboxes_category input[type=checkbox]").attr('checked', false);
        $("#categories_status").html("Seleziona tutti")        
    }
});
