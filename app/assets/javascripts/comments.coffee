# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:success", "form#comments-form", (ev,data) ->
    console.log data
    $(this).find("input:text").val("");
    $("#comments-box").append("<span class='bold'>#{data.user.email}</span> dice:");
    $("#comments-box").append("<p class='comment-body'>#{data.body}</p>");