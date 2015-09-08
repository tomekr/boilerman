// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function send_with_filter() {
  var filter_input = $("#with_filter_input")[0];


  // TODO: make sure there is input
  if (filter_input.value.length) {
    var seperator = "&";
    // current search query exists
    if (!window.location.search) {
      seperator = "?"
    }

    // Get current URL
    var href = window.location.href;
    // append new query
    new_link = href + seperator + "filters[with_filters][]=" + filter_input.value;

    window.location = new_link;
  }
}

function remove_with_filter() {
  // TODO
  console.log("hello remove_with_filter()");
}
