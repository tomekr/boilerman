$( document ).ready(function() {
  // Initialize global variables
  window.controller_filters = [];

  // When the enter key is pressed on the filter input boxes, trigger the
  // onclick event for that text box
  $("#controller_filter_input").keyup(function(event){
      if(event.keyCode == 13){
          $("#controller_filter_input_btn").click();
      }
  });

  $("#action_with_filter_input").keyup(function(event){
      if(event.keyCode == 13){
          $("#action_with_filter_input_btn").click();
      }
  });

  $("#action_without_filter_input").keyup(function(event){
      if(event.keyCode == 13){
          $("#action_without_filter_input_btn").click();
      }
  });
});

function clearLocalFilters() {
    var x;
    if (confirm("Are you sure you want to clear your saved filters?") == true) {
      alert(gon.controllers);
      console.log("Clearing local storage");
    }
}

function action_with_filter() {
  console.log("TODO: Implement action_with_filter()");
}

function action_without_filter() {
  console.log("TODO: Implement action_without_filter()");
}
function removeWithoutActionItem() {
  //TODO: Implement this
  console.log("TODO: IMPLEMENT removeWithoutActionItem()");
}


function removeWithActionItem() {
  //TODO: Implement this
  console.log("TODO: IMPLEMENT removeWithActionItem()");
}

function removeController() {
  //TODO: Implement this
  console.log("TODO: IMPLEMENT removeController()");
}

function removeControllerFromList(id) {

}

function filterController() {
  var filter_input = $("#controller_filter_input")[0];

  // Clear the value in the input field
  var rows = $("#callbackBreakdownTbl").find("tr.callback_lineitem").hide();
  if (filter_input.value.length) {
      // Add the filter to the global array of controller filters
      window.controller_filters.push(filter_input.value);

      // Add this filter to the controller filter list group
      update_controller_filter_list(filter_input.value);

      var data = window.controller_filters;
      $.each(data, function (i, v) {
          rows.filter(":contains('" + v + "')").show();
      });
  } else rows.show();

  $("#controller_filter_input").val('');
  check_for_empty_controller_list();
}

function update_controller_filter_list(filter) {

  // Add the filter to the include-controllers list group
  build_list_group_item(filter);
}

function build_list_group_item(filter) {
  console.log(window.controller_filters);
  var list_item = $('<a>',{
      text: filter,
      href: '#',
      onclick: "removeController()",
      class: "list-group-item"
  })

  $('<span>', {
    class: "glyphicon glyphicon-remove pull-right list-group-span",
    "aria-hidden": true
  }).appendTo(list_item);

  list_item.appendTo('#include-controllers');
}

function check_for_empty_controller_list() {
  // Show or Hide the "No controller filters currently set" based on if if the
  // list is empty
  if(window.controller_filters.length == 0) {
    $("#include-controllers").find("li.list-group-item").show();
  } else {
    $("#include-controllers").find("li.list-group-item").hide();
  }
}

