// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function send_with_filter() {
  var filter_input = $("#with_filter_input")[0];

  // we should only apply new query string if there is actual input
  if (filter_input.value.length) {
    // decide which seperator we want depending on if there is a current query string
    var seperator = window.location.search ? "&" : "?";

    // Get current URL
    var href = window.location.href;
    // append new query
    new_link = href + seperator + "filters[with_filters][]=" + filter_input.value;

    window.location = new_link;
  } else {
    alert("You did not specify a filter to apply");
  }
}

function remove_with_filter(list_item) {
  var filter_text = list_item.text.trim();
  var original_query = window.location.search;

  console.log(filter_text);
  var question_regex  = new RegExp("\\?filters\\[with_filters\\]\\[\\]=" + filter_text + "&*");
  var ampersand_regex = new RegExp("&filters\\[with_filters\\]\\[\\]=" + filter_text);

  var query = "";
  if (question_regex.test(original_query)) {
    console.log("we've got a question mark");
    query = original_query.replace(question_regex, '?');

  } else if (ampersand_regex.test(original_query)) {
    console.log("we've got an ampersand mark");
    query = original_query.replace(ampersand_regex, '');
  }

  // reload page with new query string
  window.location = window.location.href.split('?')[0] + query;
}

function remove_without_filter(list_item) {
  // TODO
}
