var selected_row = null;

$(function(){
	bind_ajax_event_to_table();

	$('#form-modal').on('shown.bs.modal', function (e) {
	  bind_ajax_event_to_modal();
	  $('#form-modal input[type="text"]').first().focus();
	});

	$(document).bind('ajaxError', 'form#form-modal', function(event, jqxhr, settings, exception){
		display_errors(jqxhr.responseJSON);
	});

	index_table();
});

function bind_ajax_event_to_modal(){
	$(".simple_form").on("ajax:success", function(e, data, status, xhr){

		switch(xhr.status){
			case 200:
				edit_element_from_table(data);
				break;
			case 201:
				insert_element_into_table(data);
				break;
			case 202:
				remove_element_from_table();
				break;
		}

		$("#form-modal").modal('hide');
	});
}

function bind_ajax_event_to_table(){
	$(".table").on("ajax:success", function(e, data, status, xhr){

		switch(xhr.status){
			case 202:
				remove_element_from_table();
				break;
		}
	});
}

function insert_element_into_table(data){
	var tr = "<tr>" + build_table_element(data) + "</tr>";
	$('.table > tbody').prepend(tr);
	index_table();
}

function edit_element_from_table(data){
	$('.table tbody tr[position=' + selected_row + ']').first().html(build_table_element(data));
	index_table();
}

function remove_element_from_table(){
	$('.table tbody tr[position=' + selected_row + ']').first().remove();
	index_table();
}

function index_table(){
	$(".table tbody tr").each(function(){
		$(this).attr('position', $(this).index());
	});

	$('.table tbody tr a[data-remote=true]').click(function(){
		selected_row = $(this).closest('tr').attr("position");
	});
}

function build_table_element(data){
	var element = "";
	var first_columns = $(".table thead").children('tr:last').find('th');
	var classes = [];

	first_columns.each(function(i){
		classes.push(first_columns.eq(i).attr('class'));

		if (classes[i].indexOf("col-show") != -1){
			element += "<td class='col-show'><a data-remote='true' href='/" + $('body').data('controller') + "/" + data.id + "'><span class='glyphicon glyphicon-search'></span></a></td>";
		}

		if (classes[i].indexOf("col-edit") != -1){
			element += "<td class='col-edit'><a data-remote='true' href='/" + $('body').data('controller') + "/" + data.id + "/edit'><span class='glyphicon glyphicon-pencil'></span></a></td>";
		}

		if (classes[i].indexOf("col-remove") != -1){
			element += "<td class='col-remove'><a data-confirm='Seguro desea eliminar?' data-remote='true' data-method='delete' href='/" + $('body').data('controller') + "/" + data.id + "'><span class='glyphicon glyphicon-remove'></span></a></td>";
		}

		for (var key in data){
			if (classes[i].indexOf("col-" + key) != -1) {
				element += "<td class=" + classes[i] + ">" + data[key] + "</td>";
			}
		}
	})

	return element;
}

function display_errors(errors){
	$("#error_explanation").show();
	$("#error_explanation > .bg-color-alert").html("El formulario contiene " + errors.length + " errores.");

	var error_messages = "";

	$.each(errors, function(index, value){
		error_messages += "<li>" + value + "</li>";
	});

	$("#error_explanation > ul").html(error_messages);
	$("#error_explanation").scrollToMe();
}

jQuery.fn.extend({
scrollToMe: function () {
    var x = jQuery(this).offset().top - 100;
    $("#form-modal").animate({scrollTop: x}, 500);
}});