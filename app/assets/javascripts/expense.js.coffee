# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

cur_date = new Date()

$(document).ready ->
	$("#expense_expense_date").datepicker(format:'dd-mm-yyyy')
	$("#expense_expense_date").datepicker().on "changeDate", (ev) ->
  		$("#expense_expense_date").datepicker('hide')