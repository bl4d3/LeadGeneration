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
